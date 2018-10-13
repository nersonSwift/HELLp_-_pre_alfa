//
//  DmgRoom.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 08.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class DmgRoom: DifRoom {
    override init(){super.init()}
    
    override func setDifRoom(x: Int, y: Int, castPlayer: CastPlayer) {
        super.setDifRoom(x: x, y: y, castPlayer: castPlayer)
        nameRoom = "DmgRoom"
        typeDoors = Door.dmgDoor
        Doors = [.Up : typeDoors, .Right : typeDoors, .Down : typeDoors, .Left : typeDoors]
        
        CheckNoRoom(castPlayer: castPlayer)
    }
 
    override func InRoom(castPlayer: CastPlayer) {
        super.InRoom(castPlayer: castPlayer)
        castPlayer.player.DMG(dmg: 2)
    }

}
