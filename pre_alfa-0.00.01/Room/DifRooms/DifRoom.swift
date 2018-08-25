//
//  DifRoom.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 15.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class DifRoom: Room {
    
    init(x: Int, y: Int, castPlayer: CastPlayer) {
        super.init()
        self.x = x
        self.y = y
    }
    override init(saveRoom: SaveRoom, castPlayer: CastPlayer) {
        super.init(saveRoom: saveRoom, castPlayer: castPlayer)
    }
    
    func CheckNoRoom(castPlayer: CastPlayer){
        
        let roomUp      = castPlayer.map.mapRooms[String(x) + String(y+1)]
        let roomRight   = castPlayer.map.mapRooms[String(x+1) + String(y)]
        let roomDown    = castPlayer.map.mapRooms[String(x) + String(y-1)]
        let roomLeft    = castPlayer.map.mapRooms[String(x-1) + String(y)]
        
        if roomUp is NoDoorRoom{
            Doors["Up"] = Door.noDoor
        }
        if roomRight is NoDoorRoom{
            Doors["Right"] = Door.noDoor
        }
        if roomDown is NoDoorRoom{
            Doors["Down"] = Door.noDoor
        }
        if roomLeft is NoDoorRoom{
            Doors["Left"] = Door.noDoor
        }
    }
}
