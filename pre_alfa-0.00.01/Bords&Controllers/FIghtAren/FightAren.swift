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
    
    static func storyboardInstance() -> FightAren? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? FightAren
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var brain = BrainFightAren()
    var stuel = SceneStuel()
    
    var liveEnemy: [EnemyInAren] = []
    var selectLiveEnemy = 0
    
    var endAnimStep = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stuel.createScen(view: self.view)
        stuel.createCam()
        stuel.createHpWheel()
        stuel.createWinBox()
        
        brain.setCardsInHand()
        
        var cards: [CardInAren] = []
        
        cards.append(CardInAren.criateCardInAren(positionCard: .Left,  card: brain.cardsInHand[0]))
        cards.append(CardInAren.criateCardInAren(positionCard: .Up,    card: brain.cardsInHand[1]))
        cards.append(CardInAren.criateCardInAren(positionCard: .Right, card: brain.cardsInHand[2]))
        stuel.addCards(cards: cards)
        
        
        brain.startFight()
        createEnemys(a: brain.room!.enemys.count)
        
        addSwipe()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    
    func createEnemys(a: Int){
        stuel.enemyDown = EnemyInAren.criateEmemyInAren(positionEnemy:  .Down)
        stuel.scene.rootNode.addChildNode(stuel.enemyDown!)
        brain.setSelectEnemy(enemyInAren: stuel.enemyDown!)
        
        liveEnemy.append(stuel.enemyDown!)
        
        if a > 1{
            stuel.enemyRight = EnemyInAren.criateEmemyInAren(positionEnemy: .Right)
            stuel.scene.rootNode.addChildNode(stuel.enemyRight!)
            liveEnemy.append(stuel.enemyRight!)
        }
         if a > 2{
            stuel.enemyLeft = EnemyInAren.criateEmemyInAren(positionEnemy: .Left)
            stuel.scene.rootNode.addChildNode(stuel.enemyLeft!)
            liveEnemy.insert(stuel.enemyLeft!, at: 0)
            selectLiveEnemy = 1
        }
    }
    
    func selectingEnemy(dir: Dir) -> Dir {
        if liveEnemy.count == 0{
            return .Down
        }
        
        switch dir {
        case .Left:
            if selectLiveEnemy <= 0{
                selectLiveEnemy = liveEnemy.count - 1
            }else{
                selectLiveEnemy -= 1
            }
        case .Right:
            if selectLiveEnemy >= liveEnemy.count - 1{
                selectLiveEnemy = 0
            }else{
                selectLiveEnemy += 1
            }
        default:break
        }
        return liveEnemy[selectLiveEnemy].positionEnemy
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
            case .right: let a = stuel.swipeEnemy(newSelectEnemy: selectingEnemy(dir: .Left))
                brain.setSelectEnemy(enemyInAren: a)
            case .left:  let a = stuel.swipeEnemy(newSelectEnemy: selectingEnemy(dir: .Right))
                brain.setSelectEnemy(enemyInAren: a)
            case .up:
                brain.PlayerStep(card: stuel.selectCard!.card)
                stuel.throwCard(completion: {
                    self.brain.checkEnemysLive()
                    self.brain.EnemyStep()
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
