//
//  FightStatsEnemy.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 29.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class FightStatsEnemy: FightStats {
    
    override func startFight(charactor: Charactor) {
        let enemy = charactor as! Enemy
        enemy.fightStats.fightHP = enemy.fightStats.maxFightHP
    }
    
}
