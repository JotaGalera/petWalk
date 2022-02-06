//
//  ContentView.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 3/1/22.
//

import SwiftUI

struct ContentView: View {
    private let petMock = Swordman(name: "Beldrick")
    private let contentViewConfigurator = ContentViewConfigurator()
    @ObservedObject var contentViewModel: ContentViewModel
    
    init() {
        self.contentViewModel = contentViewConfigurator.configure()
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(String(contentViewModel.currentSteps))
            petAnimationScene(pet: petMock)
            
            Spacer()
            
            StatusBarMenu()
        }
        .onAppear {
            contentViewModel.requestPermissions()
        }
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
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 25,
                       height: 25,
                       alignment: .center)
            Text("10")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    let contentViewModel = ContentViewConfigurator().configure()
    
    static var previews: some View {
        ContentView()
    }
}
