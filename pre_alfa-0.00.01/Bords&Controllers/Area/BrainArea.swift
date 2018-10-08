//
//  Brain.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class BrainArea {
    private var countRoom   = UILabel()
    private var doorUp      = UIView()
    private var doorRight   = UIView()
    private var doorDown    = UIView()
    private var doorLeft    = UIView()
    
    weak var area: Area!
    
    var castPlayer: CastPlayer!
    var thisRoom: Room! //= ComRoom(castPlayer: CastPlayer())
    
    var y: Int{
        return castPlayer.player.y
    }
    var x: Int{
        return castPlayer.player.x
    }
    var xy: String{
        return String(x) + String(y)
    }
    init(area: Area) {
        self.area = area
    }
    
    private func refreshDoor(dir: Dir) -> Door{
        var difDir: Dir
        switch dir{
            case .Up    :difDir = .Down
            case .Right :difDir = .Left
            case .Down  :difDir = .Up
            case .Left  :difDir = .Right
        }

        if thisRoom.Doors[dir.rawValue] == Door.whatDoor {
            if let newRoom = castPlayer.map.createDifRoom(dir: dir){
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
        
        countRoom.text = String(castPlayer.player.stats.counterRoom)
        //thisRoom.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
    }
   
    
    func step(dir: Dir){
        for i in thisRoom.enemys{
            if i.taunt{
                return
            }
        }

        var nX = castPlayer.player.x
        var nY = castPlayer.player.y
        
        switch dir{
            case .Up:      nY += 1
            case .Right:   nX += 1
            case .Down:    nY -= 1
            case .Left:    nX -= 1
        }
        
        if let nextRoom = castPlayer.map.mapRooms[String(nX) + String(nY)]{
            if !nextRoom.openRoom(player: castPlayer.player){
                return
            }
            castPlayer.player.x = nX
            castPlayer.player.y = nY
         
        }
        else{
            castPlayer.player.x = nX
            castPlayer.player.y = nY
            castPlayer.map.mapRooms[xy] = ComRoom(castPlayer: castPlayer)
            
        }
        
        thisRoom.NoInRoom()
        thisRoom = castPlayer.map.mapRooms[xy]!
     //   thisRoom.saveThisRoom(realm: castPlayer.realm, sevedRoom: castPlayer.savedRooms)
        thisRoom.InRoom(castPlayer: castPlayer)
        
        area.stuel.animStep(dir: dir)
        startView()
        
        if castPlayer.player.dieGame{
            if let nextViewController = LostBord.storyboardInstance() {
                nextViewController.modalPresentationStyle = .custom
            }
        }
    }
    
    func startView() {
        
        countRoom  = area.stuel.countRoom
        doorUp     = area.stuel.doorUp
        doorRight  = area.stuel.doorRight
        doorDown   = area.stuel.doorDown
        doorLeft   = area.stuel.doorLeft
        
        
        switch thisRoom.nameRoom {
        case "ComRoom":     area.stuel.roomView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "DmgRoom":     area.stuel.roomView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case "CloseRoom":   area.stuel.roomView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            
        default: break
        }
        
        refreshRoom()
        area.stuel.animEnemyView()
        if let a = thisRoom as? StorRoom{
            let widthDoor   = area.view.frame.width/10
            let heightDoor  = widthDoor
            let payButtonFrame = CGRect(x:  area.stuel.roomView.frame.width/2 - widthDoor / 2, y: area.stuel.roomView.frame.height/2 - heightDoor / 2, width: widthDoor, height: heightDoor)
            let payButton = UIButton(frame: payButtonFrame)
            a.createLogiсButton(payButton: payButton)
            payButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            area.stuel.roomView.addSubview(payButton)
        }
    }
    
    func StartGame(){
        castPlayer.map.mapRooms = ["00" : thisRoom]
        thisRoom.InRoom(castPlayer: castPlayer)
    
        refreshRoom()
    }
    
}
