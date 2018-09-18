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
    
    @IBOutlet var scnView: SCNView!
    
    var scene: SCNScene!
    
    var hpWheel = SCNNode()
    var winBox  = SCNNode()
    
    weak var selectCard : CardInAren?
    
    weak var cardLeft   : CardInAren?
    weak var cardMid    : CardInAren?
    weak var cardRight  : CardInAren?
    
    var enemyLeft   : EnemyInAren?
    var enemyDown   : EnemyInAren?
    var enemyRight  : EnemyInAren?
    
    
    
    var liveEnemy: [EnemyInAren] = []
    var selectLiveEnemy = 0
    


    
    var endAnimStep = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scene = SCNScene()
        scnView.scene = scene
        scnView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        let cam = SCNNode()
        cam.camera = SCNCamera()
        cam.position = SCNVector3(0, 10, -4.5)
        cam.eulerAngles = SCNVector3(-Float.pi/2, 0, 0)
        scene.rootNode.addChildNode(cam)
        
        hpWheel.geometry = SCNSphere(radius: 1)
        hpWheel.scale = SCNVector3(1.1, 0.1, 1.1)
        scene.rootNode.addChildNode(hpWheel)
        
        winBox.geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        winBox.position = SCNVector3(0, 15, -4.3)
        winBox.name = "WinBox"
        scene.rootNode.addChildNode(winBox)
        
        brain.setCardsInHand()
        
        cardLeft    = CardInAren.criateCardInAren(positionCard: .Left, card: brain.cardsInHand[0])
        cardMid     = CardInAren.criateCardInAren(positionCard: .Up, card: brain.cardsInHand[1])
        cardRight   = CardInAren.criateCardInAren(positionCard: .Right, card: brain.cardsInHand[2])
        
        hpWheel.addChildNode(cardLeft!)
        hpWheel.addChildNode(cardMid!)
        hpWheel.addChildNode(cardRight!)
        selectCard = cardMid
        
        
        brain.startFight()
        createEnemys()
        
        addSwipe()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    
    func createEnemys(){
        
        
        let enemys = brain.room!.enemys
        
        enemyDown = EnemyInAren.criateEmemyInAren(positionEnemy:  .Down, enemy: enemys[0])
        scene.rootNode.addChildNode(enemyDown!)
        brain.setSelectEnemy(enemyInAren: enemyDown!)
        
        liveEnemy.append(enemyDown!)
        
        if brain.room!.enemys.count > 1{
            enemyRight = EnemyInAren.criateEmemyInAren(positionEnemy: .Right , enemy: enemys[1])
            scene.rootNode.addChildNode(enemyRight!)
            liveEnemy.append(enemyRight!)
        }
         if brain.room!.enemys.count > 2{
            enemyLeft = EnemyInAren.criateEmemyInAren(positionEnemy: .Left , enemy: enemys[2])
            scene.rootNode.addChildNode(enemyLeft!)
            liveEnemy.insert(enemyLeft!, at: 0)
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
    
    
    func swipeEnemy(newSelectEnemy: Dir){
        let down    = SCNVector3(0, 1, -6)
        let left    = SCNVector3(-2.222, 0, -7.87)
        let right   = SCNVector3(2.222, 0, -7.87)
        
        
        switch newSelectEnemy {
        case .Left:
            
            enemyLeft?.runAction(SCNAction.move(to: down , duration: 0.6))
            enemyDown?.runAction(SCNAction.move(to: right, duration: 0.6))
            enemyRight?.runAction(SCNAction.move(to: left, duration: 0.6))
            brain.setSelectEnemy(enemyInAren: enemyLeft!)
            
        case .Down:
            
            enemyLeft?.runAction(SCNAction.move(to: left , duration: 0.6))
            enemyDown?.runAction(SCNAction.move(to: down, duration: 0.6))
            enemyRight?.runAction(SCNAction.move(to: right, duration: 0.6))
            brain.setSelectEnemy(enemyInAren: enemyDown!)
            
        case .Right:
            
            enemyLeft?.runAction(SCNAction.move(to: right , duration: 0.6))
            enemyDown?.runAction(SCNAction.move(to: left, duration: 0.6))
            enemyRight?.runAction(SCNAction.move(to: down, duration: 0.6))
            brain.setSelectEnemy(enemyInAren: enemyRight!)
            
        default: break
        }
    }
    
    func newCards(){
        brain.setCardsInHand()
        
        cardLeft?.setNewCard(card: brain.cardsInHand[0])
        cardMid?.setNewCard(card: brain.cardsInHand[1])
        cardRight?.setNewCard(card: brain.cardsInHand[2])
    }
    
    func cardSelect(card: SCNNode){
        
        selectCard  = card as? CardInAren
        
        switch selectCard!.positionCard {
        case .Left:
            hpWheel.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(-Float.pi / 6), z: 0, duration: 0.4))
        case .Up:
            hpWheel.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.4))
        case .Right:
            hpWheel.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(Float.pi / 6), z: 0, duration: 0.4))
        default:break
        }
    }
    
    func rotationCard() {
        selectCard?.runAction(SCNAction.rotate(by: CGFloat(Float.pi), around: selectCard!.position, duration: 0.7))
    }
    
    func DMG() {
        if !endAnimStep{
            return
        }
        
        brain.PlayerStep()
        
        
        selectCard?.runAction(SCNAction.fadeOpacity(by: 0.001, duration: 1.7)) // Обход бага XCode
        endAnimStep = false
        
        switch selectCard!.positionCard {
        case .Left:
                selectCard?.runAction(SCNAction.move(by: SCNVector3.init(-0.5773, 0, -1) , duration: 0.2))
        case .Up:
                selectCard?.runAction(SCNAction.move(by: SCNVector3.init(0, 0, -1.16), duration: 0.2))
        case .Right:
                selectCard?.runAction(SCNAction.move(by: SCNVector3.init(0.5773, 0, -1), duration: 0.2))
        default: break
        }
        
        selectCard?.runAction(SCNAction.fadeOut(duration: 0.3), completionHandler: {
            self.newCardsAnim()
            self.brain.checkEnemysLive()
            self.brain.EnemyStep()
            self.brain.checkPlayerLive()
        })
    }
    
    private func newCardsAnim(){
        
        cardLeft?.runAction(SCNAction.move(to: SCNVector3.init(0, -0.5, 0) , duration: 0.6))
        cardMid?.runAction(SCNAction.move(to: SCNVector3.init(0, 0, 0), duration: 0.6))
        cardRight?.runAction(SCNAction.move(to: SCNVector3.init(0, -0.5, 0), duration: 0.6))
        
        cardLeft?.runAction(SCNAction.fadeOut(duration: 0.6))
        cardMid?.runAction(SCNAction.fadeOut(duration: 0.6))
        cardRight?.runAction(SCNAction.fadeOut(duration: 0.6), completionHandler: {
            
            self.newCards()
            self.cardLeft?.runAction(SCNAction.move(to: SCNVector3.init(-1.476, 0, -2.557) , duration: 0.5))
            self.cardMid?.runAction(SCNAction.move(to: SCNVector3.init(0, 0, -2.73), duration: 0.5))
            self.cardRight?.runAction(SCNAction.move(to: SCNVector3.init(1.561, 0, -2.704), duration: 0.5), completionHandler: {
                
                self.cardLeft?.runAction(SCNAction.move(to: SCNVector3.init(-1.227, 0, -2.125) , duration: 0.25))
                self.cardMid?.runAction(SCNAction.move(to: SCNVector3.init(0, 0, -2.455), duration: 0.3))
                self.cardRight?.runAction(SCNAction.move(to: SCNVector3.init(1.227, 0, -2.126), duration: 0.35))
                
            })
            
            self.cardLeft?.runAction(SCNAction.fadeIn(duration: 0.6))
            self.cardMid?.runAction(SCNAction.fadeIn(duration: 0.6))
            self.cardRight?.runAction(SCNAction.fadeIn(duration: 0.6), completionHandler: {
                self.endAnimStep = true
            })
            
        })
        
    }
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            let a = hitResults[0]
            
            if a.node.name == "WinBox" && endAnimStep{
                brain.room?.saveThisRoom(realm: brain.castPlayer.realm , sevedRoom: brain.castPlayer.savedRooms)
                for i in brain.chest{
                    brain.player.inventery.AddItem(steckItem: i)
                }
                self.dismiss(animated: true, completion: nil)
            }
            
            if a.node.name == "Card"{
                cardSelect(card: a.node)
            }
            
        }
    }
    
    @objc
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right: swipeEnemy(newSelectEnemy: selectingEnemy(dir: .Left))
            case .left:  swipeEnemy(newSelectEnemy: selectingEnemy(dir: .Right))
            case .up:    DMG()
            case .down:  rotationCard()
            default: break
            }
        }
    }
    
    func endFight(){
        winBox.runAction(SCNAction.move(to: SCNVector3.init(0, 0, -4.3), duration: 0.6))
    }
    
   

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
