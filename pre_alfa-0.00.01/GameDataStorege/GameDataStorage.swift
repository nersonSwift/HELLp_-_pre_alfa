//
//  CastPlayer.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 27.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import RealmSwift

class GameDataStorage{
    
    var player = Player()
    var defaultPlayer = Player()
    var map: Map!
    var playerSet = false
    var loadGame = false
    var realm: Realm!
    var savedRooms: Results<RoomProp>!
    
    init() {
        do{
            //try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            realm = try Realm()
            savedRooms = realm.objects(RoomProp.self)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }catch{
            var lCopySavedRooms: [RoomProp] = []
            autoreleasepool{
                let config = Realm.Configuration(objectTypes: [RoomProp.self])
                let realms = try! Realm(configuration: config)
                let lSavedRooms = realms.objects(RoomProp.self)
                for i in lSavedRooms{
                    lCopySavedRooms.append(i.copy())
                }
            }
            try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            
            realm = try! Realm()
            let f = SaveRoomsd()
            f.enemy2 = " d "
            try! realm.write {
                realm.add(f)
            }
            for i in lCopySavedRooms{
                try! realm.write {
                    realm.add(i)
                }
            }
            savedRooms = realm.objects(RoomProp.self)
            print(savedRooms[1].name)
        }
        /*
        let saveRoom = SaveRoomsd()
        try! realm.write {
            realm.add(saveRoom)
        }*/
    
        //let a = realm.objects(SaveRoomsd.self)
        
        map = Map(gameDataStorage: self)
    }
    
    func startGame(){
        map = Map(gameDataStorage: self)
        player = defaultPlayer.copy()
    }
    
    
}
