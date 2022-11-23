//
//  Stats.swift
//  petWalk
//
//  Created by Galera, Javier on 23/11/22.
//

struct Stats: Equatable {
    let baseValue = 10
    var strength = 10
    var life = 10
    
    init(currentLevel: Int) {
        calculateStrengthAndLife(currentLevel)
    }
    
    mutating func calculateStrengthAndLife(_ currentLevel: Int) {
        guard currentLevel > 1 else { return }
        
        let evenNumber = currentLevel / 2
        let oddNumber = currentLevel % 2 == 0 ? evenNumber : evenNumber + 1
        
        strength = baseValue + (1 * evenNumber + 2 * oddNumber)
        life = baseValue + (2 * evenNumber + 1 * oddNumber)
    }
}
