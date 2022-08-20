//
//  SetupPetRolView.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 15/8/22.
//

import SwiftUI

struct SetupPetRolView: View {
    @State var rolIndex = 0
    
    var roles: [Rol] = [Swordman(), Ninja(), Wizard()]
    
    
    var body: some View {
        VStack {
            Text("Which is your pet rol?")
                .padding([.top, .bottom])
            
            HStack {
                ArrowButton(action: {
                    rolIndex = (rolIndex + 2) % 3
                }, imageName: "arrowtriangle.left.circle.fill")
                
                Spacer()
                
                PetAnimation(petImages: roles[rolIndex].images)
                
                Spacer()
                
                ArrowButton(action: {
                    rolIndex = (rolIndex + 1) % 3
                }, imageName: "arrowtriangle.right.circle.fill")
            }
        }
    }
}

struct ArrowButton: View {
    var action: () -> Void
    var imageName: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 25, height: 25)
        }
        .buttonStyle(.borderless)
    }
}

struct SetupPetRolView_Previews: PreviewProvider {
    static var previews: some View {
        SetupPetRolView()
    }
}
