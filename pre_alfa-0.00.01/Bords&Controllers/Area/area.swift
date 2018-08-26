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
    
    
    weak var backViewController: area?
    var brain = BrainArea()
    var trig = true
    
    @IBOutlet weak var doorUp: UILabel!
    @IBOutlet weak var doorRight: UILabel!
    @IBOutlet weak var doorDown: UILabel!
    @IBOutlet weak var doorLeft: UILabel!
    @IBOutlet weak var countRoom: UILabel!
    
    
    
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
    
    
    @IBAction func Menu(_ sender: Any) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brain.startView(area: self)
        addSwipe()
        
        
    }
    
    @IBAction func unwindToArea (sender: UIStoryboardSegue){}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
}

