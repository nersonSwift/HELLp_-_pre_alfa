//
//  BarainFightAren.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 03.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class BrainFightAren{
    weak var fightAren: FightAren?
    weak var room: Room?
    weak var player: Player?
    
    var selectEnemy: EnemyInAren?
    
    func setSelectEnemy(enemyInAren: EnemyInAren){
        selectEnemy = enemyInAren
    }
    
    func PlayerStep(){
        selectEnemy!.enemy!.fightStats.takeDMG(charactor: selectEnemy!.enemy!, dmg: player!.fightStats.attackDmg)
    }
    
    func checkEnemysLive(){
        var killTrig = false
        for i in (0 ..< fightAren!.liveEnemy.count).reversed(){
            print(i)
            if fightAren!.liveEnemy[i].enemy!.fightStats.fightHP <= 0{
                
                fightAren!.liveEnemy[i].die()
                fightAren!.liveEnemy.remove(at: i)
                
                killTrig = true
            }
        }
        
        if killTrig{
            fightAren?.swipeEnemy(newSelectEnemy: fightAren!.selectingEnemy(dir: .Right))
        }
        
        if fightAren!.liveEnemy.count == 0{
            room?.enemys = []
            player?.fightStats.endFight(player: player!)
            fightAren?.endFight()
        }
    }
    
    func EnemyStep(){
        
        for i in fightAren!.liveEnemy{
            player?.fightStats.takeDMG(charactor: player!, dmg: i.enemy!.fightStats.attackDmg)
            print(player!.fightStats.fightHP)
        }
        
    }
    
    func checkPlayerLive(){
        if player!.fightStats.fightHP <= 0{
            player!.fightStats.endFight(player: player!)
            fightAren!.endFight()
        }
    }
    
    func startFight() {
        
        player?.fightStats.startFight(charactor: player!)
        for i in room!.enemys{
            i.fightStats.startFight(charactor: i)
        }
    }
}
