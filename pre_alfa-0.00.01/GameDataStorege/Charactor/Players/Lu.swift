//
//  lu.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 23/11/2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Lu: Player {
    required init() {
        super.init()
        name = "Lu"
        fightStats.attackDmg = 20
        stats.maxHP = 9
        stats.hP = 9
        
        let key = Key()
        key.quantity = 1
        inventery.addItem(item: key)
    }
}
