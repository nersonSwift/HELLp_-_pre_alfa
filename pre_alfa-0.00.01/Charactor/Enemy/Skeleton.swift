//
//  Skeleton.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 12.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Skeleton: Enemy {
    override init() {
        super.init()
        name = "Skeleton"
        taunt = false
        fightStats.maxFightHP = 20
        fightStats.attackDmg = 3
    }
}
