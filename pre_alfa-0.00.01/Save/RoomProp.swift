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
    @objc dynamic var idS = 0
    @objc dynamic var nameS = ""
    @objc dynamic var firstVisitingTrigerS = true
    @objc dynamic var closeS = false
    @objc dynamic var inRoomS = false
    
    @objc dynamic var xS = 0
    @objc dynamic var yS = 0
    
    @objc dynamic var upS    = ""
    @objc dynamic var rightS = ""
    @objc dynamic var downS  = ""
    @objc dynamic var leftS  = ""
    
    @objc dynamic var enemy0S = ""
    @objc dynamic var enemy1S = ""
    @objc dynamic var enemy2S = ""
    
    var name : String{
        set(nameRoom) {
            try! Realm().write {
                nameS = nameRoom
            }
        }
        get{
            return nameS
        }
    }
    var id: Int{
        set(id) {
            try! Realm().write {
                idS = id
            }
        }
        get{
            return idS
        }
    }
    var firstVisitingTriger: Bool{
        set(firstVisitingTriger) {
            try! Realm().write {
                firstVisitingTrigerS = firstVisitingTriger
            }
        }
        get{
            return firstVisitingTrigerS
        }
    }
    var close: Bool{
        set(close) {
            try! Realm().write {
                closeS = close
            }
        }
        get{
            return closeS
        }
    }
    var x: Int{
        set(x) {
            try! Realm().write {
                xS = x
            }
        }
        get{
            return xS
        }
    }
    var y: Int{
        set(y) {
            try! Realm().write {
                yS = y
            }
        }
        get{
            return yS
        }
    }
    var inRoom : Bool{
        set(inRoom) {
            try! Realm().write {
                inRoomS = inRoom
            }
        }
        get{
            return inRoomS
        }
    }
    
    var xy: String{
        return String(xS) + String(yS)
    }
    
    var Doors: [Dir: Door]{
        set(doors){
            try! Realm().write {
                for i in doors{
                    self[i.key.rawValue] = i.value.rawValue
                }
            }
        }
        get{
            var doors: [Dir: Door] = [:]
            let dirDoor: [Dir] = [.Up, .Right, .Down, .Left]
            for i in dirDoor{
                let nameRoom = self[i.rawValue] as! String
                doors[i] = GetClass.getDoor(name: nameRoom)
            }
            return doors
        }
    }
    func copy() -> RoomProp{
        let copySelf = RoomProp()
        copySelf.idS                     = idS
        copySelf.nameS                   = nameS
        copySelf.firstVisitingTrigerS    = firstVisitingTrigerS
        copySelf.closeS                  = closeS
        copySelf.inRoomS                 = inRoomS
        copySelf.xS                      = xS
        copySelf.yS                      = yS
        copySelf.upS                     = upS
        copySelf.rightS                  = rightS
        copySelf.downS                   = downS
        copySelf.leftS                   = leftS
        copySelf.enemy0S                 = enemy0S
        copySelf.enemy1S                 = enemy1S
        copySelf.enemy2S                 = enemy2S
        
        return copySelf
    }
    
    func saveThisRoom(){
        try! Realm().write {
            try! Realm().add(self)
        }
    }
    func delRoom(){
        try! Realm().write {
            try! Realm().delete(self)
        }
    }
}


class SaveRoomsd: Object {
    @objc dynamic var enemy2 = ""
   // @objc dynamic var enemy3 = ""
}
