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

class SceneStuel{
    
    var scene: SCNScene!
    var scnView: SCNView!
    var view: UIView!
    
    var hpWheel = SCNNode()
    var winBox  = SCNNode()
    
    weak var selectCard : CardInAren?
    
    weak var cardLeft   : CardInAren?
    weak var cardMid    : CardInAren?
    weak var cardRight  : CardInAren?
    
    var enemyLeft   : EnemyInAren?
    var enemyDown   : EnemyInAren?
    var enemyRight  : EnemyInAren?
    
    func createScen(view: UIView) -> SCNView{
        self.view = view
        scnView = SCNView(frame: view.frame)
        view.addSubview(scnView)
        
        scene = SCNScene()
        scnView.scene = scene
        scnView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return scnView
        
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
    
}
