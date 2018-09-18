//
//  StorRoom.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 17.09.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class StorRoom: DifRoom{
    var itemInStor: [String : Int]!
    weak var player: Player?
    
    override func setDifRoom(x: Int, y: Int, castPlayer: CastPlayer) {
        super.setDifRoom(x: x, y: y, castPlayer: castPlayer)
        player = castPlayer.player
        nameRoom = "StorRoom"
        Doors = ["Up" : Door.closeDoor, "Right" : Door.closeDoor, "Down" : Door.closeDoor, "Left" : Door.closeDoor]
        
        CheckNoRoom(castPlayer: castPlayer)
        addItems()
    }
    
    func addItems(){
        let a = GetClass.getItemInStore()
        itemInStor = [a : 5]
    }
    
    func createLogiсButton(payButton: UIButton){
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
    }
    
    @objc func pay(_ sender: UIButton){
        player?.stats.hP -= 1
        for i in itemInStor{
            let newStack = StackItem(item: GetClass.getItem(name: i.key), quantity: i.value)
            player?.inventery.AddItem(steckItem: newStack)
        }
        
    }
    
    
    override func InRoom(castPlayer: CastPlayer) {
        super.InRoom(castPlayer: castPlayer)
        Doors = ["Up" : Door.openDoor, "Right" : Door.openDoor, "Down" : Door.openDoor, "Left" : Door.openDoor]
        
        CheckNoRoom(castPlayer: castPlayer)
        
        let roomUp      = castPlayer.map.mapRooms[String(x) + String(y+1)]
        let roomRight   = castPlayer.map.mapRooms[String(x+1) + String(y)]
        let roomDown    = castPlayer.map.mapRooms[String(x) + String(y-1)]
        let roomLeft    = castPlayer.map.mapRooms[String(x-1) + String(y)]
        
        if (roomUp != nil) && !(roomUp is NoDoorRoom){
            roomUp!.Doors["Down"] = Door.openDoor
            roomUp!.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
        }
        if (roomRight != nil) && !(roomRight is NoDoorRoom){
            roomRight!.Doors["Left"] = Door.openDoor
            roomRight!.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
        }
        if (roomDown != nil) && !(roomDown is NoDoorRoom){
            roomDown!.Doors["Up"] = Door.openDoor
            roomDown!.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
        }
        if (roomLeft != nil) && !(roomLeft is NoDoorRoom){
            roomLeft!.Doors["Right"] = Door.openDoor
            roomLeft!.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
        }
        self.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
        
    }

}
