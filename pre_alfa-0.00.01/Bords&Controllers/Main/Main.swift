//
//  MainMenu.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit


class Main: UIViewController, NavigationProtocol {
    static func storyboardInstance(navigation: Navigation) -> UIViewController? {return Main()}
    
    
    var gameDataStorage: GameDataStorage!
    var navigation: Navigation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation = Navigation(viewController: self)
        gameDataStorage = navigation.gameDataStorage
    }

    @IBAction func startGame(_ sender: Any) {
        
        if !gameDataStorage.playerSet{
            return
        }
        try! gameDataStorage.realm.write {
            gameDataStorage.realm.delete(gameDataStorage.savedRooms)
        }
        gameDataStorage.loadGame = false
        navigation.transitionToView(viewControllerType: Area(), special: nil)
    }
    
    @IBAction func continueGame(_ sender: Any) {
        if gameDataStorage.savedRooms.isEmpty{
            return
        }
        var x = 0
        var y = 0
        gameDataStorage.loadGame = true
        
        gameDataStorage.player = Lilit()
        gameDataStorage.player.stats.cards = [CardAtack(),HpCard()]
        for i in gameDataStorage.savedRooms{
            
            let newRoom = GetClass.getRoom(name: i.name)
            newRoom.loadRoom(saveRoom: i, castPlayer: gameDataStorage)
            gameDataStorage.map.mapRooms[String(newRoom.x) + String(newRoom.y)] = newRoom
            
            if !newRoom.firstVisitingTriger{
                newRoom.criateBlockMapRoom(castPlayer: gameDataStorage)
            }
            
            if i.inRoom{
                x = i.x
                y = i.y
            }
        }
        gameDataStorage.player.x = x
        gameDataStorage.player.y = y
       
        for i in gameDataStorage.map.mapRooms{
            print(String(i.value.id) + " - " + i.value.nameRoom)
        }
        
        navigation.transitionToView(viewControllerType: Area(), special: nil)
    }
    
    @IBAction func palyerCast(_ sender: Any) {
        navigation.transitionToView(viewControllerType: PlayerCast(), special: nil)
    }
    
}

