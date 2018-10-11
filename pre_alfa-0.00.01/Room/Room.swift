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
        set(firstVisitingTriger) {
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
                    switch i.key{
                    case .Up: saveRoom.up = i.value.rawValue
                    case .Right: saveRoom.right = i.value.rawValue
                    case .Down: saveRoom.down = i.value.rawValue
                    case .Left: saveRoom.left = i.value.rawValue
                    }
                }
            }
        }
        get{
            var doors: [Dir: Door] = [:]
            doors[.Up]     = GetClass.getDoor(name: saveRoom.up)
            doors[.Right]  = GetClass.getDoor(name: saveRoom.right)
            doors[.Down]   = GetClass.getDoor(name: saveRoom.down)
            doors[.Left]   = GetClass.getDoor(name: saveRoom.left)
            return doors
        }
    }
    
    init(){saveThisRoom()}
    
    func openRoom(player: Player) -> Bool{return true}
    
    func loadRoom(saveRoom: SaveRoom, castPlayer: CastPlayer){
        try! realm.write {
            realm.delete(self.saveRoom)
            self.saveRoom = saveRoom
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
    
    public func InRoom(castPlayer: CastPlayer){
        inRoom = true
        
    }
    public func NoInRoom(){
        inRoom = false
    }
    
}
