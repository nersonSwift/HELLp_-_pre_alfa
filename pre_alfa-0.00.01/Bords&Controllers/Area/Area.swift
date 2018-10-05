//
//  ViewController.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 02.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit



class Area: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        let heightRoom = self.view.frame.height
        let widthRoom = self.view.frame.width
        if (2.16 < (heightRoom / widthRoom)) && ((heightRoom / widthRoom) < 2.17) {
            return false
        }
        return true
    }
    private var second = -1
    
    
    static func storyboardInstance() -> Area? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let area = storyboard.instantiateInitialViewController() as? Area
        area!.brain = BrainArea(area: area!)
        return area
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    var brain: BrainArea!
    var stuel: StuelAnimArea!
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case .down:  brain.step(dir: .Up)
                case .left:  brain.step(dir: .Right)
                case .up:    brain.step(dir: .Down)
                case .right: brain.step(dir: .Left)
            default: break
            }
        }
    }


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
   @objc func fight(_ sender: UIButton) {
        if !brain.thisRoom.enemys.isEmpty{
            if let nextViewController = FightAren.storyboardInstance() {
                nextViewController.brain.castPlayer = brain.castPlayer
                nextViewController.brain.room = brain.thisRoom
                nextViewController.brain.fightAren = nextViewController
                self.present(nextViewController, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func menu(_ sender: UIButton) {
        if let nextViewController = PlayMenu.storyboardInstance() {
            nextViewController.modalPresentationStyle = .custom
            nextViewController.scene = brain.castPlayer.map.map3D.scene
            nextViewController.player = brain.castPlayer.player
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stuel = StuelAnimArea(area: self)
        
        stuel.createRoomView()
        stuel.roomView = stuel.newRoomView
        
        brain.startView()
        if stuel.atackView != nil{
            stuel.atackView!.isHidden = false
        }
        addSwipe()
    }
    
    @IBAction func unwindToArea (sender: UIStoryboardSegue){}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     
}

