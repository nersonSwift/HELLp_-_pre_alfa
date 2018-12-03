//
//  Room.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 02.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift


class Room: RoomProp {
    
    //var saveRoom = RoomProp()
    
    //let realm = try! Realm()
    var savedRooms: Results<RoomProp>!
    
////////////////////
//MARK: - Property//
////////////////////

 
    var enemys: [Enemy] = []
    
/////////////////
//MARK: - Func//
////////////////
    
    ///required init(){saveThisRoom()}
    func openRoom(player: Player) -> Bool{return true}
    
    func criateBlockMapRoom(castPlayer: GameDataStorage){
        castPlayer.player.stats.counterRoom += 1
        print(castPlayer.player.stats.counterRoom)
        castPlayer.map.map3D.criateBlockMap(map: castPlayer.map, x: x, y: y)
    }
    
    
    public func firstVisiting(castPlayer: GameDataStorage){
        if firstVisitingTriger{
            castPlayer.player.stats.counterRoom += 1
            castPlayer.map.map3D.criateBlockMap(map: castPlayer.map, x: castPlayer.player.x, y: castPlayer.player.y)
            firstVisitingTriger = false
            id = castPlayer.player.stats.counterRoom
        }else{
            castPlayer.map.map3D.refrashBlockMap(map: castPlayer.map, x: castPlayer.player.x, y: castPlayer.player.y)
        }
    }
    
    public func InRoom(castPlayer: GameDataStorage){
        inRoom = true
        
    }
    public func NoInRoom(){
        inRoom = false
    }
    
/////////////////////
//MARK: - RealmFunc//
/////////////////////
    
    
    
    
    
}
