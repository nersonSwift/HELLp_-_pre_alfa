//
//  CardAtack.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 15.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class CardAtack: Card {
    override func effect(player: Player, selectEnemy: Enemy, allEnemy: [Enemy]) {
        selectEnemy.fightStats.takeDMG(dmg: player.fightStats.attackDmg)
    }
    override init() {
        super.init()
        name = "CardAtack"
    }
}
