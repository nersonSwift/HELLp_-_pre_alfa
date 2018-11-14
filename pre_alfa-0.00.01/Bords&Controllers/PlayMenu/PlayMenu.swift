//
//  Menu.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 24.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class PlayMenu: UIViewController, NavigationProtocol {
    var navigation: Navigation!
    
    static func storyboardInstance(navigation: Navigation) -> UIViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let playMenu = storyboard.instantiateInitialViewController() as? PlayMenu
        playMenu!.navigation = navigation
        return playMenu
    }
    
    @IBAction func main(_ sender: Any) {
        navigation.transitionToView(viewControllerType: Main(), special: nil)
    }
    
    @IBAction func map(_ sender: Any) {
        navigation.transitionToView(viewControllerType: MapView(), special: nil)
    }
    
    @IBAction func inventery(_ sender: Any) {
        navigation.transitionToView(viewControllerType: InventeryBoard(), special: nil)
    }
    
    func addSwipe() {
        let direction = UISwipeGestureRecognizer.Direction.down
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        gesture.direction = direction
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                navigation.transitionToView(viewControllerType: Area(), special: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor! = UIColor.white.withAlphaComponent(0.9)
        addSwipe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
