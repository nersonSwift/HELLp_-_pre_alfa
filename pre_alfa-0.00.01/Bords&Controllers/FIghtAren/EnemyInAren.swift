//
//  EnemyInAren.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 11.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class EnemyInAren: SCNNode {
    var enemy: Enemy!
    var positionEnemy: Dir!
    var live = true
    
    static func criateEmemyInAren(positionEnemy: Dir, enemy: Enemy) -> EnemyInAren {
        
        let enemyInAren = EnemyInAren()
        enemyInAren.enemy = enemy
        enemyInAren.positionEnemy = positionEnemy
        
        switch positionEnemy{
            case .Down:     enemyInAren.position = SCNVector3(0, 1, -6)
            case .Left:     enemyInAren.position = SCNVector3(-2.222, 0, -7.87)
            case .Right:    enemyInAren.position = SCNVector3(2.222, 0, -7.87)
        default: break
            
        }
        
        enemyInAren.geometry = SCNBox(width: 1.5, height: 0.01, length: 2.25, chamferRadius: 0)
        

        
        let enemyTexture = SCNMaterial()
        let enemyTextureRip = SCNMaterial()
        enemyTexture.diffuse.contents    =   #imageLiteral(resourceName: "scenes.scnassets/textures/" + enemy.name + ".jpg")
        enemyTextureRip.diffuse.contents =   #imageLiteral(resourceName: "scenes.scnassets/textures/rip.jpg")
        enemyInAren.geometry?.materials = [enemyTexture,enemyTextureRip]
        
        return enemyInAren
    }
    
    func dieAnim() -> Bool{
        if live{
            self.runAction(SCNAction.rotateBy(x: CGFloat(Float.pi), y: 0, z: 0, duration: 0.6))
            live = false
            return true
        }
        return false
    }

}
