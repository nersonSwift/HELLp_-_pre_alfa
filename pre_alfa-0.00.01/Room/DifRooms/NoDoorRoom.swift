//
//  NoDoor.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 06.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class NoDoorRoom: DifRoom {
    override init(x: Int, y: Int, castPlayer: CastPlayer) {
        super.init(x: x, y: y, castPlayer: castPlayer)
        self.nameRoom = "NoD"
        Doors = ["DoorUp" : Door.noDoor, "DoorRight" : Door.noDoor, "DoorDown" : Door.noDoor, "DoorLeft" : Door.noDoor]
    }
}

