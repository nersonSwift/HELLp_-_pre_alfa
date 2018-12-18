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
    
    var player: Player!
    var defaultPlayer: Player!
    var map: Map!
    var playerSet = false
    var loadGame = false
    var realm: Realm!
    
    init() {
        loadOrCreateRealm()
        createMap()
    }
    func loadOrCreateRealm(){
        do{
            //try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
            
            let manager = FileManager.default
            try! manager.createDirectory(at: Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().appendingPathComponent("123"), withIntermediateDirectories: true, attributes: nil)
            
            var config = Realm.Configuration()
            config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("123/123.realm")
            print(config.fileURL)
            realm = try Realm(configuration: config)
            Realm.Configuration.defaultConfiguration = config
            print(Door.init(rawValue: "woodDoor"))
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }catch{
            /*
            var lCopySavedRooms: [RoomProp] = []
            autoreleasepool{
                let config = Realm.Configuration(objectTypes: [RoomProp.self])
                let realms = try! Realm(configuration: config)
                let lSavedRooms = realms.objects(RoomProp.self)
                for i in lSavedRooms{
                    lCopySavedRooms.append(i.copy())
                }
            }
            */
            try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().appendingPathComponent("123"))
            /*
            for i in lCopySavedRooms{
                try! realm.write {
                    realm.add(i)
                }
            }
            */
        }
       
    }
    
    func createMap(){
        map = Map(gameDataStorage: self)
        
        for objectType in realm.configuration.objectTypes!{
            if objectType.init() is Room{
                let resaults = realm.objects(objectType)
                for object in resaults{
                    let room = object as! Room
                    map.mapRooms[room.xy] = room
                }
            }
        }
    }
    
    func startGame(){
        map = Map(gameDataStorage: self)
        player = defaultPlayer.copy()
    }
    
    
}
