//
//  CloseRoom.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 16.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class CloseRoom: DifRoom {
    override init(x: Int, y: Int, castPlayer: CastPlayer){
        super.init(x: x, y: y, castPlayer: castPlayer)
        self.nameRoom = "CloseRoom"
        Doors = ["Up" : Door.closeDoor, "Right" : Door.closeDoor, "Down" : Door.closeDoor, "Left" : Door.closeDoor]
        
        CheckNoRoom(castPlayer: castPlayer)
    }
    
    override func InRoom(castPlayer: CastPlayer) {
        super.InRoom(castPlayer: castPlayer)
        Doors = ["Up" : Door.openDoor, "Right" : Door.openDoor, "Down" : Door.openDoor, "Left" : Door.openDoor]
        
        CheckNoRoom(castPlayer: castPlayer)
        
        let roomUp      = castPlayer.map.mapRooms[String(x) + String(y+1)]
        let roomRight   = castPlayer.map.mapRooms[String(x+1) + String(y)]
        let roomDown    = castPlayer.map.mapRooms[String(x) + String(y-1)]
        let roomLeft    = castPlayer.map.mapRooms[String(x-1) + String(y)]
        
        if (roomUp != nil) && !(roomUp is NoDoorRoom){
            roomUp!.Doors["Down"] = Door.openDoor
        }
        if roomRight != nil && !(roomRight is NoDoorRoom){
            roomRight!.Doors["Left"] = Door.openDoor
        }
        if roomDown != nil && !(roomDown is NoDoorRoom){
            roomDown!.Doors["Up"] = Door.openDoor
        }
        if roomLeft != nil && !(roomLeft is NoDoorRoom){
            roomLeft!.Doors["Right"] = Door.openDoor
        }
        
        
    }
}
