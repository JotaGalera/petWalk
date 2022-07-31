//
//  PetDataView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/2/22.
//

import SwiftUI

struct PetDataView: View {
    private let deviceSize = WKInterfaceDevice.current().screenBounds
    
    @StateObject var petDataViewModel: PetDataViewModel
    
    @State var pendingFetch: Bool = false
    
    init(viewModel: PetDataViewModel) {
        _petDataViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Exp: \(petDataViewModel.currentSteps)")
                    .accessibilityIdentifier("Exp")
                Text("Next Lvl: \(petDataViewModel.expToRaiseNextLevel - petDataViewModel.currentSteps)")
                    .accessibilityIdentifier("NextLevel")
            }
            if pendingFetch {
                Animation()
            }
        }
        .frame(width: deviceSize.width, height: deviceSize.height/1.6)
        .task() {
            await petDataViewModel.getSteps()
            petDataViewModel.getPreviousProgressAnimation()
            
            DispatchQueue.main.async {
                pendingFetch = true
            }
        }
        .environmentObject(petDataViewModel)
    }
}

struct Animation: View {
    private let endCircleShape = 0.8
    
    @State var progressUntilNextLevel = 0.0
    
    @State var newExp: Int = 0
    @State var levelUpExp: Int = 0
    @State var previousExpAnimated: Double = 0
    @State var shouldNewLevelAnimationBeDisplayed = false
    
    @EnvironmentObject var petDataViewModel: PetDataViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: endCircleShape)
                .rotation(Angle(degrees: 125))
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .fill(.blue)
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: previousExpAnimated + progressUntilNextLevel)
                        .rotation(Angle(degrees: 125))
                        .stroke(style: StrokeStyle(lineWidth: 9, lineCap: .round, lineJoin: .round))
                        .fill(Color.orange)
                )
            
            if shouldNewLevelAnimationBeDisplayed {
                LevelUpAnimationScene()
            }
        }
        .animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0), value: previousExpAnimated + progressUntilNextLevel)
        .onAppear {
            newExp = petDataViewModel.animationDailySteps
            levelUpExp = petDataViewModel.expToRaiseNextLevel
            previousExpAnimated = petDataViewModel.previousAnimationProgress
            shouldNewLevelAnimationBeDisplayed = petDataViewModel.hasPetRaisedANewLevel
            
            if newExp > 0 || shouldNewLevelAnimationBeDisplayed {
                if newExp == 0 {
                    progressUntilNextLevel = 0
                } else {
                    let newPercentage = Double(newExp) / Double(levelUpExp)
                    
                    progressUntilNextLevel = newPercentage * endCircleShape
                }
                petDataViewModel.savePreviousProgressAnimation(progressUntilNextLevel + previousExpAnimated)
            } else {
                let oldPercentage = Double(petDataViewModel.currentSteps) / Double(levelUpExp)
                
                progressUntilNextLevel = oldPercentage * endCircleShape
                previousExpAnimated = 0
            }
        }
    }
}

struct PetDataView_Previews: PreviewProvider {
    static var previews: some View {
        PetDataViewFactory().make(expToRaiseNextLevel: 100,
                                  pet: Swordman(name: "Beldrick", level: Level(), stats: Stats()))
    }
}
