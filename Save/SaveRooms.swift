//
//  SaveRooms.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 23.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift

class SaveRooms: Object {
    let rooms = List<SavaRoom>()
}
