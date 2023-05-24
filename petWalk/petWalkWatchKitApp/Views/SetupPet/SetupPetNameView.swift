//
//  SetupPetNameView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 9/6/22.
//

import SwiftUI

struct SetupPetNameView: View {
    @Binding var isRolSelected: Bool
    
    @State var petName: String = ""
    @State var isSecureQuestionShowed: Bool = false
    
    @StateObject var setupPetNameViewModel: SetupPetNameViewModel
    
    init(setupPetNameViewModel: SetupPetNameViewModel, isRolSelected: Binding<Bool>) {
        _setupPetNameViewModel = StateObject(wrappedValue: setupPetNameViewModel)
        _isRolSelected = isRolSelected
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
                    SecureQuestionViewFactory().make(petName: $petName, isRolSelected: $isRolSelected)
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
        SetupPetNameViewFactory().make(isRolSelected: .constant(true))
    }
}

