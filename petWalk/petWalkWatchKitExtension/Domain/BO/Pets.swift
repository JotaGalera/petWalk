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
}

struct Level {
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

struct Stats {
    var power: Int
    var life: Int
    
    init(power: Int = 10, life: Int = 10) {
        self.power = power
        self.life = life
    }
    
    mutating func increaseStats(_ newLevel: Int) {
        increasePower(newLevel)
        increaseLife(newLevel)
    }
    
    mutating private func increasePower(_ newLevel: Int) {
        power += newLevel % 2 == 0 ? 1 : 2
    }
    
    mutating private func increaseLife(_ newLevel: Int) {
        life += newLevel % 2 == 0 ? 2 : 1
    }
}
