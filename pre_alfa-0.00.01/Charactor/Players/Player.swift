//
//  Player.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 07.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit


class Player: Charactor {
    var dieGame : Bool{
        if stats.hP <= 0{
            return true
        }
        return false
    }
    var stats = StatsPlayer()
    var x = 0
    var y = 0
    var xy: String{
        return String(x) + String(y)
    }
    
    public func DMG(dmg: Int){
        self.stats.hP -= dmg
    }
    override init() {
        super.init()
        fightStats = FightStatsPlayer()
    }
    
}

