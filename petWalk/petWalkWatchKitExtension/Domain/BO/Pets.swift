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
    var stats: Stats { get }
    var level: Level { get }
    
    mutating func levelUp()
    func getStrength() -> Int
    func getLife() -> Int
    func getExpToRaiseNextLevel() -> Int
}

struct Swordman: Pets, Equatable {
    var name: String
    var images: [String] = ["run1",
                            "run2",
                            "run3",
                            "run4",
                            "run5",
                            "run6",
                            "run7",
                            "run8"]
    var stats: Stats
    var level: Level
    
    init(name: String, level: Level, stats: Stats) {
        self.name = name
        self.level = level
        self.stats = stats
    }
    
    mutating func levelUp() {
        level.levelUp()
        
        stats.increaseStats(level.currentLevel)
    }
    
    func getStrength() -> Int {
        return stats.strength
    }
    
    func getLife() -> Int {
        return stats.life
    }
    
    func getExpToRaiseNextLevel() -> Int {
        return level.expToLevelUp
    }
}

