//
//  Player.swift
//  dual-fighter
//
//  Created by Romain Pardon on 23/07/2016.
//  Copyright © 2016 SlasherApp. All rights reserved.
//

import Foundation

class Player : Character{
    
    override init() {
        super.init()
        self.hp = 100
        self.attackPwr = 50
        self.name = "Player"
    }
}