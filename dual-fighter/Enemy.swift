//
//  Enemy.swift
//  dual-fighter
//
//  Created by Romain Pardon on 24/07/2016.
//  Copyright © 2016 SlasherApp. All rights reserved.
//

import Foundation

class Enemy: Character {
    override init(){
        super.init()
        self.hp = 120
        self.attackPwr = 40
        self.name = "Enemy"
    }
}