//
//  SetupPetRolView.swift
//  petWalk
//
//  Created by Galera, Javier on 3/11/22.
//

import SwiftUI

struct SetupPetRolView: View {
    @State var continueWithNextView: Bool = false
    @StateObject var viewModel: SetupPetRolViewModel
    
    init(setupPetRolViewModel: SetupPetRolViewModel) {
        _viewModel = StateObject(wrappedValue: setupPetRolViewModel)
    }
    
    var body: some View {
        if continueWithNextView {
            //show nextView
        } else {
            VStack {
                Text("Which is your pet rol?")
                    .padding([.top, .bottom])
                
                HStack {
                    ArrowButton(action: {
                        viewModel.showPreviousRol()
                    }, imageName: "arrowtriangle.left.circle.fill")
                    
                    Spacer()
                    
                    PetAnimation(petImages: viewModel.showRolImages())
                    
                    Spacer()
                    
                    ArrowButton(action: {
                        viewModel.showNextRol()
                    }, imageName: "arrowtriangle.right.circle.fill")
                }
                
                ContinueButton {
                    viewModel.savePetRol()
                    continueWithNextView = viewModel.canContinueWithNextView()
                }
            }
        }
    }
}

//struct SetupPetRolView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetupPetRolView()
//    }
//}
