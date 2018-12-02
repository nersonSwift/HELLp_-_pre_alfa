//
//  SavaRooms.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 23.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift

class RoomProp: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var firstVisitingTriger = true
    @objc dynamic var close = false
    @objc dynamic var inRoom = false
    
    @objc dynamic var x = 0
    @objc dynamic var y = 0
    
    @objc dynamic var up    = ""
    @objc dynamic var right = ""
    @objc dynamic var down  = ""
    @objc dynamic var left  = ""
    
    @objc dynamic var enemy0 = ""
    @objc dynamic var enemy1 = ""
    @objc dynamic var enemy2 = ""
    
    var nameRoo : String{
        set(nameRoom) {
            try! Realm().write {
                name = nameRoom
            }
        }
        get{
            return name
        }
    }
    func copy() -> RoomProp{
        let copySelf = RoomProp()
        copySelf.id                     = id
        copySelf.name                   = name
        copySelf.firstVisitingTriger    = firstVisitingTriger
        copySelf.close                  = close
        copySelf.inRoom                 = inRoom
        copySelf.x                      = x
        copySelf.y                      = y
        copySelf.up                     = up
        copySelf.right                  = right
        copySelf.down                   = down
        copySelf.left                   = left
        copySelf.enemy0                 = enemy0
        copySelf.enemy1                 = enemy1
        copySelf.enemy2                 = enemy2
        
        return copySelf
    }
}

class SaveRoomsd: Object {
    @objc dynamic var enemy2 = ""
   // @objc dynamic var enemy3 = ""
}
