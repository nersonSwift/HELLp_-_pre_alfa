//
//  Enemy.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 29.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Enemy: Charactor {
    
    var taunt     = false
    var boss      = false
    

    override init() {
        super.init()
        fightStats = FightStatsEnemy()
    }
    
    func dropItem() -> Item? {
        return nil
    }
    
}
