//
//  Sashka.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 25/11/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Sashka: Player {
    required init() {
        super.init()
        name = "Sashka"
        fightStats.attackDmg = 30
        stats.maxHP = 5
        stats.hP = 5
        
        let key = Key()
        key.quantity = 3
        inventery.addItem(item: key)
    }
}
