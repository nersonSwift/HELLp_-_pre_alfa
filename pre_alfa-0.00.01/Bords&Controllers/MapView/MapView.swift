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

class MapView: UIViewController, NavigationProtocol  {
    var navigation: Navigation!
    
    static func storyboardInstance(navigation: Navigation) -> UIViewController? {
        let storyboard = UIStoryboard(name: "\(self)", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? MapView
        viewController!.sceneMap = navigation.gameDataStorage.map.map3D.scene
        viewController!.navigation = navigation
        return viewController
    }
    

    @IBOutlet var scene: SCNView!
    var sceneMap: SCNScene!
    
    func addSwipe() {
        let direction = UISwipeGestureRecognizer.Direction.down
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        gesture.direction = direction
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                navigation.transitionToView(viewControllerType: PlayMenu(), special: {(nextViewController: UIViewController) in
                    let playMenu = nextViewController as? PlayMenu
                    playMenu?.modalPresentationStyle = .custom
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene.scene = sceneMap
        addSwipe()
        scene.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
