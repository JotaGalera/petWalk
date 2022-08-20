//
//  SetupPetNameView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 9/6/22.
//

import SwiftUI

struct SetupPetNameView: View {
    @State var petName: String = ""
    @State var isSecureQuestionShowed: Bool = false
    
    @StateObject var setupPetNameViewModel: SetupPetNameViewModel
    
    init(setupPetNameViewModel: SetupPetNameViewModel) {
        _setupPetNameViewModel = StateObject(wrappedValue: setupPetNameViewModel)
    }
    
    var body: some View {
        if setupPetNameViewModel.continueWithNextView {
            PetViewFactory().make()
        } else {
            VStack {
                Text("What is your pet name?")
                    .padding([.top, .bottom])
                
                TextField("Tap here ...", text: $petName)
                    .padding()
                
                ContinueButton {
                    isSecureQuestionShowed.toggle()
                }
                .sheet(isPresented: $isSecureQuestionShowed,
                       content: {
                    SecureQuestionViewFactory().make(petName: $petName)
                })
            }
            .onAppear {
                setupPetNameViewModel.canContinueWithNextView()
            }
        }
    }
}

struct SetupPetNameView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPetNameViewFactory().make()
    }
}

