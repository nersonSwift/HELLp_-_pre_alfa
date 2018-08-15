//
//  Map3D.swift
//  pre_alfa-0.00.01/Users/aleksandrsenin/Desktop/Swift/pre_alfa-0.00.01/pre_alfa-0.00.01/Charactor
//
//  Created by Александр Сенин on 13.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class Map3D{
    var spotLight           = SCNNode()
    var directionalLight    = SCNNode()
    var camera              = SCNNode()
    var scene               = SCNScene()
    
    var blocksMap: [String: BlockMap] = [:]
    var selectBlockMap: BlockMap!
    
    init() {
        
        camera.camera = SCNCamera()
        camera.eulerAngles = SCNVector3(-Float.pi/2,-Float.pi,0)
        scene.rootNode.addChildNode(camera)
        
        directionalLight.light = SCNLight()
        directionalLight.light?.type = SCNLight.LightType.directional
        directionalLight.eulerAngles = SCNVector3(-Float.pi/2,0,0)
        directionalLight.position = SCNVector3(0,10,0)
        directionalLight.light?.intensity = 600
        scene.rootNode.addChildNode(directionalLight)
        
        spotLight.light = SCNLight()
        spotLight.light?.intensity = 900
        spotLight.light?.type = SCNLight.LightType.spot
        spotLight.eulerAngles = SCNVector3(0,0,0)
        spotLight.position = SCNVector3(0,0,-13.4)
        camera.addChildNode(spotLight)
        
    }
    
    func criateBlockMap(map: Map, x: Int, y: Int){
        let newBlockMap = BlockMap.criateBlockMap(map: map, x: x, y: y)
        blocksMap[String(x) + String(y)] = newBlockMap
        scene.rootNode.addChildNode(newBlockMap)
        refrashBlockMap(map: map, x: x, y: y)
    }
    
    func refrashBlockMap(map: Map, x: Int, y: Int){
        
        selectBlockMap = blocksMap[String(x) + String(y)]!
        camera.position = SCNVector3(selectBlockMap.position.x,15,selectBlockMap.position.z)
        
    }
    
}
