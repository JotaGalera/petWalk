//
//  Pets.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 8/1/22.
//

import Foundation

protocol Pets {
    var name: String { get }
    var images: [String] { get }
    var power: Int { get }
    var life: Int { get }
}

struct Swordman: Pets {
    var name: String
    var images: [String] = ["run1",
                            "run2",
                            "run3",
                            "run4",
                            "run5",
                            "run6",
                            "run7",
                            "run8"]
    var power: Int = 10
    var life: Int = 10
    
    init(name: String) {
        self.name = name
    }
}
