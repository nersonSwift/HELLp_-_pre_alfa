//
//  CastPlayer.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 27.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class CastPlayer{
    
    var player = Player()
    var defaultPlayer = Player()
    var map = Map()
    var playerSet = false
    
    init() {
        map = Map(castPlayer: self)
    }
    
    func newPlayer(){
        map = Map(castPlayer: self)
        
        switch defaultPlayer.name {
            case "Lilit": player = Lilit()
        default: break
        }
        player.inventery = defaultPlayer.inventery
        
    }
    
    
}
