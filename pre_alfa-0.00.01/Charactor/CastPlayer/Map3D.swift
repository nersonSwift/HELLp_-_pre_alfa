//
//  Map3D.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 13.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class Map3D{
    var scene = SCNScene()
    var camera = SCNNode()
    var blocksMap: [String: BlockMap] = [:]
    var selectBlockMap: BlockMap!
    
    init() {
        
        camera.camera = SCNCamera()
        camera.eulerAngles = SCNVector3(-Float.pi/2,-Float.pi,0)
        scene.rootNode.addChildNode(camera)
        
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
