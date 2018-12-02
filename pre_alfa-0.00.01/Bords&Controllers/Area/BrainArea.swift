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
    
    var castPlayer: GameDataStorage!{
        return area.gameDataStorage
    }
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
    
    private func refreshDoors(){
        for i in thisRoom.Doors{
            if i.value == Door.whatDoor {
                if let newRoom = castPlayer.map.createDifRoom(dir: i.key){
                    thisRoom.Doors[i.key] = newRoom.typeDoors
                }else{
                    thisRoom.Doors[i.key] = Door.woodDoor
                }
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
            print(nextRoom.close)
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
        refreshDoors()
        thisRoom.firstVisiting(castPlayer: castPlayer)
        return thisRoom
        
    }
    
    func startGame(){
        castPlayer.startGame()
        thisRoom = ComRoom(castPlayer: castPlayer)
        castPlayer.map.mapRooms = ["00" : thisRoom]
        thisRoom.enemys = []
        thisRoom.InRoom(castPlayer: castPlayer)
        refreshDoors()
        thisRoom.firstVisiting(castPlayer: castPlayer)
    }
    
    func continueGame(){
        let x = castPlayer.player.x
        let y = castPlayer.player.y
        thisRoom = castPlayer!.map.mapRooms[String(x) + String(y)]!
        thisRoom.InRoom(castPlayer: castPlayer)
    }
    
}
