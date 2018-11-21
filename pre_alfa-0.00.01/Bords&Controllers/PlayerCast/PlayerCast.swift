//
//  PlayerCast.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 26.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class PlayerCast: UIViewController, NavigationProtocol {
    var navigation: Navigation!
    var castPlayer: GameDataStorage!
    
    static func storyboardInstance(navigation: Navigation) -> UIViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let playerCast = storyboard.instantiateInitialViewController() as? PlayerCast
        playerCast!.navigation = navigation
        playerCast!.castPlayer = navigation.gameDataStorage
        return playerCast
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
                navigation.transitionToView(viewControllerType: Main(), special: nil)
            }
        }
    }
    
    @IBAction func player1(_ sender: Any) {
        castPlayer.playerSet = true
        castPlayer.defaultPlayer = Lilit()
        castPlayer.defaultPlayer.stats.cards = [CardAtack(), HpCard()]
        navigation.transitionToView(viewControllerType: Main(), special: nil)
    }
    @IBAction func Player2(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
