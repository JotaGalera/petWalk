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
            VStack {
                Spacer()
                
                petAnimationScene(pet: petMock)
                
                Spacer()
                
                StatusBarMenu()
                
                Spacer()
            }
        }
        .frame(width: deviceSize.width,
                height: deviceSize.height)
        .task {
            await contentViewModel.requestPermissions()
        }
        .environmentObject(contentViewModel)
    }
}

struct StatusBarMenu: View {
    var body: some View {
        HStack {
            ItemBarMenu(imageName: "Sword",
                        valueText: "10")
            ItemBarMenu(imageName: "Heart",
                        valueText: "10")
        }
    }
}

struct ItemBarMenu: View {
    let width: CGFloat = 25
    let height: CGFloat = 25
    var imageName: String
    var valueText: String
    
    @EnvironmentObject var contentViewModel: PetViewModel
    
    var body: some View {
        HStack {
            NavigationLink(destination: PetDataView()) {
                Image(imageName)
                    .resizable()
                    .frame(width: 25,
                           height: 25,
                           alignment: .center)
                
                Text("10")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PetView()
    }
}
