//
//  GameScene.swift
//  GameTutorial2
//
//  Created by John Marshall on 6/30/15.
//  Copyright (c) 2015 John Marshall. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let introLabel = childNodeWithName("introLabel")
        if (introLabel != nil){
            let fade = SKAction.fadeOutWithDuration(1.5)
            
            
            introLabel?.runAction(fade, completion: {
                let doors = SKTransition.doorwayWithDuration(1.5)
                let shooterScene = shooterscene(fileNamed: "shooterscene")
                self.view?.presentScene(shooterScene!, transition: doors)
            })
        }
        let instructLabel = childNodeWithName("instructLabel")
        if (instructLabel != nil){
            let fade = SKAction.fadeOutWithDuration(1.5)
            let doors = SKTransition.doorwayWithDuration(1.5)
            let shooterScene = shooterscene(fileNamed: "shooterscene")
            instructLabel?.runAction(fade, completion: {
                self.view?.presentScene(shooterScene!, transition: doors)
            })
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
