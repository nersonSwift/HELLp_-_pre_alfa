//
//  NavigationController.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 08/11/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class NavigationController: UIViewController {
    var controllers: [UIViewController] = []
    let castPlayer = CastPlayer()
    var navigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToArea(){
        for i in controllers{
            if i is Area{
                
                i.dismiss(animated: true, completion: nil)
                return
            }
        }
        if let nextViewController = Area.storyboardInstance(castPlayer: castPlayer, navigation: self){
            controllers.append(nextViewController)
            controllers.last!.show(nextViewController, sender: nil)
        }
    }
}

