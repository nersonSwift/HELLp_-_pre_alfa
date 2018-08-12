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
            switch arc4random_uniform(100) {
            case 0...49:  Doors[i.key] = .woodDoor
            case 50...69: Doors[i.key] = .ironDoor
            case 70...99: Doors[i.key] = .whatDoor
                
            default: break
            }
        }
    }
    
    private func createCommonEnemy(){
        
        for _ in 0...2{
            switch arc4random_uniform(100) {
            case 0...32:    enemys.append(Soul())
            case 33...66:   enemys.append(Skeleton())
                
            default: break
            }
        }
    }
    
    init(castPlayer: CastPlayer){
        super.init()
        //enemys = [Skeleton(),Soul()]
        createCommonEnemy()
        
        Ginirate()
        self.x = castPlayer.player.x
        self.y = castPlayer.player.y
        
        let roomUp      = castPlayer.map.mapRooms[String(x) + String(y+1)]
        let roomRight   = castPlayer.map.mapRooms[String(x+1) + String(y)]
        let roomDown    = castPlayer.map.mapRooms[String(x) + String(y-1)]
        let roomLeft    = castPlayer.map.mapRooms[String(x-1) + String(y)]
        
        if roomUp != nil{
            Doors[Dir.Up.rawValue] = roomUp!.Doors[Dir.Down.rawValue]
        }
        if roomRight != nil{
            Doors[Dir.Right.rawValue] = roomRight!.Doors[Dir.Left.rawValue]
        }
        if roomDown != nil{
            Doors[Dir.Down.rawValue] = roomDown!.Doors[Dir.Up.rawValue]
        }
        if roomLeft != nil{
            Doors[Dir.Left.rawValue] = roomLeft!.Doors[Dir.Right.rawValue]
        }
        
    }
}
