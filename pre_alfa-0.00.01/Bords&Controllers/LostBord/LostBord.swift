//
//  LostBord.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 28.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class LostBord: UIViewController, NavigationProtocol {
    var navigation: Navigation!
    
    static func storyboardInstance(navigation: Navigation) -> UIViewController? {
        let storyboard = UIStoryboard(name: "\(self)", bundle: nil)
        let lostBord = storyboard.instantiateInitialViewController() as? LostBord
        lostBord?.navigation = navigation
        return lostBord
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor! = UIColor.white.withAlphaComponent(0.6)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
