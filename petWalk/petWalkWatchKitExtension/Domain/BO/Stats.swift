//
//  Stats.swift
//  petWalkWatchKitExtension
//
//  Created by Galera, Javier on 4/6/22.
//

struct Stats: Equatable {
    var strength: Int
    var life: Int
    
    init(strength: Int = 10, life: Int = 10) {
        self.strength = strength
        self.life = life
    }
    
    mutating func increaseStats(_ newLevel: Int) {
        increaseStrength(newLevel)
        increaseLife(newLevel)
    }
    
    mutating private func increaseStrength(_ newLevel: Int) {
        strength += newLevel % 2 == 0 ? 1 : 2
    }
    
    mutating private func increaseLife(_ newLevel: Int) {
        life += newLevel % 2 == 0 ? 2 : 1
    }
}
