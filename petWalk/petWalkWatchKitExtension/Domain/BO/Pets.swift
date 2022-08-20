//
//  Pets.swift
//  petWalk WatchKit Extension
//
//  Created by Galera, Javier on 8/1/22.
//

import Foundation

protocol Pets: AutoMockable {
    var name: String { get }
    var stats: Stats { get }
    var level: Level { get }
    var rol: Rol { get }
    
    mutating func levelUp()
    func getStrength() -> Int
    func getLife() -> Int
    func getCurrentLevel() -> Int
    func getExpToRaiseNextLevel() -> Int
}

struct Pet: Pets, Equatable {
    var name: String
    var rol: Rol
    var stats: Stats
    var level: Level
    
    init(name: String, level: Level) {
        self.name = name
        self.level = level
        self.stats = Stats(currentLevel: level.currentLevel)
        self.rol = Swordman()
    }
    
    mutating func levelUp() {
        level.levelUp()
        
        stats.calculateStrengthAndLife(level.currentLevel)
    }
    
    func getStrength() -> Int {
        return stats.strength
    }
    
    func getLife() -> Int {
        return stats.life
    }
    
    func getCurrentLevel() -> Int {
        return level.currentLevel
    }
    
    func getExpToRaiseNextLevel() -> Int {
        return level.expToLevelUp
    }
    
    static func == (lhs: Pet, rhs: Pet) -> Bool {
        return lhs.name == rhs.name &&
            lhs.stats == rhs.stats &&
            lhs.level == rhs.level &&
            lhs.rol.classname == rhs.rol.classname &&
            lhs.rol.images == rhs.rol.images
    }
}

