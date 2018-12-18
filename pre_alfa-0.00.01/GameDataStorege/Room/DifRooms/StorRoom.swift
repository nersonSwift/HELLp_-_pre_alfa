//
//  StorRoom.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 17.09.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class StorRoom: CloseRoom{
    //var itemInStor: [String : Int]!
    weak var player: Player?
    
    override func setDifRoom(x: Int, y: Int, castPlayer: GameDataStorage) {
        super.setDifRoom(x: x, y: y, castPlayer: castPlayer)
        name = "StorRoom"
        addItems()
    }
    /*
    override func loadRoom(saveRoom: RoomProp, castPlayer: GameDataStorage) {
        super.loadRoom(saveRoom: saveRoom, castPlayer: castPlayer)
        addItems()
    }
    */
    override func InRoom(castPlayer: GameDataStorage) {
        super.InRoom(castPlayer: castPlayer)
        player = castPlayer.player
    }
    
    func addItems(){
        //let a = GetClass.getItemInStore()
        //itemInStor = [a : 5]
    }
    
    func createLogiсButton(payButton: UIButton){
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
    }
    
    @objc func pay(_ sender: UIButton){
        player?.stats.hP -= 1
        
        //for i in itemInStor{
        let key = Key()
        key.quantity = 1
        player?.inventery.addItem(item: key)
        //}
        
    }

}
