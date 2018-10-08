//
//  Room.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 02.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift


class Room {
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    
    var saveRoom = SaveRoom()
    
    var realm: Realm?
    var savedRooms: Results<SaveRoom>!
    
    var id: Int{
        set(id) {
            saveRoom.id = id
            saveThisRoom(realm: realm, sevedRoom: savedRooms)
        }
        get{
            return saveRoom.id
        }
    }
    var firstVisitingTriger: Bool{
        set(firstVisitingTriger) {
            saveRoom.firstVisitingTriger = firstVisitingTriger
            saveThisRoom(realm: realm, sevedRoom: savedRooms)
        }
        get{
            return saveRoom.firstVisitingTriger
        }
    }
    var nameRoom : String{
        set(nameRoom) {
            saveRoom.name = nameRoom
            saveThisRoom(realm: realm, sevedRoom: savedRooms)
        }
        get{
            return saveRoom.name
        }
    }
    var close: Bool{
        set(firstVisitingTriger) {
            saveRoom.close = close
            saveThisRoom(realm: realm, sevedRoom: savedRooms)
        }
        get{
            return saveRoom.close
        }
    }
    var x: Int{
        set(x) {
            saveRoom.x = x
            saveThisRoom(realm: realm, sevedRoom: savedRooms)
        }
        get{
            return saveRoom.x
        }
    }
    var y: Int{
        set(y) {
            saveRoom.y = y
            saveThisRoom(realm: realm, sevedRoom: savedRooms)
        }
        get{
            return saveRoom.y
        }
    }
    var inRoom : Bool{
        set(inRoom) {
            saveRoom.inRoom = inRoom
            saveThisRoom(realm: realm, sevedRoom: savedRooms)
        }
        get{
            return saveRoom.inRoom
        }
    }
 
=======
=======
>>>>>>> parent of c3c9056... не большие правики
    var id = 0
    var firstVisitingTriger = true
    var nameRoom = ""
    var inRoom = false
>>>>>>> parent of c3c9056... не большие правики
=======
=======
>>>>>>> parent of eba7765... 1
    /*
    var id = 0
    var firstVisitingTriger = true
    var nameRoom = ""
    var close = false
    var inRoom = false
<<<<<<< HEAD
>>>>>>> parent of eba7765... 1
=======
>>>>>>> parent of eba7765... 1
    var enemys: [Enemy] = []
    var x = 0
    var y = 0
    var xy: String{
        return String(x) + String(y)
    }
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    var Doors: [String: Door]{
        set(doors){
            for i in doors{
                switch i.key{
                case "Up": saveRoom.up = i.value.rawValue
                case "Right": saveRoom.right = i.value.rawValue
                case "Down": saveRoom.down = i.value.rawValue
                case "Left": saveRoom.left = i.value.rawValue
                default:break
                }
            }
        }
        get{
            var doors: [String: Door] = [:]
            doors["Up"]     = GetClass.getDoor(name: saveRoom.up)
            doors["Right"]  = GetClass.getDoor(name: saveRoom.right)
            doors["Down"]   = GetClass.getDoor(name: saveRoom.down)
            doors["Left"]   = GetClass.getDoor(name: saveRoom.left)
            return doors
        }
    } // = ["Up" : Door.noDoor, "Right" : Door.noDoor, "Down" : Door.noDoor, "Left" : Door.noDoor]
=======
    */
>>>>>>> parent of eba7765... 1
=======
    */
>>>>>>> parent of eba7765... 1
    
    
    var Doors = ["Up" : Door.noDoor, "Right" : Door.noDoor, "Down" : Door.noDoor, "Left" : Door.noDoor]
    
    init() {}
    func openRoom(player: Player) -> Bool{return true}
=======
    var Doors = ["Up" : Door.noDoor, "Right" : Door.noDoor, "Down" : Door.noDoor, "Left" : Door.noDoor]
    
    init() {}
>>>>>>> parent of c3c9056... не большие правики
=======
    var Doors = ["Up" : Door.noDoor, "Right" : Door.noDoor, "Down" : Door.noDoor, "Left" : Door.noDoor]
    
    init() {}
>>>>>>> parent of c3c9056... не большие правики
    
