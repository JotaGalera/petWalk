//
//  Level.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 4/6/22.
//

struct Level: Equatable {
    var currentLevel: Int = 1
    var expToLevelUp: Int = 100
    private let expBaseToLevelUp = 100
    
    mutating func levelUp() {
        calculateNextExpToLevelUp()
        currentLevel += 1
    }
    
    // In order to calculate the next experience to level up use:
    // (100 * n) + (100 * n-1) + (100 * n-2) + ...
    // i.e: to reach level 3: (100 * 3) + (100 * 2) + (100 * 1) = 600
    mutating func calculateNextExpToLevelUp() {
        expToLevelUp = 0
        for i in 0...(currentLevel + 1) {
            expToLevelUp += expBaseToLevelUp * i
        }
    }
}
