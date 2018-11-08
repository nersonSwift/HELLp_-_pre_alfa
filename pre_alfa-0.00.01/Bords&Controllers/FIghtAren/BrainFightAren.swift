//
//  BarainFightAren.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 03.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class BrainFightAren{
    weak var fightAren: FightAren!
    weak var room: Room!
    weak var castPlayer: CastPlayer!
    
    var player: Player{
        return castPlayer.player
    }
    var selectEnemy: EnemyInAren?{
        return fightAren!.allEnemyInAren[fightAren!.selectLiveEnemy]
    }
    var cardsInHand: [Card] = []
    var chest: [StackItem] = []
    
    var allEnemy: [Enemy]{
        var allEnemy: [Enemy] = []
        for i in fightAren!.allEnemyInAren{
            if let enemyInAren = i{
                allEnemy.append(enemyInAren.enemy!)
            }
        }
        return allEnemy
    }
    
    init(fightAren: FightAren, castPlayer: CastPlayer, room: Room) {
        self.fightAren  = fightAren
        self.castPlayer = castPlayer
        self.room       = room
    }
    
    func playerStep(card: Card){
        card.effect(player: player, selectEnemy: selectEnemy!.enemy, allEnemy: allEnemy)
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
        for i in fightAren!.allEnemyInAren{
            if let enemyInAren = i{
                
                if enemyInAren.enemy!.dieFight{
                    
                    if enemyInAren.die(){
                        
                        if let dropedItem = enemyInAren.enemy.dropItem(){
                            chest.append(dropedItem)
                        }
                        
                        if !fightAren!.selectingEnemy(dir: .Right){
                            room?.enemys = []
                            player.fightStats.endFight(player: player)
                            fightAren?.endFight()
                        }
                    }
                }
            }
        }
    }
    
    func enemyStep(){
        
        for i in fightAren!.allEnemyInAren{
            if let enemyInAren = i{
                player.fightStats.takeDMG(charactor: player, dmg: enemyInAren.enemy!.fightStats.attackDmg)
            }
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
