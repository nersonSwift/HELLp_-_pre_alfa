//
//  MainMenu.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 22.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit


class Main: UIViewController {
    let castPlayer = CastPlayer()
    
    @IBOutlet weak var fgd: UILabel!

    @IBAction func StartGame(_ sender: Any) {
        if !castPlayer.playerSet{
            return
        }
        if let nextViewController = area.storyboardInstance() {
            nextViewController.brain.castPlayer = castPlayer
            castPlayer.startGame()
            nextViewController.brain.StartGame()
            present(nextViewController, animated: true, completion: nil)
        }
    }
    @IBAction func continueGame(_ sender: Any) {
        var x = 0
        var y = 0
        castPlayer.player = Lilit()
        castPlayer.player.stats.cards = [CardAtack(),HpCard()]
        for i in castPlayer.savedRooms{
            if i.name != "0"{
                var newRoom: Room
                
                switch i.name{
                case "ComRoom":     newRoom = ComRoom(saveRoom: i, castPlayer: castPlayer)
                case "CloseRoom":   newRoom = CloseRoom(saveRoom: i, castPlayer: castPlayer)
                case "NoDoorRoom":  newRoom = NoDoorRoom(saveRoom: i, castPlayer: castPlayer)
                case "DmgRoom":     newRoom = DmgRoom(saveRoom: i, castPlayer: castPlayer)
                default: newRoom = Room()
                }
                castPlayer.map.mapRooms[String(newRoom.x) + String(newRoom.y)] = newRoom
                if !newRoom.firstVisitingTriger{
                    newRoom.criateBlockMapRoom(castPlayer: castPlayer)
                }
            }else{
                x = i.x
                y = i.y
            }
        }
       
        for i in castPlayer.map.mapRooms{
            print(String(i.value.id) + " - " + i.value.nameRoom)
        }
        
        if let nextViewController = area.storyboardInstance() {
            castPlayer.player.x = x
            castPlayer.player.y = y
            nextViewController.brain.castPlayer = castPlayer
            nextViewController.brain.thisRoom = castPlayer.map.mapRooms[String(x) + String(y)]!
            nextViewController.brain.thisRoom.InRoom(castPlayer: castPlayer)
            nextViewController.brain.refreshRoom()
            present(nextViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func PalyerCast(_ sender: Any) {
        if let nextViewController = PlayerCast.storyboardInstance(){
            nextViewController.castPlayer = castPlayer
            present(nextViewController, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func unwindToViewController (sender: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

