//
//  InventeryBoard.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 11.09.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class InventeryBoard: UIViewController, UITableViewDelegate, UITableViewDataSource, NavigationProtocol  {
    var navigation: Navigation!
    
    static func storyboardInstance(navigation: Navigation) -> NavigationProtocol? {
        let storyboard = UIStoryboard(name: "\(self)", bundle: nil)
        let inventeryBoard = storyboard.instantiateInitialViewController() as? InventeryBoard
        inventeryBoard?.navigation = navigation
        inventeryBoard?.player = navigation.gameDataStorage.player
        return inventeryBoard
    }
    
    var nrt: [String] = []
    var myTable = UITableView()
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTable()
        for i in player.inventery.bag{
            nrt.append(i.key)
        }
        addSwipe()
    }
    
    //MARK: - createTable
    func createTable(){
        let a = CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: self.view.frame.height / 2)
        self.myTable = UITableView(frame: a, style: .plain)
        self.myTable.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        self.myTable.delegate = self
        self.myTable.dataSource = self
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.myTable)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.inventery.bag.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let call = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        call.textLabel?.text = nrt[indexPath.row] + " -  \(player.inventery.bag[nrt[indexPath.row]]!.quantity)"
        call.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        
        
        
        call.accessoryType = .detailButton
    
        return call
    }
    
    //MARK: - UITableViewDataDelegat
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
    }
    
    func addSwipe() {
        let direction = UISwipeGestureRecognizer.Direction.down
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        gesture.direction = direction
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                navigation.transitionToView(viewControllerType: PlayMenu(), special: {(nextViewController: UIViewController) in
                    let playMenu = nextViewController as? PlayMenu
                    playMenu?.modalPresentationStyle = .custom
                })
            }
        }
    }
    

}
