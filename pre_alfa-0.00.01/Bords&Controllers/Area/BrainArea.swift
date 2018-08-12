//
//  Brain.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class BrainArea {
    
    private var doorUp      = UILabel()
    private var doorRight   = UILabel()
    private var doorDown    = UILabel()
    private var doorLeft    = UILabel()
    
    var castPlayer = CastPlayer()
    var thisRoom: Room = ComRoom(castPlayer: CastPlayer())
    
    var y: Int{
        return castPlayer.player.y
    }
    var x: Int{
        return castPlayer.player.x
    }
    var xy: String{
        return String(x) + String(y)
    }
    
    private func refreshDoor(dir: Dir) -> String{
        var difDir = Dir.Down
        
        switch dir{
            case .Up    :difDir = .Down
            case .Right :difDir = .Left
            case .Down  :difDir = .Up
            case .Left  :difDir = .Right
        }
        
        if thisRoom.Doors[dir.rawValue] == Door.whatDoor {
            let newRoom = castPlayer.map.WhatIsIt(dir: dir)
            if castPlayer.map.createDifRoom(room: newRoom, dir: dir){
                thisRoom.Doors[dir.rawValue] = castPlayer.map.mapRooms[String(newRoom.x) + String(newRoom.y)]!.Doors[difDir.rawValue]
            }else{
                thisRoom.Doors[dir.rawValue] = Door.woodDoor
            }
        }
        return thisRoom.Doors[dir.rawValue]!.rawValue
    }
    
    private func refreshRoom() {
        
        doorUp.text      = refreshDoor(dir: .Up)
        doorRight.text   = refreshDoor(dir: .Right)
        doorDown.text    = refreshDoor(dir: .Down)
        doorLeft.text    = refreshDoor(dir: .Left)
        
    }
    
    private func animStep(dir: Dir, Area: area) -> UIViewController{
        
        if Area.trig{
            if let nextViewController = area.storyboardInstance() {
                nextViewController.brain = self
                nextViewController.trig = false
                nextViewController.backViewController = Area
                let animArea = AnimArea(dir: dir)
                nextViewController.transitioningDelegate = animArea
                Area.present(nextViewController, animated: true, completion: nil)
                return nextViewController
            }
        }else{
            Area.backViewController!.viewDidLoad()
            let a = AnimArea(dir: dir)
            Area.transitioningDelegate = a
            Area.dismiss(animated: true, completion: nil)
            return Area.backViewController!
        }
        return Area
    }
    
    private func checkIn(dir: Dir) -> Bool{
        
        if thisRoom.enemys.count != 0{
            for i in thisRoom.enemys{
                if i.taunt{
                    return false
                }
            }
        }
        let checkDoor = thisRoom.Doors[dir.rawValue]!
        
        switch checkDoor {
        case .noDoor: return false
        case .closeDoor:
            for i in castPlayer.player.inventery.bag{
                print("p - " + i.key + "-" + i.value.name + String(i.value.quantity))
            }
            if castPlayer.player.inventery.DellItem(steckItem: StackItem(item: Key(), quantity: 1)){
                thisRoom.Doors[dir.rawValue] = Door.openDoor
                return true
            }else{
                return false
            }
            
        default: break
        }
        return true
    }
    
    func step(dir: Dir, area: area){
        
        if !checkIn(dir: dir) {
            return
        }
        
        thisRoom.NoInRoom()
        
        switch dir{
            case .Up:      castPlayer.player.y += 1
            case .Right:   castPlayer.player.x += 1
            case .Down:    castPlayer.player.y -= 1
            case .Left:    castPlayer.player.x -= 1
        }
        
        if castPlayer.map.mapRooms[xy] != nil{
            thisRoom = castPlayer.map.mapRooms[xy]!
        }
        else{
            castPlayer.map.mapRooms[xy] = ComRoom(castPlayer: castPlayer)
            thisRoom = castPlayer.map.mapRooms[xy]!
        }
        
        thisRoom.InRoom(castPlayer: castPlayer)
        
        let newViewController = animStep(dir: dir, Area: area)
        
        if castPlayer.player.dieGame{
            if let nextViewController = LostBord.storyboardInstance() {
                nextViewController.modalPresentationStyle = .custom
                newViewController.present(nextViewController, animated: true, completion: nil)
            }
        }
        
    }
    
    func startView(area: area) {
        
        self.doorUp     = area.doorUp
        self.doorRight  = area.doorRight
        self.doorDown   = area.doorDown
        self.doorLeft   = area.doorLeft
        
        switch thisRoom.nameRoom {
        case "ob":          area.view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "DMG":         area.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case "CloseRoom":   area.view.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            
        default: break
        }
        
        refreshRoom()
        
    }
    
    func StartGame(){
        castPlayer.map.mapRooms = ["00" : thisRoom]
        refreshRoom()
    }
    
}