    func loadRoom(saveRoom: SaveRoom, castPlayer: CastPlayer){
        id = saveRoom.id
        nameRoom = saveRoom.name
        firstVisitingTriger = saveRoom.firstVisitingTriger
        
        x = saveRoom.x
        y = saveRoom.y
        
        Doors["Up"]     = GetClass.getDoor(name: saveRoom.up)
        Doors["Right"]  = GetClass.getDoor(name: saveRoom.right)
        Doors["Down"]   = GetClass.getDoor(name: saveRoom.down)
        Doors["Left"]   = GetClass.getDoor(name: saveRoom.left)
        
        if saveRoom.enemy0 != ""{
            enemys.append(GetClass.getEnemy(name: saveRoom.enemy0))
        }
        if saveRoom.enemy1 != ""{
            enemys.append(GetClass.getEnemy(name: saveRoom.enemy1))
        }
        if saveRoom.enemy2 != ""{
            enemys.append(GetClass.getEnemy(name: saveRoom.enemy2))
        }
    }
    
    func criateBlockMapRoom(castPlayer: CastPlayer){
        castPlayer.player.stats.counterRoom += 1
        print(castPlayer.player.stats.counterRoom)
        castPlayer.map.map3D.criateBlockMap(map: castPlayer.map, x: x, y: y)
    }
    
    
    public func firstVisiting(castPlayer: CastPlayer){
        if firstVisitingTriger{
            castPlayer.player.stats.counterRoom += 1
            castPlayer.map.map3D.criateBlockMap(map: castPlayer.map, x: castPlayer.player.x, y: castPlayer.player.y)
            firstVisitingTriger = false
            id = castPlayer.player.stats.counterRoom
        }else{
            castPlayer.map.map3D.refrashBlockMap(map: castPlayer.map, x: castPlayer.player.x, y: castPlayer.player.y)
        }
    }
    
    func saveThisRoom(realm: Realm, sevedRoom: Results<SaveRoom>!){
        let saveRoom = SaveRoom()

       
        for i in sevedRoom{
            if i.x == x && i.y == y{
                try! realm.write {
                    realm.delete(i)
                }
            }
        }

<<<<<<< HEAD
        
<<<<<<< HEAD
<<<<<<< HEAD
=======
        saveRoom.id = id
        saveRoom.name = nameRoom
        saveRoom.firstVisitingTriger = firstVisitingTriger
>>>>>>> parent of c3c9056... не большие правики
=======
        saveRoom.id = id
        saveRoom.name = nameRoom
        saveRoom.close = close
        saveRoom.firstVisitingTriger = firstVisitingTriger
>>>>>>> parent of eba7765... 1
        
        saveRoom.x = x
        saveRoom.y = y
        
        saveRoom.up     = Doors["Up"]!.rawValue
        saveRoom.right  = Doors["Right"]!.rawValue
        saveRoom.down   = Doors["Down"]!.rawValue
        saveRoom.left   = Doors["Left"]!.rawValue
        
=======
        
        saveRoom.id = id
        saveRoom.name = nameRoom
        saveRoom.close = close
        saveRoom.firstVisitingTriger = firstVisitingTriger
        
        saveRoom.x = x
        saveRoom.y = y
        
        saveRoom.up     = Doors["Up"]!.rawValue
        saveRoom.right  = Doors["Right"]!.rawValue
        saveRoom.down   = Doors["Down"]!.rawValue
        saveRoom.left   = Doors["Left"]!.rawValue
        
>>>>>>> parent of eba7765... 1
        if enemys.count >= 1{
            saveRoom.enemy0 = enemys[0].name
        }
        if enemys.count >= 2{
            saveRoom.enemy1 = enemys[1].name
        }
        if enemys.count >= 3{
            saveRoom.enemy2 = enemys[2].name
        }
        
        if inRoom{
            for i in sevedRoom{
                if i.name == "0"{
                    try! realm.write {
                        realm.delete(i)
                    }
                }
            }
            let a = SaveRoom()
            a.name = "0"
            a.x = x
            a.y = y
            try! realm.write {
                realm.add(a)
            }
        }
        
        try! realm.write {
            realm.add(saveRoom)
        }
        
    }
    
    public func InRoom(castPlayer: CastPlayer){
        inRoom = true
        
    }
    public func NoInRoom(){
        inRoom = false
    }
    
}
