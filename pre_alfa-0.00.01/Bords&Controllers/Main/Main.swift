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
            gameDataStorage.realm.deleteAll()
        }
        gameDataStorage.loadGame = false
        navigation.transitionToView(viewControllerType: Area(), special: nil)
    }
    
    @IBAction func continueGame(_ sender: Any) {
        if gameDataStorage.map.mapRooms.isEmpty{
            return
        }
        var x = 0
        var y = 0
        
        gameDataStorage.loadGame = true
        gameDataStorage.player = Lilit()
        gameDataStorage.player.stats.cards = [CardAtack(),HpCard()]
        
        for i in gameDataStorage.map.mapRooms{
            
            let newRoom = i.value
            
            if !newRoom.firstVisitingTriger{
                newRoom.criateBlockMapRoom(castPlayer: gameDataStorage)
            }
            
            if newRoom.inRoom{
                x = newRoom.x
                y = newRoom.y
            }
        }
        
        gameDataStorage.player.x = x
        gameDataStorage.player.y = y
        
        navigation.transitionToView(viewControllerType: Area(), special: nil)
    }
    
    @IBAction func palyerCast(_ sender: Any) {
        navigation.transitionToView(viewControllerType: PlayerCast(), special: nil)
    }
    
}

