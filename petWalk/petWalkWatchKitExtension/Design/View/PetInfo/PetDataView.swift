//
//  PetDataView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/2/22.
//

import SwiftUI

struct PetDataView: View {
    private let petDataViewConfigurator = PetDataViewConfigurator()
    
    @ObservedObject var petDataViewModel: PetDataViewModel
    
    @State var pendingFetch: Bool = false
    
    init() {
        petDataViewModel = petDataViewConfigurator.configure()
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Exp: \(petDataViewModel.currentSteps)")
                    .accessibilityIdentifier("Exp")
                Text("Next Lvl: \(petDataViewModel.levelUpExp - petDataViewModel.currentSteps)")
                    .accessibilityIdentifier("NextLevel")
            }
            
            if pendingFetch {
                Animation(newExp: petDataViewModel.animationDailySteps,
                      levelUpExp: petDataViewModel.levelUpExp,
                      previousExpAnimated: petDataViewModel.previousAnimationProgress)
            }
        }
        .task() {
            await petDataViewModel.getDailySteps()
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
    
    @State var newExp: Int
    @State var levelUpExp: Int
    @State var previousExpAnimated: Double
    
    @EnvironmentObject var petDataViewModel: PetDataViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
            .overlay(
                Circle()
                    .trim(from: 0.0, to: previousExpAnimated + progressUntilNextLevel)
                    .rotation(Angle(degrees: 125))
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                    .fill(Color.red)
            )
        }
        .animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0), value: previousExpAnimated + progressUntilNextLevel)
        .onAppear {
            if newExp > 0 {
                let newPercentage = Double(newExp) / Double(levelUpExp)
                
                progressUntilNextLevel = newPercentage * endCircleShape
                
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
        PetDataView()
    }
}
