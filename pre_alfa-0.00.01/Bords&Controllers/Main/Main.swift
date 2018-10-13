//
//  MainMenu.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit


class Main: UIViewController {
    let castPlayer = CastPlayer()

    @IBAction func startGame(_ sender: Any) {
        if !castPlayer.playerSet{
            return
        }
        try! castPlayer.realm.write {
            castPlayer.realm.delete(castPlayer.savedRooms)
        }
        castPlayer.loadGame = false
        if let nextViewController = Area.storyboardInstance(castPlayer: castPlayer) {
            present(nextViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func continueGame(_ sender: Any) {
        if castPlayer.savedRooms.isEmpty{
            return
        }
        var x = 0
        var y = 0
        castPlayer.loadGame = true
        
        castPlayer.player = Lilit()
        castPlayer.player.stats.cards = [CardAtack(),HpCard()]
        for i in castPlayer.savedRooms{
            
            let newRoom = GetClass.getRoom(name: i.name)
            newRoom.loadRoom(saveRoom: i, castPlayer: castPlayer)
            castPlayer.map.mapRooms[String(newRoom.x) + String(newRoom.y)] = newRoom
            
            if !newRoom.firstVisitingTriger{
                newRoom.criateBlockMapRoom(castPlayer: castPlayer)
            }
            
            if i.inRoom{
                x = i.x
                y = i.y
            }
        }
        castPlayer.player.x = x
        castPlayer.player.y = y
       
        for i in castPlayer.map.mapRooms{
            print(String(i.value.id) + " - " + i.value.nameRoom)
        }
        
        if let nextViewController = Area.storyboardInstance(castPlayer: castPlayer) {
            present(nextViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func palyerCast(_ sender: Any) {
        if let nextViewController = PlayerCast.storyboardInstance(){
            nextViewController.castPlayer = castPlayer
            present(nextViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){}
}

