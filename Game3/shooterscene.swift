//
//  shooterscene.swift
//  GameTutorial2
//
//  Created by John Marshall on 6/30/15.
//  Copyright © 2015 John Marshall. All rights reserved.
//

import UIKit
import SpriteKit


class shooterscene: SKScene {
    
    var score = 0
    var enemyCount = 10
    var shooterAnimation = [SKTexture]()
    
    
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, -1.2)
        self.initShooterScene()
    }
    func initShooterScene(){
        let shooterAtlas = SKTextureAtlas(named: "shooter")
        
        for index in 1...shooterAtlas.textureNames.count {
            let imgName = String(format: "shooter%01d", index)
            shooterAnimation += [shooterAtlas.textureNamed(imgName)]
        }
        
        let dropBalls = SKAction.sequence([SKAction.runBlock({
            self.createBallNode()
        }),
            SKAction.waitForDuration(2.0)
            ])
        self.runAction(SKAction.repeatAction(dropBalls, count: enemyCount))
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let shooterNode = self.childNodeWithName("shooterNode")
        
        if(shooterNode != nil) {
            let animation = SKAction.animateWithTextures(shooterAnimation, timePerFrame: 0.05)
            
            let shootBullet = SKAction.runBlock({
                let bulletNode = self.createBulletNode()
            self.addChild(bulletNode)
                bulletNode.physicsBody?.applyImpulse(CGVectorMake(10, 0))
            })
            let sequence = SKAction.sequence([animation, shootBullet])
            shooterNode?.runAction(sequence)
            
            shooterNode?.runAction(animation)
            
        }
    }
    
    func createBulletNode() ->SKSpriteNode {
        
        let shooterNode = self.childNodeWithName("shooterNode")
        let shooterPosition = shooterNode?.position
        let shooterWidth = shooterNode?.frame.size.width
        
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        bullet.position = CGPointMake(shooterPosition!.x + shooterWidth!/2, shooterPosition!.y + 15)
        bullet.name = "bulletNode"
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        return bullet
    }
    
    
    func createBallNode(){
        let ball = SKSpriteNode(imageNamed: "Starball.png")
        ball.position = CGPointMake(randomNumber(self.size.width), self.size.height)
        ball.name = "ballNode"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(ball)
        
    }
    
    func randomNumber(maximum: CGFloat) -> CGFloat{
        let maxInt = UInt32(maximum)
        let result = arc4random_uniform(maxInt)
        return CGFloat(result)
    }
    
}
