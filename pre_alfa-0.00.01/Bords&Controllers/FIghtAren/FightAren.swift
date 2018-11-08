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


class FightAren: UIViewController {
    
    static func storyboardInstance(room: Room, castPlayer: CastPlayer) -> FightAren? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let fightAren = storyboard.instantiateInitialViewController() as? FightAren
        fightAren!.room = room
        fightAren!.castPlayer = castPlayer
        return fightAren
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var room: Room!
    var castPlayer: CastPlayer!
    
    private var brain: BrainFightAren!
    private var stuel: SceneStuel!
    
    var allEnemyInAren: [EnemyInAren?] = [nil, nil, nil]
    var selectLiveEnemy = 0
    
    var endAnimStep = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain = BrainFightAren(fightAren: self, castPlayer: castPlayer, room: room)
        stuel = SceneStuel(fightAren: self)
        
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
    
    
    func selectingEnemy(dir: Dir) -> Bool {
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
                    stuel.swipeEnemy(newSelectEnemy: allEnemyInAren[selectLiveEnemy]!.positionEnemy)
                    return true
                }
            }
        }
        return false
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
                self.dismiss(animated: true, completion: nil)
            }
            
            if a.node.name == "Card"{
                stuel.cardSelect(card: a.node)
            }
        }
    }
    
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right: _ = selectingEnemy(dir: .Left)
            case .left:  _ = selectingEnemy(dir: .Right)
            case .up:
                brain.playerStep(card: stuel.selectCard!.card)
                stuel.throwCard(completion: {
                    self.brain.checkEnemysLive()
                    self.brain.enemyStep()
                    self.brain.checkPlayerLive()
                    self.stuel.cardReset(completion: {
                        self.newCards()
                        self.stuel.newHand(completion: {})
                    })
                })
            case .down:  stuel.rotationCard()
            default: break
            }
        }
    }
    
    func endFight(){
        stuel.winBoxDown()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
