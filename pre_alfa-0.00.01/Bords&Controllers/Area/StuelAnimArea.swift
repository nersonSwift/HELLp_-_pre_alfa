//
//  Stuel&AnimArea.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.09.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class StuelAnimArea{
    weak var areaView: UIView?
    weak var area: Area!
    
    var stopButton: UIButton!
    var countRoom: UILabel!
    
    var roomView: UIView!
    var newRoomView: UIView!
    
    var atackButton: UIButton!
    var atackView: UIView?
    
    var doors: [Dir: UIView] = [:]
    
    var k: CGFloat = 0
    var widthRoom: CGFloat{
        return areaView!.frame.width
    }
    var heightRoom: CGFloat{
        return areaView!.frame.height - k
    }
    
    init(area: Area){
        self.area = area
        self.areaView = area.view
    }
//////////////////
//MARK: - Create//
//////////////////
    func createWall(){
        
        let thicknessWall = ((heightRoom + widthRoom) / 2) / 15
        let a = #imageLiteral(resourceName: "scenes.scnassets/textures/wall.jpg")
        
        let rightWallFrame = CGRect(x:  widthRoom - thicknessWall, y: 0, width: thicknessWall, height: heightRoom)
        let rightWall = UIView(frame: rightWallFrame)
        rightWall.backgroundColor = UIColor(patternImage: a)
        newRoomView.addSubview(rightWall)
        
        print(thicknessWall)
        let upWallFrame = CGRect(x:  0, y: 0, width: widthRoom, height: thicknessWall)
        let upWall = UIView(frame: upWallFrame)
        upWall.backgroundColor = UIColor(patternImage: a)
        newRoomView.addSubview(upWall)
        
        let leftWallFrame = CGRect(x:  0, y: 0, width: thicknessWall, height: heightRoom)
        let leftWall = UIView(frame: leftWallFrame)
        leftWall.backgroundColor = UIColor(patternImage: a)
        newRoomView.addSubview(leftWall)
        
        let downWallFrame = CGRect(x:  0, y: heightRoom - thicknessWall, width: widthRoom, height: thicknessWall)
        let downWall = UIView(frame: downWallFrame)
        downWall.backgroundColor = UIColor(patternImage: a)
        newRoomView.addSubview(downWall)
        
    }
    func createDoor(){
        let widthDoor   = ((heightRoom + widthRoom) / 2) / 15
        let heightDoor  = widthDoor
        
        let doorUpFrame = CGRect(x:  widthRoom / 2 - widthDoor / 2, y: 0, width: widthDoor, height: heightDoor)
        doors[Dir.Up] = UIView(frame: doorUpFrame)
        newRoomView.addSubview(doors[Dir.Up]!)
        
        let doorDownFrame = CGRect(x: widthRoom / 2 - widthDoor / 2, y: heightRoom - heightDoor, width: widthDoor, height: heightDoor)
        doors[Dir.Down] = UIView(frame: doorDownFrame)
        newRoomView.addSubview(doors[Dir.Down]!)
        
        let doorRightFrame = CGRect(x:  widthRoom - widthDoor, y: heightRoom / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doors[Dir.Right] = UIView(frame: doorRightFrame)
        newRoomView.addSubview(doors[Dir.Right]!)
        
        let doorLeftFrame = CGRect(x: 0, y: heightRoom / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doors[Dir.Left] = UIView(frame: doorLeftFrame)
        newRoomView.addSubview(doors[Dir.Left]!)
    }
    
    func createRoomView(room: Room){
        let widthDoor   = areaView!.frame.width/10
        let heightDoor  = widthDoor
        
        if (2.16 < (heightRoom / widthRoom)) && ((heightRoom / widthRoom) < 2.17) {
            k = heightRoom / 27
        }
        
        let fd = CGRect(x: 0, y: k, width: widthRoom, height: heightRoom)
        newRoomView = UIView(frame: fd)
        areaView!.addSubview(newRoomView)
        
        let forTen = CGRect(x:  0, y: 0, width: widthRoom, height: k)
        let forTenE = UIView(frame: forTen)
        forTenE.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        areaView!.addSubview(forTenE)
        
        createWall()
        createDoor()
        
        let countRoomFrame = CGRect(x: widthRoom / 2 - widthDoor * 1.5, y: heightDoor * 2, width: widthDoor * 3, height: heightDoor)
        countRoom = UILabel(frame: countRoomFrame)
        countRoom.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 0), size: ((heightRoom + widthRoom) / 2) / 12)
        countRoom.text = "24"
        countRoom.textAlignment = .center
        newRoomView.addSubview(countRoom)
        
        stopButton = UIButton(frame: areaView!.bounds)
        stopButton.addTarget(area!, action: #selector(area!.menu), for: .touchDownRepeat)
        newRoomView.addSubview(stopButton)
        
        if !room.enemys.isEmpty{
            let atackViewFrame = CGRect(x:  areaView!.frame.width/2 - widthDoor * 3 / 2 , y: -widthDoor * 3, width: widthDoor * 3, height: widthDoor * 3)
            atackView = UIView(frame: atackViewFrame)
            atackView!.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            atackView?.isHidden = true
            
            
            let atackFrame = CGRect(x:  atackView!.frame.width/2 - widthDoor / 2, y: atackView!.frame.height/2 - heightDoor / 2, width: widthDoor, height: heightDoor)
            atackButton = UIButton(frame: atackFrame)
            
            atackButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            atackButton.addTarget(area!, action: #selector(area!.fight), for: .touchUpInside)
            
            atackView!.addSubview(atackButton)
            newRoomView.addSubview(atackView!)
        }
        
        if let a = room as? StorRoom{
            let widthDoor   = area.view.frame.width/10
            let heightDoor  = widthDoor
            let payButtonFrame = CGRect(x:  roomView.frame.width/2 - widthDoor / 2, y: roomView.frame.height/2 - heightDoor / 2, width: widthDoor, height: heightDoor)
            let payButton = UIButton(frame: payButtonFrame)
            a.createLogiсButton(payButton: payButton)
            payButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            newRoomView.addSubview(payButton)
        }
    }
////////////////
//MARK: - Anim//
////////////////
    func animStep(dir: Dir){
        
        var offScreenFirst: CGAffineTransform
        var offScreenSecond: CGAffineTransform
        
        switch dir {
        case .Up:
            offScreenFirst = CGAffineTransform(translationX: 0, y: -heightRoom + k)
            offScreenSecond = CGAffineTransform(translationX: 0, y: heightRoom - k)
        case .Right:
            offScreenFirst = CGAffineTransform(translationX: widthRoom, y: 0)
            offScreenSecond = CGAffineTransform(translationX: -widthRoom, y: 0)
        case .Down:
            offScreenFirst = CGAffineTransform(translationX: 0, y: heightRoom - k)
            offScreenSecond = CGAffineTransform(translationX: 0, y: -heightRoom + k)
        case .Left:
            offScreenFirst = CGAffineTransform(translationX: -widthRoom, y: 0)
            offScreenSecond = CGAffineTransform(translationX: widthRoom, y: 0)
        }
        newRoomView.transform = offScreenFirst
        let oldRoomView = roomView
        
        UIView.animate(withDuration: 0.9, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.81, options: [], animations: { () -> Void in
            self.newRoomView.transform = self.areaView!.transform
            self.roomView.transform = offScreenSecond
        }){(finished) -> Void in
            oldRoomView?.removeFromSuperview()
            if self.atackView != nil{
                self.atackView!.isHidden = false
            }
        }
        roomView = newRoomView
    }
    
    func animEnemyView(){
        if atackView != nil{
            UIView.animate(withDuration: 0.5, delay: 0.9, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.81, options: [] , animations: { () -> Void in
                self.atackView!.transform.ty += self.heightRoom / 2 + self.atackView!.frame.height / 2
            })
        }
    }
///////////////////
//MARK: - Оutput//
//////////////////
    func setColorDoor(door: Door) -> UIColor{
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
    
    func outputRoom(room: Room){
        switch room.nameRoom {
        case "ComRoom":     roomView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case "DmgRoom":     roomView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case "CloseRoom":   roomView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            
        default: break
        }
        for i in doors{
            i.value.backgroundColor = setColorDoor(door: room.Doors[i.key]!)
        }
        countRoom.text = String(area!.gameDataStorage.player.stats.counterRoom)
    }
}
