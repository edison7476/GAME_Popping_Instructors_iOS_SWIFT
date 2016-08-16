//
//  MainMenuScene.swift
//  PoppingInstr
//
//  Created by Sujan Kamran on 7/9/16.
//  Copyright © 2016 Meena Kamran. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene{
    
    let clickSoundEffect = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "DiscsBackground")
        background.size = self.size
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let gameTitleLabel1 = SKLabelNode(fontNamed: "ChalkDuster")
        gameTitleLabel1.text = "Popping Instructors"
        gameTitleLabel1.fontSize = 90
        gameTitleLabel1.fontColor = SKColor.whiteColor()
        gameTitleLabel1.position = CGPoint(x: self.size.width/2, y:self.size.height*0.75)
        gameTitleLabel1.zPosition = 1
        self.addChild(gameTitleLabel1)
        
        let howToPlayLabel = SKLabelNode(fontNamed: "ChalkDuster")
        howToPlayLabel.text = "Pop The Instructors Before They Dissaper"
        howToPlayLabel.fontSize = 40
        howToPlayLabel.fontColor = SKColor.whiteColor()
        howToPlayLabel.position = CGPoint(x:self.size.width/2, y:self.size.height*0.5)
        howToPlayLabel.zPosition = 1
        self.addChild(howToPlayLabel)
        
        let startLabel = SKLabelNode(fontNamed: "ChalkDuster")
        startLabel.text = "Play"
        startLabel.fontSize = 150
        startLabel.fontColor = SKColor.whiteColor()
        startLabel.position = CGPoint(x:self.size.width/2, y:self.size.height*0.35)
        startLabel.zPosition = 1
        startLabel.name = "startButton"
        self.addChild(startLabel)
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOnTouch = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(pointOnTouch)
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "startButton" {
                
                self.runAction(clickSoundEffect)
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fadeWithDuration(0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
        }
    }
    
}

