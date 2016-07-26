//
//  Character.swift
//  dual-fighter
//
//  Created by Romain Pardon on 25/07/2016.
//  Copyright © 2016 SlasherApp. All rights reserved.
//

import Foundation

class Character {
    
    var hp: Int = 0
    var attackPwr: Int = 0
    var name: String = ""
    
    init() {}
    
    func beAttacked(attackPwr: Int) {
        hp -= attackPwr
    }
    
    func isAlive() -> Bool {
        if hp <= 0 {
            return false
        }
        return true
    }
    
    func randomizeAttackPower() -> Int {
        return Int(arc4random_uniform(UInt32(attackPwr)))
    }
}