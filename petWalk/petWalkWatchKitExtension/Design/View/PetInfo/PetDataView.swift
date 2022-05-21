//
//  PetDataView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 20/2/22.
//

import SwiftUI

struct PetDataView: View {
    private let petDataViewConfigurator = PetDataViewConfigurator()
    
    @State var levelUpExp: Int = 100 // TODO: this value has to be provided by PetViewModel
    
    @ObservedObject var petDataViewModel: PetDataViewModel
    
    init() {
        petDataViewModel = petDataViewConfigurator.configure()
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("Exp: \(petDataViewModel.currentSteps)")
                    .accessibilityIdentifier("Exp")
                Text("Next Lvl: \(levelUpExp - petDataViewModel.currentSteps)")
                    .accessibilityIdentifier("NextLevel")
            }
            Animation(newExp: $petDataViewModel.animationDailySteps,
                      levelUpExp: $levelUpExp,
                      previousExpAnimated: $petDataViewModel.previousAnimationProgress)
        }
        .onAppear {
            Task {
                await petDataViewModel.getDailySteps()
                //await petDataViewModel.getPreviousProgressAnimation()
            }
        }
        .environmentObject(petDataViewModel)
    }
}

struct Animation: View {
    private let endCircleShape = 0.8
    
    @State var progressUntilNextLevel = 0.0
    
    @Binding var newExp: Int
    @Binding var levelUpExp: Int
    @Binding var previousExpAnimated: Double
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
            .overlay(
            Circle()
                .trim(from: self.previousExpAnimated, to: self.progressUntilNextLevel)
                .rotation(Angle(degrees: 125))
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .fill(Color.red)
            )
        }
        .animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0), value: self.progressUntilNextLevel)
        .onAppear {
            self.progressUntilNextLevel = ( (Double(newExp) * endCircleShape) / Double(levelUpExp) / 10 ) + previousExpAnimated
            
            // Save progressUntilNextLevel as newPreviousExpAnimated
            //PetDataViewModel.savePreviousProgressAnimation()
        }
    }
    
    private func calculateNewPath() {
        
        
    }
}

struct PetDataView_Previews: PreviewProvider {
    static var previews: some View {
        PetDataView()
    }
}
