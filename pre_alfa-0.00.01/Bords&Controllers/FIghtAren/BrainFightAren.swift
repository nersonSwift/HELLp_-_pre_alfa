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
    weak var castPlayer: GameDataStorage!
    
    var player: Player{
        return castPlayer.player
    }
    var selectEnemy: EnemyInAren?{
        return fightAren!.allEnemyInAren[selectLiveEnemy]
    }
    var cardsInHand: [Card] = []
    var chest: [Item] = []
    
    var selectLiveEnemy = 0
    var allEnemyInAren: [EnemyInAren?]{
        return fightAren!.allEnemyInAren
    }
    
    init(fightAren: FightAren, castPlayer: GameDataStorage, room: Room) {
        self.fightAren  = fightAren
        self.castPlayer = castPlayer
        self.room       = room
    }
    
    func playerStep(card: Card){
        card.effect(player: player, selectEnemy: selectEnemy!.enemy, allEnemy: room.enemys)
    }
    
    func setCardsInHand(){
        cardsInHand = []
        for _ in 0...2{
            let a = arc4random_uniform(UInt32(player.stats.cards.count))
            print(player.stats.cards[Int(a)].name)
            cardsInHand.append(player.stats.cards[Int(a)])
        }
    }
    
    func checkEnemysDead() -> [EnemyInAren]{
        var deadEnemys: [EnemyInAren] = []
        for i in allEnemyInAren{
            if let enemyInAren = i{
                if enemyInAren.enemy!.dieFight{
                    deadEnemys.append(enemyInAren)
                }
            }
        }
        return deadEnemys
    }
    
    func endFight(){
        room?.enemys = []
        player.fightStats.endFight(player: player)
        fightAren?.endFight()
    }
    
    func getLoot(killedEnemys: [EnemyInAren]){
        for i in killedEnemys{
            if let dropedItem = i.enemy.dropItem(){
                chest.append(dropedItem)
            }
        }
    }
    
    func selectingEnemy(dir: Dir) -> Dir? {
        for _ in 0...2{
            switch dir {
            case .Left:
                if selectLiveEnemy <= 0{
                    selectLiveEnemy = allEnemyInAren.count - 1
                }else{
                    selectLiveEnemy -= 1
                }
            case .Right:
                if selectLiveEnemy >= allEnemyInAren.count - 1{
                    selectLiveEnemy = 0
                }else{
                    selectLiveEnemy += 1
                }
            default:break
            }
            if let a = allEnemyInAren[selectLiveEnemy]{
                if !a.enemy!.dieFight{
                    return allEnemyInAren[selectLiveEnemy]!.positionEnemy
                }
            }
        }
        return nil
    }
    
    func enemyStep(){
        
        for i in allEnemyInAren{
            if let enemyInAren = i{
                player.fightStats.takeDMG(dmg: enemyInAren.enemy!.fightStats.attackDmg)
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
