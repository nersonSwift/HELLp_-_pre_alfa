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
    
    var saveRoom = SaveRoom()
    
    let realm = try! Realm()
    var savedRooms: Results<SaveRoom>!
    
////////////////////
//MARK: - Property//
////////////////////
    var id: Int{
        set(id) {
            try! realm.write {
                saveRoom.id = id
            }
        }
        get{
            return saveRoom.id
        }
    }
    var firstVisitingTriger: Bool{
        set(firstVisitingTriger) {
            try! realm.write {
                saveRoom.firstVisitingTriger = firstVisitingTriger
            }
        }
        get{
            return saveRoom.firstVisitingTriger
        }
    }
    var nameRoom : String{
        set(nameRoom) {
            try! realm.write {
                saveRoom.name = nameRoom
            }
        }
        get{
            return saveRoom.name
        }
    }
    var close: Bool{
        set(close) {
            try! realm.write {
                saveRoom.close = close
            }
        }
        get{
            return saveRoom.close
        }
    }
    var x: Int{
        set(x) {
            try! realm.write {
                saveRoom.x = x
            }
        }
        get{
            return saveRoom.x
        }
    }
    var y: Int{
        set(y) {
            try! realm.write {
                saveRoom.y = y
            }
        }
        get{
            return saveRoom.y
        }
    }
    var inRoom : Bool{
        set(inRoom) {
            try! realm.write {
                saveRoom.inRoom = inRoom
            }
        }
        get{
            return saveRoom.inRoom
        }
    }
 
    var enemys: [Enemy] = []
    var xy: String{
        return String(x) + String(y)
    }
    var Doors: [Dir: Door]{
        set(doors){
            try! realm.write {
                for i in doors{
                    saveRoom[i.key.rawValue] = i.value.rawValue
                }
            }
        }
        get{
            var doors: [Dir: Door] = [:]
            let dirDoor: [Dir] = [.Up, .Right, .Down, .Left]
            for i in dirDoor{
                let nameRoom = saveRoom[i.rawValue] as! String
                doors[i] = GetClass.getDoor(name: nameRoom)
            }
            return doors
        }
    }
    
/////////////////
//MARK: - Func//
////////////////
    
    init(){saveThisRoom()}
    func openRoom(player: Player) -> Bool{return true}
    
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
    
    public func InRoom(castPlayer: CastPlayer){
        inRoom = true
        
    }
    public func NoInRoom(){
        inRoom = false
    }
    
/////////////////////
//MARK: - RealmFunc//
/////////////////////
    
    func saveThisRoom(){
        try! realm.write {
            realm.add(saveRoom)
        }
    }
    func delRoom(){
        try! realm.write {
             realm.delete(self.saveRoom)
        }
    }
    
    func loadRoom(saveRoom: SaveRoom, castPlayer: CastPlayer){
        try! realm.write {
            realm.delete(self.saveRoom)
            self.saveRoom = saveRoom
        }
    }
    
}
