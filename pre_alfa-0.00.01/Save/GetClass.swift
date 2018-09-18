//
//  GetClass.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 25.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class GetClass{
    static func getComDoor() -> Door{
        switch arc4random_uniform(100) {
            case 0...49:  return .woodDoor
            case 50...69: return .ironDoor
            case 70...99: return .whatDoor
            
        default: return .noDoor
        }
    }
    
    static func getComEnemy() -> Enemy?{
        switch arc4random_uniform(100) {
            case 0...32:    return Soul()
            case 33...66:   return Skeleton()
            
        default: return nil
        }
    }
    
    static func getDifRoom() -> DifRoom{
        switch arc4random_uniform(100) {
            case 0...69:  return NoDoorRoom()
            case 70...79: return DmgRoom()
            case 80...99: return StorRoom()
            
        default: return NoDoorRoom()
        }
    }
    
    static func getItemInStore() -> String{
        switch arc4random_uniform(100) {
        case 0...99: return Key().name
        
            
        default: return ""
        }
    }
    
    static func getItem(name: String) -> Item{
        switch name {
        case "Key":  return Key()
            
        default: return Item()
        }
    }
    
    static func getDoor(name: String)  -> Door{
        switch name {
            case "woodDoor":    return .woodDoor
            case "ironDoor":    return .ironDoor
            case "DMGDoor":     return .dmgDoor
            case "closeDoor":   return .closeDoor
            case "openDoor":    return .openDoor
            case "":            return .noDoor
            case "???":         return .whatDoor
            
        default: return Door.noDoor
        }
    }
    
    static func getEnemy(name: String)  -> Enemy{
        switch name {
            case "Skeleton":    return Skeleton()
            case "Soul":        return Soul()
            
        default: return Enemy()
        }
    }
    
    static func getRoom(name: String)  -> Room{
        switch name{
            case "ComRoom":     return ComRoom()
            case "CloseRoom":   return CloseRoom()
            case "NoDoorRoom":  return NoDoorRoom()
            case "DmgRoom":     return DmgRoom()
            case "StorRoom":    return StorRoom()
            
        default: return Room()
        }
    }
    
    
}
