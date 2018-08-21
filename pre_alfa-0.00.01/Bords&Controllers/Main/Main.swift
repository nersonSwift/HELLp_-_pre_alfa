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

