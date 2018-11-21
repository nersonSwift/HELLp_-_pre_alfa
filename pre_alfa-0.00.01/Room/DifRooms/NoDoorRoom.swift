//
//  NoDoor.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 06.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class NoDoorRoom: DifRoom {
    
    override init(){super.init()}
    override func openRoom(player: Player) -> Bool{return false}
    
    override func setDifRoom(x: Int, y: Int, castPlayer: GameDataStorage) {
        super.setDifRoom(x: x, y: y, castPlayer: castPlayer)
        self.nameRoom = "NoDoorRoom"
        typeDoors = Door.noDoor
        Doors = [.Up : typeDoors, .Right : typeDoors, .Down : typeDoors, .Left : typeDoors]
        close = true
    }
}

