//
//  ViewController.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 02.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit



class area: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    private var second = -1
    
    
    static func storyboardInstance() -> area? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? area
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    var brain = BrainArea()
    
    var stopButton: UIButton!
    
    var roomView: UIView!
    var newRoomView: UIView!
    
    var doorUp: UIView!
    var doorRight: UIView!
    var doorDown: UIView!
    var doorLeft: UIView!
    
    var widthDoor: CGFloat{
        return self.view.frame.width/10
    }
    var heightDoor: CGFloat{
        return widthDoor
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case .down:  brain.step(dir: .Up, area: self)
                case .left:  brain.step(dir: .Right, area: self)
                case .up:    brain.step(dir: .Down, area: self)
                case .right: brain.step(dir: .Left, area: self)
            default: break
            }
        }
    }


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    @IBAction func Fight(_ sender: Any) {
        if brain.thisRoom.enemys.count != 0{
            if let nextViewController = FightAren.storyboardInstance() {
                nextViewController.brain.castPlayer = brain.castPlayer
                nextViewController.brain.room = brain.thisRoom
                nextViewController.brain.fightAren = nextViewController
                self.present(nextViewController, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func menu(_ sender: UIButton) {
        let date = Date()
        let calendar = Calendar.current
        if second == calendar.component(.second, from: date){
            if let nextViewController = PlayMenu.storyboardInstance() {
                nextViewController.modalPresentationStyle = .custom
                nextViewController.scene = brain.castPlayer.map.map3D.scene
                self.present(nextViewController, animated: true, completion: nil)
            }
        }else{
            second = calendar.component(.second, from: date)
        }
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func createRoomView(){
        
        newRoomView = UIView(frame: self.view.bounds)
        self.view.addSubview(newRoomView)
        
        let doorUpFrame = CGRect(x:  self.view.frame.width/2 - widthDoor / 2, y: heightDoor / 2, width: widthDoor, height: heightDoor)
        doorUp = UIView(frame: doorUpFrame)
        newRoomView.addSubview(doorUp)
        
        let doorDownFrame = CGRect(x: self.view.frame.width / 2 - widthDoor / 2, y: self.view.frame.height - heightDoor * 1.5, width: widthDoor, height: heightDoor)
        doorDown = UIView(frame: doorDownFrame)
        newRoomView.addSubview(doorDown)
        
        let doorRightFrame = CGRect(x:  self.view.frame.width - widthDoor * 1.5, y: self.view.frame.height / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doorRight = UIView(frame: doorRightFrame)
        newRoomView.addSubview(doorRight)
        
        let doorLeftFrame = CGRect(x: heightDoor / 2, y: self.view.frame.height / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doorLeft = UIView(frame: doorLeftFrame)
        newRoomView.addSubview(doorLeft)
        
        stopButton = UIButton(frame: self.view.bounds)
        stopButton.addTarget(self, action: #selector(menu), for: .touchUpInside)
        newRoomView.addSubview(stopButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRoomView()
        roomView = newRoomView
        
        brain.startView(area: self)
        addSwipe()
        
        
    }
    
    @IBAction func unwindToArea (sender: UIStoryboardSegue){}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
}

