//
//  Skeleton.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 12.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Skeleton: Enemy {
    override init() {
        super.init()
        name = "Skeleton"
        taunt = false
        fightStats.maxFightHP = 20
        fightStats.attackDmg = 3
    }
    
    override func dropItem() -> Item? {
        switch arc4random_uniform(100) {
        case 0...49:
            let key = Key()
            key.quantity = 1
            return key
        case 50...99: return nil
            
        default: return nil
        }
    }
}
