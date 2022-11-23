//
//  Level.swift
//  petWalk
//
//  Created by Galera, Javier on 23/11/22.
//

struct Level: Equatable {
    var currentLevel: Int
    var expToLevelUp: Int = 100
    private let expBaseToLevelUp = 100
    
    init(currentLevel: Int = 1) {
        self.currentLevel = currentLevel
    }
    
    mutating func levelUp() {
        currentLevel += 1
        calculateNextExpToLevelUp()
    }
    
    // In order to calculate the next experience to level up use:
    // (100 * n) + (100 * n-1) + (100 * n-2) + ...
    // i.e: to reach level 3: (100 * 3) + (100 * 2) + (100 * 1) = 600
    mutating func calculateNextExpToLevelUp() {
        expToLevelUp = 0
        for i in 0...currentLevel {
            expToLevelUp += expBaseToLevelUp * i
        }
    }
}
