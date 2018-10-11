//
//  Brain.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class BrainArea {
    weak var area: Area!
    
    var castPlayer: CastPlayer!
    var thisRoom: Room!
    
    var y: Int{
        return castPlayer.player.y
    }
    var x: Int{
        return castPlayer.player.x
    }
    var xy: String{
        return String(x) + String(y)
    }
    init(area: Area) {
        self.area = area
    }
    
    private func refreshDoor(dir: Dir){
        var difDir: Dir
        switch dir{
            case .Up    :difDir = .Down
            case .Right :difDir = .Left
            case .Down  :difDir = .Up
            case .Left  :difDir = .Right
        }

        if thisRoom.Doors[dir] == Door.whatDoor {
            if let newRoom = castPlayer.map.createDifRoom(dir: dir){
                thisRoom.Doors[dir] = castPlayer.map.mapRooms[String(newRoom.x) + String(newRoom.y)]!.Doors[difDir]
            }else{
                thisRoom.Doors[dir] = Door.woodDoor
            }
        }
    }
    
    func step(dir: Dir) -> Room?{
        for i in thisRoom.enemys{
            if i.taunt{
                return nil
            }
        }

        var nX = castPlayer.player.x
        var nY = castPlayer.player.y
        
        switch dir{
            case .Up:      nY += 1
            case .Right:   nX += 1
            case .Down:    nY -= 1
            case .Left:    nX -= 1
        }
        
        if let nextRoom = castPlayer.map.mapRooms[String(nX) + String(nY)]{
            if !nextRoom.openRoom(player: castPlayer.player){
                return nil
            }
            castPlayer.player.x = nX
            castPlayer.player.y = nY
         
        }
        else{
            castPlayer.player.x = nX
            castPlayer.player.y = nY
            castPlayer.map.mapRooms[xy] = ComRoom(castPlayer: castPlayer)
            
        }
        
        thisRoom.NoInRoom()
        thisRoom = castPlayer.map.mapRooms[xy]!
        thisRoom.InRoom(castPlayer: castPlayer)
        
        for i in thisRoom.Doors{
            refreshDoor(dir: i.key)
        }
        thisRoom.firstVisiting(castPlayer: castPlayer)
        return thisRoom
        
    }
    
    func StartGame(){
        thisRoom = ComRoom(castPlayer: castPlayer)
        castPlayer.map.mapRooms = ["00" : thisRoom]
        thisRoom.InRoom(castPlayer: castPlayer)
        
        for i in thisRoom.Doors{
            refreshDoor(dir: i.key)
        }
        thisRoom.firstVisiting(castPlayer: castPlayer)
    }
    
}
