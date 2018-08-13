//
//  Soul.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 03.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Soul: Enemy {
    override init() {
        super.init()
        name = "Soul"
        taunt = false
        fightStats.maxFightHP = 30
        fightStats.attackDmg = 2
    }
}
