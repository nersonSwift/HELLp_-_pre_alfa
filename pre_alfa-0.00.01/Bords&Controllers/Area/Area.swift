//
//  ViewController.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 02.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit



class Area: UIViewController, NavigationProtocol {
    
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
    
    static func storyboardInstance(navigation: Navigation) -> UIViewController? {
        print(String(describing: self))
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let area = storyboard.instantiateInitialViewController() as? Area
        area!.navigation = navigation
        area!.castPlayer = navigation.castPlayer
        return area
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    private var brain: BrainArea!
    private var stuel: StuelAnimArea!
    var navigation: Navigation!
    
    var castPlayer: CastPlayer!
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self,
                                                   action: #selector(self.respondToSwipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        var dir: Dir?
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case .down:     dir = .Up
                case .left:     dir = .Right
                case .up:       dir = .Down
                case .right:    dir = .Left
                
            default: break
            }
            if let nextRoom = brain.step(dir: dir!){
                stuel.animStep(dir: dir!, room: nextRoom)
                stuel.outputRoom(room: nextRoom)
                stuel.animEnemyView()
            }
        }
    }


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
   @objc func fight(_ sender: UIButton) {
        navigation.transitionToView(viewControllerType: FightAren(), special: nil )
    }
    
    
    @objc func menu(_ sender: UIButton) {
        navigation.transitionToView(viewControllerType: PlayMenu(), special: {(nextViewController: UIViewController) in
            let playMenu = nextViewController as? PlayMenu
            playMenu?.modalPresentationStyle = .custom
        })
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brain = BrainArea(area: self)
        stuel = StuelAnimArea(area: self)
        brain.castPlayer = castPlayer
        
        if castPlayer.loadGame{
            brain.continueGame()
        }else{
            brain.startGame()
        }
        
        stuel.createRoomView(room: brain.thisRoom)
        stuel.roomView = stuel.newRoomView
        
        stuel.outputRoom(room: brain.thisRoom)
        
        if stuel.atackView != nil{
            stuel.atackView!.isHidden = false
        }
        addSwipe()
    }
    
    @IBAction func unwindToArea (sender: UIStoryboardSegue){}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
     
}

