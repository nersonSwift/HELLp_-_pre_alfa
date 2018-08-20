//
//  hpCard.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 20.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class HpCard: Card {
    override func effect(player: Player, selectEnemy: Enemy, allEnemy: [Enemy]) {
        player.fightStats.takeDMG(charactor: player, dmg: -10)
    }
    override init() {
        super.init()
        name = "HpCard"
    }
}
