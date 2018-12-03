//
//  BlockMap.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 13.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class BlockMap3D: SCNNode {
    var blocksMap: [Dir: BlockMap3D?] = [:]
    var blocksMapDoors: [Dir: SCNNode]! = [:]
    weak var room: Room!
    
    static func criateBlockMap(map: Map, x: Int, y: Int) -> BlockMap3D {
        
        let blockMap = BlockMap3D()
        blockMap.geometry = SCNBox.init(width: 0.9, height: 0.1, length: 0.9, chamferRadius: 0)
        blockMap.position = SCNVector3(-x, 0, y)
        blockMap.room = map.mapRooms[String(x)+String(y)]
        
        let mat = SCNMaterial()
        switch blockMap.room.saveRoom.nameRoo {
            case "ComRoom":     mat.diffuse.contents = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            case "DmgRoom":     mat.diffuse.contents = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            case "CloseRoom":   mat.diffuse.contents = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        default:break
        }
        blockMap.geometry?.materials = [mat]
        
        let up      = map.map3D.blocksMap[String(x)+String(y+1)]
        let right   = map.map3D.blocksMap[String(x+1)+String(y)]
        let down    = map.map3D.blocksMap[String(x)+String(y-1)]
        let left    = map.map3D.blocksMap[String(x-1)+String(y)]
        
        blockMap.blocksMap = [.Up: up, .Right: right, .Down: down, .Left: left]
        
        let blockMapDoorsUp      = SCNNode()
        let blockMapDoorsRight   = SCNNode()
        let blockMapDoorsDown    = SCNNode()
        let blockMapDoorsLeft    = SCNNode()
        
        blockMapDoorsUp.geometry     = SCNBox(width: 0.25, height: 0.5, length: 0.125, chamferRadius: 0)
        blockMapDoorsRight.geometry  = SCNBox(width: 0.125, height: 0.5, length: 0.25, chamferRadius: 0)
        blockMapDoorsDown.geometry   = SCNBox(width: 0.25, height: 0.5, length: 0.125, chamferRadius: 0)
        blockMapDoorsLeft.geometry   = SCNBox(width: 0.125, height: 0.5, length: 0.25, chamferRadius: 0)
        
        blockMapDoorsUp.position    = SCNVector3(0,0,0.45)
        blockMapDoorsRight.position = SCNVector3(-0.45,0,0)
        blockMapDoorsDown.position  = SCNVector3(0,0,-0.45)
        blockMapDoorsLeft.position  = SCNVector3(0.45,0,0)
        
        blockMap.blocksMapDoors = [.Up: blockMapDoorsUp, .Right: blockMapDoorsRight, .Down: blockMapDoorsDown, .Left: blockMapDoorsLeft]
        
        for i in blockMap.blocksMapDoors!{
            let mat = SCNMaterial()
            switch blockMap.room.Doors[i.key]!{
            case .ironDoor:     mat.diffuse.contents = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            case .woodDoor:     mat.diffuse.contents = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
            case .closeDoor:    mat.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            case .openDoor:     mat.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            case .dmgDoor:      mat.diffuse.contents = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            case .noDoor:       mat.diffuse.contents = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0)
                
            default: break
            }
            blockMap.blocksMapDoors[i.key]!.geometry?.materials = [mat]
            blockMap.addChildNode(blockMap.blocksMapDoors[i.key]!)
        }
        
        return blockMap
    }
    
}
