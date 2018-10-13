//
//  CardInAren.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 12.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class CardInAren: SCNNode {
    var card: Card!
    var positionCard: Dir!
    
    static func criateCardInAren(positionCard: Dir, card: Card) -> CardInAren {
        
        let cardInAren = CardInAren()
        cardInAren.positionCard = positionCard
        cardInAren.name = "Card"
        
        
        switch positionCard{
        case .Up:
            cardInAren.position     = SCNVector3(0, 0, -2.455)
        case .Left:
            cardInAren.position = SCNVector3(-1.227, 0, -2.125)
            cardInAren.eulerAngles  = SCNVector3(0, Float.pi/6 , 0)
        case .Right:
            cardInAren.position = SCNVector3(1.227, 0, -2.126)
            cardInAren.eulerAngles  = SCNVector3(0, -Float.pi/6 , 0)
        default: break
            
        }
        
        cardInAren.geometry = SCNBox(width: 0.909, height: 0.05, length: 1.364, chamferRadius: 0)
        
        cardInAren.setNewCard(card: card)
        
        return cardInAren
    }
    
    func setNewCard(card: Card){
        self.card = card
        
        let cardTextureFront = SCNMaterial()
        let cardTextureBeck = SCNMaterial()
        
        cardTextureFront.diffuse.contents   =   #imageLiteral(resourceName: "scenes.scnassets/textures/" + String(card.name) +  ".jpg")
        cardTextureBeck.diffuse.contents    =   #imageLiteral(resourceName: "scenes.scnassets/textures/" + String(card.name) + ".jpg")
        self.geometry?.materials = [cardTextureFront,cardTextureBeck]
        
    }

}
