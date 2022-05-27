//
//  PetView.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 3/1/22.
//

import SwiftUI

struct PetView: View {
    private let petMock = Swordman(name: "Beldrick")
    private let contentViewConfigurator = PetViewConfigurator()
    
    private let deviceSize = WKInterfaceDevice.current().screenBounds
    
    @ObservedObject var contentViewModel: PetViewModel
    
    init() {
        self.contentViewModel = contentViewConfigurator.configure()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer(minLength: 10)
                
                petAnimationScene(pet: petMock)
                    .padding()
                
                StatusBarMenu()
            }
        }
        .frame(width: deviceSize.width,
                height: deviceSize.height)
        .task {
            await contentViewModel.requestPermissions()
        }
    }
}

struct StatusBarMenu: View {
    var body: some View {
        HStack(spacing: 8) {
            ItemBarMenu(imageName: "Sword",
                        valueText: "10",
                        accessibilityIdentifer: "strength")
            .padding(.leading)
            ItemBarMenu(imageName: "Heart",
                        valueText: "10",
                        accessibilityIdentifer: "life")
            .padding(.trailing)
        }
    }
}

struct ItemBarMenu: View {
    let width: CGFloat = 25
    let height: CGFloat = 25
    var imageName: String
    var valueText: String
    var accessibilityIdentifer: String
    
    var body: some View {
        HStack {
            NavigationLink(destination: PetDataView()) {
                Image(imageName)
                    .resizable()
                    .frame(width: width,
                           height: height,
                           alignment: .center)
                    .accessibilityIdentifier(accessibilityIdentifer)
                
                Text("10")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PetView()
    }
}
