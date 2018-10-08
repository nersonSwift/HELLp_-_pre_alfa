//
//  PlayerCast.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 26.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class PlayerCast: UIViewController {

    static func storyboardInstance() -> PlayerCast? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PlayerCast
    }
    
    var castPlayer: CastPlayer!
    
    func addSwipe() {
        let direction = UISwipeGestureRecognizerDirection.down
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        gesture.direction = direction
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func Player1(_ sender: Any) {
        castPlayer.playerSet = true
        castPlayer.defaultPlayer = Lilit()
        castPlayer.defaultPlayer.stats.cards = [CardAtack(), HpCard()]
        dismiss(animated: true, completion: nil)
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
