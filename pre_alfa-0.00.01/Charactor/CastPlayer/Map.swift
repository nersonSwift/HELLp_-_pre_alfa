//
//  Map.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 09.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Map{
    weak var castPlayer: CastPlayer?
    var mapRooms = [ "" : Room()]
    var map3D: Map3D!
    
    init() {
    }
    
    init(castPlayer: CastPlayer) {
        self.castPlayer = castPlayer
        map3D = Map3D()
    }
    
    public func createDifRoom(room: Room, dir: Dir) -> Bool{
        let x = room.x
        let y = room.y
        
        let roomUp      = mapRooms[String(x) + String(y+1)]
        let roomRight   = mapRooms[String(x+1) + String(y)]
        let roomDown    = mapRooms[String(x) + String(y-1)]
        let roomLeft    = mapRooms[String(x-1) + String(y)]
        
        let roomUpCondition     = ((roomDown == nil)  || (roomDown is NoDoorRoom )) || (dir == Dir.Up)
        let roomRightCondition  = ((roomLeft == nil)  || (roomLeft is NoDoorRoom )) || (dir == Dir.Right)
        let roomDownCondition   = ((roomUp == nil)    || (roomUp is NoDoorRoom   )) || (dir == Dir.Down)
        let roomLeftCondition   = ((roomRight == nil) || (roomRight is NoDoorRoom)) || (dir == Dir.Left)
        
        if  roomUpCondition && roomRightCondition && roomDownCondition && roomLeftCondition{
            mapRooms[String(x) + String(y)] = room
            return true
        }
        return false
    }
    
    public func WhatIsIt(dir: Dir) -> Room{
        var x = castPlayer!.player.x
        var y = castPlayer!.player.y
        
        switch dir {
            case .Up:      y += 1
            case .Right:   x += 1
            case .Down:    y -= 1
            case .Left:    x -= 1
        }
        
        switch arc4random_uniform(100) {
            case 0...69:  return NoDoorRoom(x: x, y: y, castPlayer: castPlayer!)
            case 70...79: return DmgRoom(x: x, y: y, castPlayer: castPlayer!)
            case 80...99: return CloseRoom(x: x, y: y, castPlayer: castPlayer!)
        
        default: break
        }
        return NoDoorRoom(x: x, y: y, castPlayer: castPlayer!)
    }
    
}
