//
//  Navigation.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 12/11/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Navigation{
    var controllers: [UIViewController] = []
    var selectView: UIViewController{
        return controllers.last!
    }
    var castPlayer: CastPlayer!
    
    init(viewController: UIViewController, castPlayer: CastPlayer) {
        controllers.append(viewController)
        self.castPlayer = castPlayer
    }

    func transitionToView(viewControllerType: NavigationProtocol, special: ((UIViewController) -> Void)? ){
        
        for i in 0 ..< controllers.count{
              
            if type(of: viewControllerType) == type(of: controllers[i]) {
                controllers[i].dismiss(animated: true, completion: nil)
                controllers[i+1 ..< controllers.count] = []
                return
            }
        }
        
        if let nextViewController = type(of: viewControllerType).storyboardInstance(navigation: self) {
            if let c = special{
                c(nextViewController)
            }
            selectView.present(nextViewController, animated: true, completion: nil)
            controllers.append(nextViewController)
        }
    }
}
