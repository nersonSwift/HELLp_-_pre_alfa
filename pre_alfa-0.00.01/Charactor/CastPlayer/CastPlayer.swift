//
//  CastPlayer.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 27.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class CastPlayer{
    
    var player = Player()
    var defaultPlayer = Player()
    var map = Map()
    
    init() {
        map = Map(castPlayer: self)
    }
    
    func newPlayer(){
        switch defaultPlayer.name {
            case "Lilit": player = Lilit()
        default: break
        }
        player.inventery = defaultPlayer.inventery
        
    }
    
    
}
