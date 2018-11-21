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
    override init(){super.init()}
    
    init(castPlayer: GameDataStorage){
        super.init()
        nameRoom = "ComRoom"
        createCommonEnemy()
        
        Ginirate()
        self.x = castPlayer.player.x
        self.y = castPlayer.player.y
        
        if let roomUp = castPlayer.map.mapRooms[String(x) + String(y+1)]{
            Doors[Dir.Up] = roomUp.Doors[Dir.Down]
        }
        if let roomRight = castPlayer.map.mapRooms[String(x+1) + String(y)]{
            Doors[Dir.Right] = roomRight.Doors[Dir.Left]
        }
        if let roomDown = castPlayer.map.mapRooms[String(x) + String(y-1)]{
            Doors[Dir.Down] = roomDown.Doors[Dir.Up]
        }
        if let roomLeft = castPlayer.map.mapRooms[String(x-1) + String(y)]{
            Doors[Dir.Left] = roomLeft.Doors[Dir.Right]
        }
        
        
        
    }
}
