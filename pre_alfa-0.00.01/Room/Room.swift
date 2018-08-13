//
//  Room.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 02.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import Darwin

class Room {
    var firstVisiting = true
    var nameRoom = ""
    var inRoom = false
    var enemys: [Enemy] = []
    var x = 0
    var y = 0
    var xy: String{
        return String(x) + String(y)
    }
    var Doors = ["Up" : Door.noDoor, "Right" : Door.noDoor, "Down" : Door.noDoor, "Left" : Door.noDoor]
    
    private func firstVisitingInRoom(castPlayer: CastPlayer){
        castPlayer.player.stats.counterRoom += 1
    }
    
    public func InRoom(castPlayer: CastPlayer){
        inRoom = true
        if firstVisiting{
            firstVisitingInRoom(castPlayer: castPlayer)
            castPlayer.map.map3D.criateBlockMap(map: castPlayer.map, x: castPlayer.player.x, y: castPlayer.player.y)
            
            firstVisiting = false
        }else{
            castPlayer.map.map3D.refrashBlockMap(map: castPlayer.map, x: castPlayer.player.x, y: castPlayer.player.y)
        }
    }
    public func NoInRoom(){
        inRoom = false
    }
    
}
