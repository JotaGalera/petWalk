//
//  petAnimationScene.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 8/1/22.
//

import SwiftUI

struct petAnimationScene: View {
    var pet: Pets
    
    var body: some View {
        VStack {
            Text(pet.name)
                .bold()
                .padding(.bottom)
            PetAnimation(petImages: pet.getRolImages())
        }
    }
}
struct petAnimationScene_Previews: PreviewProvider {
    static var previews: some View {
        petAnimationScene(pet: Pet(name: "Beldrick", rol: Swordman(), level: Level()))
    }
}
