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
    var saveRoom: SaveRoom!
    var id = 0
    var firstVisitingTriger = true
    var nameRoom = ""
    var close = false
    var inRoom = false
    var enemys: [Enemy] = []
    var x = 0
    var y = 0
    var xy: String{
        return String(x) + String(y)
    }
    var trig = true
    
    
    var Doors = ["Up" : Door.noDoor, "Right" : Door.noDoor, "Down" : Door.noDoor, "Left" : Door.noDoor]
    
    init() {}
    func openRoom(player: Player) -> Bool{return true}
    
    func loadRoom(saveRoom: SaveRoom, castPlayer: CastPlayer){
        id = saveRoom.id
        nameRoom = saveRoom.name
        close = saveRoom.close
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
                    i.id = 0
                    realm.delete(i)
                }
            }
        }

        
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
