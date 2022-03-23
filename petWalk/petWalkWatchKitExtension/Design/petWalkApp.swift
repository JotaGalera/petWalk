//
//  petWalkApp.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 3/1/22.
//

import SwiftUI

@main
struct petWalkApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PetView()
            }
        }
    }
}
