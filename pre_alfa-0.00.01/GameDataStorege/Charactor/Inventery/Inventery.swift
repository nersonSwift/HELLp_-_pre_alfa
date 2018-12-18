//
//  Inventery.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 07.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift


class Inventery: Object{
    @objc dynamic var urlRealmItems = ""
    var realmItem: Realm{
        var config = Realm.Configuration()
        config.fileURL = URL(fileURLWithPath: urlRealmItems)
        let realm = try! Realm(configuration: config)
        Realm.Configuration.defaultConfiguration = config
        return realm
    }
    
    var bag: [String: Item] = [:]
    
    func addItem(item: Item){
        
        if bag[item.name] != nil{
            bag[item.name]!.quantity += item.quantity
        }else{
            bag[item.name] = item
        }
    }
    
    func dellItem(item: Item) -> Bool{
        if bag[item.name] == nil{
            return false
        }
        if bag[item.name]!.quantity < item.quantity{
            return false
        }
        bag[item.name]!.quantity -= item.quantity
        if bag[item.name]!.quantity == 0{
            bag[item.name] = nil
        }
        return true
    }
    
    func copy() -> Inventery{
        let inventery = type(of: self).init()
        for item in bag{
            inventery.bag[item.key] = item.value.copy()
        }
        return inventery
    }
    
}
