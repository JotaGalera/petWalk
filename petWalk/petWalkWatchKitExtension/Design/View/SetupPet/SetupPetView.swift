//
//  SetupPetView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 9/6/22.
//

import SwiftUI

struct SetupPetView: View {
    @State var petName: String = ""
    @State var isSecureQuestionShowed: Bool = false
    @State var hasPetName: Bool = false
    let continueButtonText = "Continue"
    
    var body: some View {
        if hasPetName {
            PetView()
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
                    SecureQuestionView(hasPetName: $hasPetName)
                })
            }
        }
    }
}

struct SetupPetView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPetView()
    }
}

