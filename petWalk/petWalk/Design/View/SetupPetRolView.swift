//
//  SetupPetRolView.swift
//  petWalk
//
//  Created by Galera, Javier on 3/11/22.
//

import SwiftUI

struct SetupPetRolView: View {
    @StateObject var setupPetRolViewModel = SetupPetRolViewModel()
    
    var body: some View {
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
            }
        }
    }
}

struct SetupPetRolView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPetRolView()
    }
}
