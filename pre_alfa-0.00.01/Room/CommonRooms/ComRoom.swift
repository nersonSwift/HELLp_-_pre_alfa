//
//  ComRoom.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 10.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class ComRoom: Room {
    
    public func Ginirate(){
        for i in Doors{
            Doors[i.key] = GetClass.getComDoor()
        }
    }
    
    private func createCommonEnemy(){
        for _ in 0...2{
            if let enemy = GetClass.getComEnemy(){
              enemys.append(enemy)
            }
        }
    }
    override init(saveRoom: SaveRoom, castPlayer: CastPlayer) {
        super.init(saveRoom: saveRoom, castPlayer: castPlayer)
    }
    
    init(castPlayer: CastPlayer){
        super.init()
        nameRoom = "ComRoom"
        createCommonEnemy()
        
        Ginirate()
        self.x = castPlayer.player.x
        self.y = castPlayer.player.y
        
        if let roomUp = castPlayer.map.mapRooms[String(x) + String(y+1)]{
            Doors[Dir.Up.rawValue] = roomUp.Doors[Dir.Down.rawValue]
        }
        if let roomRight = castPlayer.map.mapRooms[String(x+1) + String(y)]{
            Doors[Dir.Right.rawValue] = roomRight.Doors[Dir.Left.rawValue]
        }
        if let roomDown = castPlayer.map.mapRooms[String(x) + String(y-1)]{
            Doors[Dir.Down.rawValue] = roomDown.Doors[Dir.Up.rawValue]
        }
        if let roomLeft = castPlayer.map.mapRooms[String(x-1) + String(y)]{
            Doors[Dir.Left.rawValue] = roomLeft.Doors[Dir.Right.rawValue]
        }
        
        
        
    }
}
