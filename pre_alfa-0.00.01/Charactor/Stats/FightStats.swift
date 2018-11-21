//
//  FIghtStats.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 29.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class FightStats{
    
    var fightHP         = 0
    var startFightHP    = 0
    var maxFightHP      = 0
    var attackDmg       = 0
    
    
    func startFight(charactor: Charactor){}
    
    func endFight(player: Player){}
    
    func takeDMG(dmg: Int){
        fightHP -= dmg
    }
}
