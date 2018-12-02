//
//  Lilit.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 27.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Lilit: Player {
    
    required init() {
        super.init()
        name = "Lilit"
        fightStats.attackDmg = 15
        stats.maxHP = 10
        stats.hP = 10
        
        inventery.AddItem(steckItem: StackItem(item: Key(), quantity: 2))
    }
    
}
