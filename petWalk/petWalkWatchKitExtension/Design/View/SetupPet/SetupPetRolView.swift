//
//  SetupPetRolView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 15/8/22.
//

import SwiftUI

struct SetupPetRolView: View {
    @State var continueButtonSelected: Bool = false
    @StateObject var setupPetRolViewModel: SetupPetRolViewModel
    
    init(setupPetRolViewModel: SetupPetRolViewModel) {
        _setupPetRolViewModel = StateObject(wrappedValue: setupPetRolViewModel)
    }
    
    var body: some View {
        if continueButtonSelected {
            SetupPetNameViewFactory().make(isRolSelected: $continueButtonSelected)
        } else {
            VStack {
                Text("Which is your pet rol?")
                    .padding([.top, .bottom])
                
                HStack {
                    ArrowButton(action: {
                        setupPetRolViewModel.showPreviousRol()
                    }, imageName: "arrowtriangle.left.circle.fill")
                    
                    Spacer()
                    
                    PetAnimation(petImages: setupPetRolViewModel.showRolImages())
                    
                    Spacer()
                    
                    ArrowButton(action: {
                        setupPetRolViewModel.showNextRol()
                    }, imageName: "arrowtriangle.right.circle.fill")
                }
                
                ContinueButton {
                    setupPetRolViewModel.savePetRol()
                    continueButtonSelected.toggle()
                }
            }
        }
    }
}



struct SetupPetRolView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPetRolViewFactory().make()
    }
}
