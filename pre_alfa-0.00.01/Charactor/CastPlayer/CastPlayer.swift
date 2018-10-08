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
import RealmSwift

class CastPlayer{
    
    var player = Player()
    var defaultPlayer = Player()
    var map: Map!
    var playerSet = false
    let realm = try! Realm()
    
    var savedRooms: Results<SaveRoom>!
    var a: Results<AllSave>!
    
    init() {
        savedRooms = realm.objects(SaveRoom.self)
        map = Map(castPlayer: self)
    }
    
    @objc func startGame(){
        map = Map(castPlayer: self)
        
       
        switch defaultPlayer.name {
            case "Lilit": player = Lilit()
        default: break
        }
        player.inventery = defaultPlayer.inventery
        player.stats = defaultPlayer.stats
    }
    
    
}
