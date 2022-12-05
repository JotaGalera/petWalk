//
//  SetupPetNameView.swift
//  petWalk
//
//  Created by Galera, Javier on 1/12/22.
//

import SwiftUI

struct SetupPetNameView: View {
    @State var continueWithNextView: Bool = false
    @StateObject var viewModel: SetupPetNameViewModel
    
    @State var petName: String = ""
    @State var isSecureQuestionShowed: Bool = false
    
    init(setupPetRolViewModel: SetupPetNameViewModel) {
        _viewModel = StateObject(wrappedValue: setupPetRolViewModel)
    }
    
    var body: some View {
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
                //SecureQuestionViewFactory().make(petName: $petName, isRolSelected: $isRolSelected)
            })
        }
        .onAppear {
            
        }
    }
}

//struct SetupPetNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetupPetNameView()
//    }
//}
