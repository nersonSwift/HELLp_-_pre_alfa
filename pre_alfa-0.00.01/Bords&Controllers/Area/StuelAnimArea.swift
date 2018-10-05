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
    
    var doorUp: UIView!
    var doorRight: UIView!
    var doorDown: UIView!
    var doorLeft: UIView!
    
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
        let widthDoor   = areaView!.frame.width/10
        let heightDoor  = widthDoor
        
        let doorUpFrame = CGRect(x:  widthRoom / 2 - widthDoor / 2, y: heightDoor / 2, width: widthDoor, height: heightDoor)
        doorUp = UIView(frame: doorUpFrame)
        newRoomView.addSubview(doorUp)
        
        let doorDownFrame = CGRect(x: widthRoom / 2 - widthDoor / 2, y: heightRoom - heightDoor * 1.5, width: widthDoor, height: heightDoor)
        doorDown = UIView(frame: doorDownFrame)
        newRoomView.addSubview(doorDown)
        
        let doorRightFrame = CGRect(x:  widthRoom - widthDoor * 1.5, y: heightRoom / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doorRight = UIView(frame: doorRightFrame)
        newRoomView.addSubview(doorRight)
        
        let doorLeftFrame = CGRect(x: heightDoor / 2, y: heightRoom / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doorLeft = UIView(frame: doorLeftFrame)
        newRoomView.addSubview(doorLeft)
    }
    
    func createRoomView(){
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
        
        if !area!.brain.thisRoom.enemys.isEmpty{
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
    }
    
    func animStep(dir: Dir){
        
        var offScreenFirst: CGAffineTransform
        var offScreenSecond: CGAffineTransform
        
        createRoomView()
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
    
}
