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
    
}
