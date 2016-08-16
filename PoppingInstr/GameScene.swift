//
//  GameScene.swift
//  PoppingInstr
//
//  Created by Sujan Kamran on 7/9/16.
//  Copyright (c) 2016 Meena Kamran. All rights reserved.
//

import SpriteKit
var scoreNumber = 0

class GameScene: SKScene {
    

    let scoreLabel = SKLabelNode(fontNamed: "ChalkDuster")
    let playCorrectSoundEffect = SKAction.playSoundFileNamed("Correct.wav", waitForCompletion: false)
    let playGameOverSoundEffect = SKAction.playSoundFileNamed("GameOverSound.wav", waitForCompletion: false)
    
    let gameArea: CGRect
    
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)/2
        gameArea = CGRect(x: gameAreaMargin, y:0, width: playableWidth, height: size.height)
        
        
        
        super.init(size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF )
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        scoreNumber = 0
        
        let background = SKSpriteNode(imageNamed: "DiscsBackground")
        background.size = self.size
        background.position = CGPoint(x:self.size.width/2, y:self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let disc = SKSpriteNode(imageNamed: "Head1")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = "discObject"
        
        self.addChild(disc)
        
        scoreLabel.fontSize = 250
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height*0.85)
        self.addChild(scoreLabel)
        
    }
    
    
    func spawnNewDisc(){
        
        //randomly creates a disc
        
        var randomImageNumber = arc4random_uniform(4)
        randomImageNumber += 1
        
        let disc = SKSpriteNode(imageNamed: "Head\(randomImageNumber)")
        disc.zPosition = 2
        disc.name = "discObject"
        
        let randomX = random(min: CGRectGetMinX(gameArea) + disc.size.width/2,
                             max: CGRectGetMaxX(gameArea) - disc.size.width/2)
        
        let randomY = random(min: CGRectGetMinY(gameArea) + disc.size.height/2,
                             max: CGRectGetMaxY(gameArea) - disc.size.height/2)
        
        disc.position = CGPoint(x: randomX, y: randomY)
        
        self.addChild(disc)
        
        disc.runAction(SKAction.sequence([
            SKAction.scaleTo(0, duration: 3),
            playGameOverSoundEffect,
            SKAction.runBlock(runGameOver)
            ]))
        
        
    }
    
    func runGameOver() {
        //implement what happens when Game is over
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        let sceneTransition = SKTransition.fadeWithDuration(0.2)
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches{
            
            let positionOfTouch = touch.locationInNode(self) //marks where the user touched the screen
            let tappedNode = nodeAtPoint(positionOfTouch) //stores the object that was touched
            let nameOfTappedNode = tappedNode.name
 
            
            if nameOfTappedNode == "discObject" {
                
                tappedNode.name = ""
                
                let explosionPath = NSBundle.mainBundle().pathForResource("HeadExplosion", ofType:"sks")
                let explosionNode = NSKeyedUnarchiver.unarchiveObjectWithFile(explosionPath!) as! SKEmitterNode
                explosionNode.position = positionOfTouch
                explosionNode.zPosition = 2
                
                tappedNode.removeAllActions()
                
                tappedNode.runAction(SKAction.sequence([
                    SKAction.fadeOutWithDuration(0.1),
                    
                    SKAction.removeFromParent()
                    ]))
                
                self.addChild(explosionNode)
                self.runAction(playCorrectSoundEffect)
                
                spawnNewDisc()
                
                scoreNumber += 1
                scoreLabel.text = "\(scoreNumber)"
                
                if scoreNumber == 10 || scoreNumber == 50 || scoreNumber == 125 || scoreNumber == 200 || scoreNumber == 300 || scoreNumber == 500 {
                    spawnNewDisc()
                }
                
            }
            
        }
    }
    
}
