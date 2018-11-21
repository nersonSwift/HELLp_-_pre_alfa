//
//  SceneStule.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 14/10/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class StuelFightAren{
    
    weak var fightAren: FightAren!
    
    var scene: SCNScene!
    var scnView: SCNView!
    var view: UIView!
    
    var hpWheel = SCNNode()
    var winBox  = SCNNode()
    
    weak var selectCard : CardInAren!
    
    weak var cardLeft   : CardInAren!
    weak var cardMid    : CardInAren!
    weak var cardRight  : CardInAren!
    
    var enemyDown   : EnemyInAren?{
        set(enemyDown){
            fightAren.allEnemyInAren[0] = enemyDown
        }
        get{
            return fightAren.allEnemyInAren[0]
        }
    }
    var enemyRight  : EnemyInAren?{
        set(enemyRight){
            fightAren.allEnemyInAren[1] = enemyRight
        }
        get{
            return fightAren.allEnemyInAren[1]
        }
    }
    var enemyLeft   : EnemyInAren?{
        set(enemyLeft){
            fightAren.allEnemyInAren[2] = enemyLeft
        }
        get{
            return fightAren.allEnemyInAren[2]
        }
    }
    
    
    
    
    init(fightAren: FightAren) {
        self.fightAren = fightAren
    }
    
