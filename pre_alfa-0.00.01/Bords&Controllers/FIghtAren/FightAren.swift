//
//  FightAren.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 29.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit


class FightAren: UIViewController, NavigationProtocol  {
    var navigation: Navigation!
    
    static func storyboardInstance(navigation: Navigation) -> NavigationProtocol? {
        let storyboard = UIStoryboard(name: "\(self)", bundle: nil)
        let fightAren = storyboard.instantiateInitialViewController() as? FightAren
        fightAren!.navigation = navigation
        fightAren!.castPlayer = navigation.gameDataStorage
        fightAren!.room = navigation.gameDataStorage.map.mapRooms[navigation.gameDataStorage.player.xy]
        return fightAren
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var room: Room!
    var castPlayer: GameDataStorage!
    
    private var brain: BrainFightAren!
    private var stuel: StuelFightAren!
    
    var allEnemyInAren: [EnemyInAren?] = [nil, nil, nil]
    
    var endAnimStep = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain = BrainFightAren(fightAren: self, castPlayer: castPlayer, room: room)
        stuel = StuelFightAren(fightAren: self)
        
        stuel.createScen(view: self.view)
        stuel.createCam()
        stuel.createHpWheel()
        stuel.createWinBox()
        brain.setCardsInHand()
        
        stuel.createCards(cards: brain.cardsInHand)
        stuel.createEnemys(enemys: brain.room.enemys)
        
        brain.startFight()
        
        addSwipe()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func newCards(){
        brain.setCardsInHand()
        stuel.cardLeft?.setNewCard(card: brain.cardsInHand[0])
        stuel.cardMid?.setNewCard(card: brain.cardsInHand[1])
        stuel.cardRight?.setNewCard(card: brain.cardsInHand[2])
    }
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let p = gestureRecognize.location(in: stuel.scnView)
        let hitResults = stuel.scnView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let a = hitResults[0]
            
            if a.node.name == "WinBox" && endAnimStep{
                for i in brain.chest{
                    brain.player.inventery.AddItem(steckItem: i)
                }
                navigation.transitionToView(viewControllerType: Area(), special: nil)
            }
            
            if a.node.name == "Card"{
                stuel.animCardSelect(card: a.node)
            }
        }
    }
    
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                let dir = brain.selectingEnemy(dir: .Left)
                stuel.animSwipeEnemy(newSelectEnemy: dir!)
            case .left:
                let dir = brain.selectingEnemy(dir: .Right)
                stuel.animSwipeEnemy(newSelectEnemy: dir!)
                
            case .up:
                brain.playerStep(card: stuel.selectCard!.card)
                stuel.animThrowCard(completion: {
                    let deadEnemy   = self.brain.checkEnemysDead()
                    let killedEnemy = self.stuel.animEnemyDead(deadEnemy: deadEnemy)
                    self.brain.getLoot(killedEnemys: killedEnemy)
                    for i in killedEnemy{
                        if i == self.brain.selectEnemy{
                            if let dir = self.brain.selectingEnemy(dir: .Right){
                                self.stuel.animSwipeEnemy(newSelectEnemy: dir)
                            }else{
                                self.brain.endFight()
                            }
                        }
                    }
                    self.brain.enemyStep()
                    self.brain.checkPlayerLive()
                    self.stuel.animCardReset(completion: {
                        self.newCards()
                        self.stuel.animNewHand(completion: {})
                    })
                })
            case .down:  stuel.animRotationCard()
            default: break
            }
        }
    }
    
    func endFight(){
        stuel.animWinBoxDown()
    }
}
