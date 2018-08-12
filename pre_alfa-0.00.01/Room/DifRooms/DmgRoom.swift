//
//  DmgRoom.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 08.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class DmgRoom: DifRoom {
    
   override init(x: Int, y: Int, castPlayer: CastPlayer){
        super.init(x: x, y: y, castPlayer: castPlayer)
        self.nameRoom = "DMG"
        Doors = ["DoorUp" : Door.dmgDoor, "DoorRight" : Door.dmgDoor, "DoorDown" : Door.dmgDoor, "DoorLeft" : Door.dmgDoor]
    
       CheckNoRoom(castPlayer: castPlayer)
    }
 
    override func InRoom(castPlayer: CastPlayer) {
        super.InRoom(castPlayer: castPlayer)
        castPlayer.player.DMG(dmg: 2)
    }

}