//////////////////
//MARK: - Create//
//////////////////
    func createScen(view: UIView){
        self.view = view
        scnView = SCNView(frame: view.frame)
        view.addSubview(scnView)
        
        scene = SCNScene()
        scnView.scene = scene
        scnView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func createCam(){
        let heightRoom = view.frame.height
        let widthRoom = view.frame.width
        
        let cam = SCNNode()
        cam.camera = SCNCamera()
        if (2.16 < (heightRoom / widthRoom)) && ((heightRoom / widthRoom) < 2.17) {
            cam.position = SCNVector3(0, 12, -4.5)
        }else{
            cam.position = SCNVector3(0, 10, -4.5)
        }
        cam.eulerAngles = SCNVector3(-Float.pi/2, 0, 0)
        scene.rootNode.addChildNode(cam)
    }
    
    func createHpWheel(){
        hpWheel.geometry = SCNSphere(radius: 1)
        hpWheel.scale = SCNVector3(1.1, 0.1, 1.1)
        scene.rootNode.addChildNode(hpWheel)
    }
    
    func createWinBox(){
        winBox.geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        winBox.position = SCNVector3(0, 15, -4.3)
        winBox.name = "WinBox"
        scene.rootNode.addChildNode(winBox)
    }
    
    func createEnemys(enemys: [Enemy]){
        enemyDown = EnemyInAren.criateEmemyInAren(positionEnemy:  .Down, enemy: enemys[0])
        scene.rootNode.addChildNode(enemyDown!)
        
        if enemys.count > 1{
            enemyRight = EnemyInAren.criateEmemyInAren(positionEnemy: .Right , enemy: enemys[1])
            scene.rootNode.addChildNode(enemyRight!)
        }
        if enemys.count > 2{
            enemyLeft = EnemyInAren.criateEmemyInAren(positionEnemy: .Left , enemy: enemys[2])
            scene.rootNode.addChildNode(enemyLeft!)
        }
    }
    
    func createCards(cards: [Card]){
        cardLeft    = CardInAren.criateCardInAren(positionCard: .Left,  card: cards[0])
        cardMid     = CardInAren.criateCardInAren(positionCard: .Up,    card: cards[1])
        cardRight   = CardInAren.criateCardInAren(positionCard: .Right, card: cards[2])
        
        hpWheel.addChildNode(cardLeft!)
        hpWheel.addChildNode(cardMid!)
        hpWheel.addChildNode(cardRight!)
        
        selectCard = cardMid
    }
    
////////////////
//MARK: - Anim//
////////////////
    func animEnemyDead(deadEnemy: [EnemyInAren]) -> [EnemyInAren] {
        var killedEnemys: [EnemyInAren] = []
        for i in deadEnemy{
            if i.dieAnim(){
                killedEnemys.append(i)
            }
        }
        return killedEnemys
    }
    
    func animSwipeEnemy(newSelectEnemy: Dir){
        let down    = SCNVector3(0, 1, -6)
        let left    = SCNVector3(-2.222, 0, -7.87)
        let right   = SCNVector3(2.222, 0, -7.87)
        
        
        switch newSelectEnemy{
        case .Left:
            
            enemyLeft?.runAction(SCNAction.move(to: down,  duration: 0.6))
            enemyDown?.runAction(SCNAction.move(to: right, duration: 0.6))
            enemyRight?.runAction(SCNAction.move(to: left, duration: 0.6))
            
        case .Down:
            
            enemyLeft?.runAction(SCNAction.move(to: left,   duration: 0.6))
            enemyDown?.runAction(SCNAction.move(to: down,   duration: 0.6))
            enemyRight?.runAction(SCNAction.move(to: right, duration: 0.6))
            
        case .Right:
            
            enemyLeft?.runAction(SCNAction.move(to: right, duration: 0.6))
            enemyDown?.runAction(SCNAction.move(to: left,  duration: 0.6))
            enemyRight?.runAction(SCNAction.move(to: down, duration: 0.6))
            
        default: break
        }
    }
    
    
    func animRotationCard() {
        selectCard?.runAction(SCNAction.rotate(by: CGFloat(Float.pi), around: selectCard!.position, duration: 0.7))
    }
    
    func animWinBoxDown() {
        winBox.runAction(SCNAction.move(to: SCNVector3.init(0, 0, -4.3), duration: 0.6))
    }
    
    func animCardSelect(card: SCNNode){
        
        selectCard  = card as? CardInAren
        
        switch selectCard!.positionCard {
        case .Left?:
            hpWheel.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(-Float.pi / 6), z: 0, duration: 0.4))
        case .Up?:
            hpWheel.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.4))
        case .Right?:
            hpWheel.runAction(SCNAction.rotateTo(x: 0, y: CGFloat(Float.pi / 6), z: 0, duration: 0.4))
        default:break
        }
    }
    
    func animThrowCard(completion: @escaping () -> Void) {
        selectCard?.runAction(SCNAction.fadeOpacity(by: 0.001, duration: 1.7))
        switch selectCard!.positionCard {
        case .Left?:
            selectCard?.runAction(SCNAction.move(by: SCNVector3.init(-0.5773, 0, -1) , duration: 0.2))
        case .Up?:
            selectCard?.runAction(SCNAction.move(by: SCNVector3.init(0, 0, -1.16), duration: 0.2))
        case .Right?:
            selectCard?.runAction(SCNAction.move(by: SCNVector3.init(0.5773, 0, -1), duration: 0.2))
        default: break
        }
        
        selectCard?.runAction(SCNAction.fadeOut(duration: 0.3), completionHandler: {completion()})
    }
    
    func animCardReset(completion: @escaping () -> Void){
        cardLeft?.runAction( SCNAction.move(to: SCNVector3.init(0, -0.5, 0), duration: 0.6))
        cardMid?.runAction(  SCNAction.move(to: SCNVector3.init(0,    0, 0), duration: 0.6))
        cardRight?.runAction(SCNAction.move(to: SCNVector3.init(0, -0.5, 0), duration: 0.6))
        
        cardLeft?.runAction( SCNAction.fadeOut(duration: 0.6))
        cardMid?.runAction(  SCNAction.fadeOut(duration: 0.6))
        cardRight?.runAction(SCNAction.fadeOut(duration: 0.6), completionHandler: {completion()})
    }
    
    func animNewHand(completion: @escaping () -> Void){
        self.cardLeft?.runAction( SCNAction.move(to: SCNVector3.init(-1.476, 0, -2.557), duration: 0.5))
        self.cardMid?.runAction(  SCNAction.move(to: SCNVector3.init(     0, 0, -2.73) , duration: 0.5))
        self.cardRight?.runAction(SCNAction.move(to: SCNVector3.init( 1.561, 0, -2.704), duration: 0.5), completionHandler: {
            self.cardLeft?.runAction( SCNAction.move(to: SCNVector3.init(-1.227, 0, -2.125), duration: 0.25))
            self.cardMid?.runAction(  SCNAction.move(to: SCNVector3.init(     0, 0, -2.455), duration: 0.3))
            self.cardRight?.runAction(SCNAction.move(to: SCNVector3.init( 1.227, 0, -2.126), duration: 0.35))
            })
            
        self.cardLeft?.runAction( SCNAction.fadeIn(duration: 0.6))
        self.cardMid?.runAction(  SCNAction.fadeIn(duration: 0.6))
        self.cardRight?.runAction(SCNAction.fadeIn(duration: 0.6), completionHandler: {completion()})
    }

}

