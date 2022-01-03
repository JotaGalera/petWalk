//
//  ContentView.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 3/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            PetScene(petImageName: "pet",
                     petName: "Beldrick")
            Spacer()
            StatusBarMenu()
        }
    }
}

struct PetScene: View {
    let width: CGFloat = 80
    let height: CGFloat = 80
    var petImageName: String
    var petName: String
    
    var body: some View {
        VStack {
            Text(petName)
                .bold()
            Spacer().frame(height: 15)
            Image(petImageName)
                .resizable()
                .frame(width: width,
                       height: height,
                       alignment: .center)
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
    static var previews: some View {
        ContentView()
    }
}
