//
//  Inventery.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 07.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

struct Inventery{
    var bag: [String: StackItem] = [:]
    
    mutating func AddItem(steckItem: StackItem){
        if bag[steckItem.name] != nil{
            bag[steckItem.name]?.quantity += steckItem.quantity
        }else{
            bag[steckItem.name] = steckItem
        }
    }
    
    mutating func DellItem(steckItem: StackItem) -> Bool{
        if bag[steckItem.name] == nil{
            return false
        }
        if bag[steckItem.name]!.quantity < steckItem.quantity{
            return false
        }
        bag[steckItem.name]!.quantity -= steckItem.quantity
        if bag[steckItem.name]!.quantity == 0{
            bag[steckItem.name] = nil
        }
        return true
    }
}