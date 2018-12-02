//
//  Card.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 15.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Card: NSObject {
    var name = ""
    var qality = Qality.Common
    
    func effect(player: Player, selectEnemy: Enemy, allEnemy: [Enemy]){}
}
