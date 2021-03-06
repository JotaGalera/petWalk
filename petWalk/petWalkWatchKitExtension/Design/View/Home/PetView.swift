//
//  PetView.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 3/1/22.
//

import SwiftUI

struct PetView: View {
    private let deviceSize = WKInterfaceDevice.current().screenBounds
    
    @StateObject var petViewModel: PetViewModel
    
    init(viewModel: PetViewModel) {
        _petViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer(minLength: 10)
                
                petAnimationScene(pet: petViewModel.pet)
                    .padding()
                
                StatusBarMenu(strengthValue: petViewModel.pet.getStrength(),
                              lifeValue: petViewModel.pet.getLife(),
                              expToRaiseNextLevel: petViewModel.pet.getExpToRaiseNextLevel())
            }
        }
        .frame(width: deviceSize.width,
                height: deviceSize.height)
        .task {
            await petViewModel.requestPermissions()
        }
    }
}

struct StatusBarMenu: View {
    private let swordImageName = "Sword"
    private let hearthImageName = "Heart"
    private let swordAccessibilityIdentifer = "strength"
    private let lifeAccessibilityIdentifer = "life"
    
    let strengthValue: Int
    let lifeValue: Int
    let expToRaiseNextLevel: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ItemBarMenu(imageName: swordImageName,
                        valueText: String(strengthValue),
                        accessibilityIdentifer: swordAccessibilityIdentifer,
                        expToRaiseNextLevel: expToRaiseNextLevel)
            .padding(.leading)
            ItemBarMenu(imageName: hearthImageName,
                        valueText: String(lifeValue),
                        accessibilityIdentifer: lifeAccessibilityIdentifer,
                        expToRaiseNextLevel: expToRaiseNextLevel)
            .padding(.trailing)
        }
    }
}

struct ItemBarMenu: View {
    let width: CGFloat = 25
    let height: CGFloat = 25
    
    let imageName: String
    let valueText: String
    let accessibilityIdentifer: String
    
    let expToRaiseNextLevel: Int
    
    var body: some View {
        HStack {
            NavigationLink(destination: PetDataViewFactory().make(expToRaiseNextLevel: expToRaiseNextLevel)) {
                Image(imageName)
                    .resizable()
                    .frame(width: width,
                           height: height,
                           alignment: .center)
                    .accessibilityIdentifier(accessibilityIdentifer)
                
                Text(valueText)
            }
        }
    }
}

struct PetView_Previews: PreviewProvider {
    static var previews: some View {
        PetViewFactory().make()
    }
}
