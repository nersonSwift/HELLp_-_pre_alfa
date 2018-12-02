//
//  FightStatsPlayer.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 29.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class FightStatsPlayer: FightStats {
    var dieTriger = true
    
    override func startFight(charactor: Charactor){
        let player = charactor as! Player
        let kHP = 10
        
        startFightHP = player.stats.hP * kHP
        fightHP = startFightHP
        
        if player.stats.hP <= 1{
            dieTriger = true
        }else{
            dieTriger = false
        }
    }
    
    override func endFight(player: Player){
        let a = Double(fightHP) / (Double(startFightHP) / 100.0)
        print(a)
        
        switch a {
            case ...0:
                player.stats.hP -= 2
                if (player.stats.hP <= 0) && !dieTriger{
                    player.stats.hP = 1
                }
            case 1...49:
                player.stats.hP -= 1
                if (player.stats.hP <= 0) && dieTriger{
                    player.stats.hP = 1
                }
            case 50...100: break
        default: break
        }
        print(player.stats.hP)
    }
    
    override init() {
        super.init()
        maxFightHP = 100
    }
}
