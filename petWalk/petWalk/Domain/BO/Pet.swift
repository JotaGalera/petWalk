//
//  Pets.swift
//  petWalk
//
//  Created by Galera, Javier on 23/11/22.
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
    func getRolImages() -> [String]
}

struct Pet: Pets {
    var name: String
    var stats: Stats
    var level: Level
    var rol: Rol
    
    init(name: String, rol: Rol, level: Level) {
        self.name = name
        self.level = level
        self.rol = rol
        self.stats = Stats(currentLevel: level.currentLevel)
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
    
    func getRolImages() -> [String] {
        return rol.images
    }
}


