//
//  Item.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 07.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift

class Item: Object{
    var name: String{
        return ("\(type(of: self))")
    }
    
    @objc dynamic var quantity = 0
    
    func copy() -> Item{
        let item = type(of: self).init()
        item.quantity = quantity
        return item
    }
}
