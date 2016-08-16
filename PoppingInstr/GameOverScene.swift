//
//  GameOverScene.swift
//  PoppingInstr
//
//  Created by Sujan Kamran on 7/9/16.
//  Copyright © 2016 Meena Kamran. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let clickSound = SKAction.playSoundFileNamed("Click.wav", waitForCompletion: false)
    
        override func didMoveToView(view: SKView) {
    
            let background = SKSpriteNode(imageNamed: "DiscsBackground")
            background.size = self.size
            background.zPosition = 0
            background.position = CGPoint(x:self.size.width/2, y:self.size.height/2)
            self.addChild(background)
            
            let gameOverLabel = SKLabelNode(fontNamed: "ChalkDuster")
            gameOverLabel.text = "Game Over"
            gameOverLabel.fontSize = 140
            gameOverLabel.position = CGPoint(x:self.size.width/2, y:self.size.height*0.75)
            gameOverLabel.fontColor = SKColor.whiteColor()
            gameOverLabel.zPosition = 1
            self.addChild(gameOverLabel)
            
            let finalScoreLabel = SKLabelNode(fontNamed: "ChalkDuster")
            finalScoreLabel.text = "Score: \(scoreNumber)"
            finalScoreLabel.fontSize = 70
            finalScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.6)
            finalScoreLabel.fontColor = SKColor.whiteColor()
            finalScoreLabel.zPosition = 1
            self.addChild(finalScoreLabel)
            
            let defaults = NSUserDefaults()
            var highScoreNumber = defaults.integerForKey("highScoreSaved")
            
            if scoreNumber > highScoreNumber {
                highScoreNumber = scoreNumber
                defaults.setInteger(highScoreNumber, forKey: "highScoreSaved")
            }
            
            let highScoreLabel = SKLabelNode(fontNamed: "ChalkDuster")
            highScoreLabel.text = "High Score: \(highScoreNumber)"
            highScoreLabel.fontSize = 70
            highScoreLabel.fontColor = SKColor.whiteColor()
            highScoreLabel.zPosition = 1
            highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            self.addChild(highScoreLabel)
            
            let restartLabel = SKLabelNode(fontNamed: "ChalkDuster")
            restartLabel.text = "Restart"
            restartLabel.fontSize = 75
            restartLabel.fontColor = SKColor.whiteColor()
            restartLabel.zPosition = 1
            restartLabel.position = CGPoint(x:self.size.width/2, y:self.size.height*0.3)
            restartLabel.name = "restartButton"
            self.addChild(restartLabel)
            
            let exitLabel = SKLabelNode(fontNamed: "ChalkDuster")
            exitLabel.text = "Exit"
            exitLabel.fontSize = 75
            exitLabel.fontColor = SKColor.whiteColor()
            exitLabel.zPosition = 1
            exitLabel.position = CGPoint(x:self.size.width/2, y:self.size.height*0.2)
            exitLabel.name = "exitButton"
            self.addChild(exitLabel)
            
           
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(pointOfTouch)
            let tappedNodeName = tappedNode.name
            if tappedNodeName == "restartButton" {
                
                self.runAction(clickSound)
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fadeWithDuration(0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
                
            }
            
            if tappedNodeName == "exitButton" {
                
                self.runAction(clickSound)
                
                let sceneToMoveTo = MainMenuScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fadeWithDuration(0.2)
                self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
            }
            
        }
    
    }
    
    
}