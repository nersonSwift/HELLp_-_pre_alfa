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
    weak var castPlayer: CastPlayer!
    var player: Player{
        return castPlayer.player
    }
    var selectEnemy: EnemyInAren?
    var cardsInHand: [Card] = []
    var chest: [StackItem] = []
    
    var allEnemy: [Enemy]{
        var a: [Enemy] = []
        for i in fightAren!.liveEnemy{
            a.append(i.enemy!)
        }
        return a
    }
    
    func setSelectEnemy(enemyInAren: EnemyInAren){
        selectEnemy = enemyInAren
    }
    
    func PlayerStep(){
        fightAren?.selectCard?.card.effect(player: player, selectEnemy: selectEnemy!.enemy, allEnemy: allEnemy)
    }
    
    func setCardsInHand(){
        cardsInHand = []
        for _ in 0...2{
            let a = arc4random_uniform(UInt32(player.stats.cards.count))
            print(player.stats.cards[Int(a)].name)
            cardsInHand.append(player.stats.cards[Int(a)])
        }
    }
    
    func checkEnemysLive(){
        var killTrig = false
        for i in (0 ..< fightAren!.liveEnemy.count).reversed(){
            print(i)
            if fightAren!.liveEnemy[i].enemy!.fightStats.fightHP <= 0{
                
                if let dropedItem = fightAren!.liveEnemy[i].enemy.dropItem(){
                    chest.append(dropedItem)
                }
                fightAren!.liveEnemy[i].die()
                fightAren!.liveEnemy.remove(at: i)
                
                killTrig = true
            }
        }
        
        if killTrig{
            fightAren?.swipeEnemy(newSelectEnemy: fightAren!.selectingEnemy(dir: .Right))
        }
        
        if fightAren!.liveEnemy.isEmpty{
            room?.enemys = []
            player.fightStats.endFight(player: player)
            fightAren?.endFight()
        }
    }
    
    func EnemyStep(){
        
        for i in fightAren!.liveEnemy{
            player.fightStats.takeDMG(charactor: player, dmg: i.enemy!.fightStats.attackDmg)
            print(player.fightStats.fightHP)
        }
        
    }
    
    func checkPlayerLive(){
        if player.fightStats.fightHP <= 0{
            player.fightStats.endFight(player: player)
            fightAren!.endFight()
        }
    }
    
    func startFight() {
        
        player.fightStats.startFight(charactor: player)
        for i in room!.enemys{
            i.fightStats.startFight(charactor: i)
        }
    }
}
