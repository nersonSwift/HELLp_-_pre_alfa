//
//  Brain.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class BrainArea {
   // private var countRoom   = UIView()
    private var doorUp      = UIView()
    private var doorRight   = UIView()
    private var doorDown    = UIView()
    private var doorLeft    = UIView()
    
    var castPlayer: CastPlayer!
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
    
    private func refreshDoor(dir: Dir) -> Door{
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
                newRoom.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
                thisRoom.Doors[dir.rawValue] = castPlayer.map.mapRooms[String(newRoom.x) + String(newRoom.y)]!.Doors[difDir.rawValue]
            }else{
                thisRoom.Doors[dir.rawValue] = Door.woodDoor
            }
        }
        return thisRoom.Doors[dir.rawValue]!
    }
    func setColor(door: Door) -> UIColor{
        switch door {
        case .woodDoor:    return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        case .ironDoor:    return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        case .dmgDoor:     return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .closeDoor:   return #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        case .openDoor:    return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .noDoor:      return #colorLiteral(red: 1, green: 0.9470325112, blue: 1, alpha: 0)
        case .whatDoor:    return #colorLiteral(red: 1, green: 0.9470325112, blue: 1, alpha: 1)
        }
    }
    
    
    func refreshRoom() {
        
        doorUp.backgroundColor       = setColor(door: refreshDoor(dir: .Up))
        doorRight.backgroundColor    = setColor(door: refreshDoor(dir: .Right))
        doorDown.backgroundColor     = setColor(door: refreshDoor(dir: .Down))
        doorLeft.backgroundColor     = setColor(door: refreshDoor(dir: .Left))
        thisRoom.firstVisiting(castPlayer: castPlayer)
        
        //countRoom.text = String(castPlayer.player.stats.counterRoom)
        thisRoom.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
        
    }
    
    private func animStep(dir: Dir, Area: area){
        var offScreenFirst: CGAffineTransform
        var offScreenSecond: CGAffineTransform
        
        Area.createRoomView()
        switch dir {
        case .Up:
            offScreenFirst = CGAffineTransform(translationX: 0, y: -Area.view.frame.height)
            offScreenSecond = CGAffineTransform(translationX: 0, y: Area.view.frame.height)
        case .Right:
            offScreenFirst = CGAffineTransform(translationX: Area.view.frame.width, y: 0)
            offScreenSecond = CGAffineTransform(translationX: -Area.view.frame.width, y: 0)
        case .Down:
            offScreenFirst = CGAffineTransform(translationX: 0, y: Area.view.frame.height)
            offScreenSecond = CGAffineTransform(translationX: 0, y: -Area.view.frame.height)
        case .Left:
            offScreenFirst = CGAffineTransform(translationX: -Area.view.frame.width, y: 0)
            offScreenSecond = CGAffineTransform(translationX: Area.view.frame.width, y: 0)
        }
        Area.newRoomView.transform = offScreenFirst
        let oldRoomView = Area.roomView
        
        UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
            Area.newRoomView.transform = Area.view.transform
            Area.roomView.transform = offScreenSecond
        }){(finished) -> Void in
            oldRoomView?.removeFromSuperview()
        }
        
        Area.roomView = Area.newRoomView
        startView(area: Area)
        
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
        
        animStep(dir: dir, Area: area)
        
        
        if castPlayer.player.dieGame{
            if let nextViewController = LostBord.storyboardInstance() {
                nextViewController.modalPresentationStyle = .custom
                //newViewController.present(nextViewController, animated: true, completion: nil)
            }
        }
    }
    
    func startView(area: area) {
        
        //self.countRoom  = area.countRoom
        self.doorUp     = area.doorUp
        self.doorRight  = area.doorRight
        self.doorDown   = area.doorDown
        self.doorLeft   = area.doorLeft
        
        
        switch thisRoom.nameRoom {
        case "ComRoom":     area.roomView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "DmgRoom":     area.roomView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case "CloseRoom":   area.roomView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            
        default: break
        }
        
        refreshRoom()
        
    }
    
    func StartGame(){
        castPlayer.map.mapRooms = ["00" : thisRoom]
        thisRoom.InRoom(castPlayer: castPlayer)
        
        
        refreshRoom()
        
    }
    
}
