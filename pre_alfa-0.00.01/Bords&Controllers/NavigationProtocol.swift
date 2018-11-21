//
//  NavigationProtocol.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 13/11/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

protocol NavigationProtocol{
    var navigation: Navigation! {get set}
    static func storyboardInstance(navigation: Navigation) -> UIViewController?
}
