//
//  MapView.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 13.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class MapView: UIViewController {

    @IBOutlet var scene: SCNView!
    var a: SCNScene!
    
    static func storyboardInstance(scene: SCNScene) -> MapView? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? MapView
        viewController!.a = scene
        return viewController
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene.scene = a
        addSwipe()
        scene.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
