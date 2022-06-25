//
//  SetupPetView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 9/6/22.
//

import SwiftUI

struct SetupPetView: View {
    private let continueButtonText = "Continue"
    @State var petName: String = ""
    @State var isSecureQuestionShowed: Bool = false
    
    @StateObject var setupPetViewModel: SetupPetViewModel
    
    init(setupPetViewModel: SetupPetViewModel) {
        _setupPetViewModel = StateObject(wrappedValue: setupPetViewModel)
    }
    
    var body: some View {
        if setupPetViewModel.hasPetName {
            PetViewFactory().make()
        } else {
            VStack {
                Text("What is your pet name?")
                    .padding([.top, .bottom])
                
                TextField("Tap here ...", text: $petName)
                    .padding()
                    
                Button {
                    isSecureQuestionShowed.toggle()
                } label: {
                    Text(continueButtonText)
                        .foregroundColor(.blue)
                }
                .buttonStyle(.borderless)
                .padding()
                .sheet(isPresented: $isSecureQuestionShowed,
                       content: {
                    SecureQuestionViewFactory().make(petName: $petName)
                })
            }
            .onAppear {
                setupPetViewModel.checkPetHasName()
            }
        }
    }
}

struct SetupPetView_Previews: PreviewProvider {
    static var previews: some View {
        SetupViewFactory().make()
    }
}

