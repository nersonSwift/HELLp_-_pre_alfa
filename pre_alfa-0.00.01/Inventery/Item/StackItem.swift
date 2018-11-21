//
//  StackItem.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 28.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

struct StackItem {
    var item = Item()
    var name: String{
        return item.name
    }
    var quantity = 0
    
    init(item: Item, quantity: Int) {
        self.item = item
        self.quantity = quantity
    }
}
