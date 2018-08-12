//
//  Charactor.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 29.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Charactor {
    var dieFight : Bool{
        if fightStats.fightHP <= 0{
            return true
        }
        return false
    }
    var name = ""
    var inventery = Inventery()
    var fightStats = FightStats()
    
    
}
