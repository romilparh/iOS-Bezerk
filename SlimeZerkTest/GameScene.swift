//
//  GameScene.swift
//  SlimeZerkTest
//
//  Created by Parrot on 2019-02-25.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Variables for tracking time
    private var lastUpdateTime : TimeInterval = 0
    
    // MARK: Sprite variables
    var player:SKSpriteNode = SKSpriteNode()
    var upButton:SKSpriteNode = SKSpriteNode()
    var downButton:SKSpriteNode = SKSpriteNode()
    var rightButton:SKSpriteNode = SKSpriteNode()
    var leftButton:SKSpriteNode = SKSpriteNode()
    var bButton: SKSpriteNode = SKSpriteNode()
    var musicButton: SKSpriteNode = SKSpriteNode()
    var wall:SKSpriteNode = SKSpriteNode()
    var wallTwo:SKSpriteNode = SKSpriteNode()
    var exit:SKSpriteNode = SKSpriteNode()
    var enemy: SKSpriteNode = SKSpriteNode()
    var reset: SKSpriteNode = SKSpriteNode()
    
    // MARK: Label variables
    var livesLabel:SKLabelNode = SKLabelNode(text:"")
    var scoreLabel:SKLabelNode = SKLabelNode(text:"")
    
    // MARK: Background Sound Variable
    var musicItem:SKSpriteNode = SKSpriteNode()
    let backgroundSound = SKAudioNode(fileNamed: "BackgroundMusic/ActionFighter")
    var playMusic: Bool = true
    
    // MARK: Scoring and Lives variables
    
    
    // MARK: Game state variables
    
    // MARK: Default GameScene functions
    // -------------------------------------
    
    override func didMove(to view: SKView) {
        
        // Collision Detection Shit
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // Last Update Time Initialization
        self.lastUpdateTime = 0
        
        // Get Sprites from Scene Editor
        self.player = self.childNode(withName: "player") as! SKSpriteNode
        self.upButton = self.childNode(withName: "upButton") as! SKSpriteNode
        self.downButton = self.childNode(withName: "downButton") as! SKSpriteNode
        self.rightButton = self.childNode(withName: "rightButton") as! SKSpriteNode
        self.leftButton = self.childNode(withName: "leftButton") as! SKSpriteNode
        self.bButton = self.childNode(withName: "bButton") as! SKSpriteNode
        self.exit = self.childNode(withName: "exit") as! SKSpriteNode
        self.wall = self.childNode(withName: "wall") as! SKSpriteNode
        self.wallTwo = self.childNode(withName: "wallTwo") as! SKSpriteNode
        self.musicItem = self.childNode(withName: "musicButton") as! SKSpriteNode
        self.reset = self.childNode(withName: "reset") as! SKSpriteNode
        
        // Add Background Sound Child Node
        self.addChild(backgroundSound)
        
        
        // get labels from Scene Editor
        self.livesLabel = self.childNode(withName: "livesLabel") as! SKLabelNode
        self.livesLabel.text?.append(String(playerObject.returnLives()+1))
        
        self.scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        self.scoreLabel.text?.append(String(playerObject.returnScore()))
        
        // Set Physics Bodies and properties
        
        // Player Physics Body
        self.player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        self.player.physicsBody?.affectedByGravity = false
        self.player.physicsBody?.isDynamic=true
        self.player.xScale = 0.8
        
        // Exit Physics Body
        self.exit.physicsBody = SKPhysicsBody(rectangleOf: exit.frame.size)
        self.exit.physicsBody?.affectedByGravity = false
        self.exit.physicsBody?.isDynamic = true
        
        // Wall Physics Body
       // wall.physicsBody = SKPhysicsBody(rectangleOf: wall.frame.size)
        //self.wall.physicsBody?.affectedByGravity = false
        //self.wall.physicsBody?.isDynamic = true
        //wallTwo.physicsBody = SKPhysicsBody(rectangleOf: wallTwo.frame.size)
        //self.wallTwo.physicsBody?.affectedByGravity = false
        //self.wallTwo.physicsBody?.isDynamic = true
        
        
        self.player.physicsBody?.categoryBitMask = 1
        self.player.physicsBody!.contactTestBitMask = 3
        //player.physicsBody!.contactTestBitMask = 4
        //player.physicsBody!.contactTestBitMask = 2
        //exit.physicsBody!.categoryBitMask = 4
        self.player.physicsBody?.collisionBitMask = 3
        //wall.physicsBody!.categoryBitMask = 4
        //wallTwo.physicsBody!.categoryBitMask = 4
        
        // Setup Enemy
        self.spawnEnemy()
    }
    
    func spawnEnemy() {
        self.enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        self.enemy.size = CGSize(width: 100, height: 100)
        self.enemy.physicsBody?.isDynamic = true
        
        // Put Enemy at random Location
        let x = self.size.width/2
        let y = self.size.height - 100
        self.enemy.position.x = x
        self.enemy.position.y = y
        
        // Add Physics to Enemy
        self.enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width / 2)
    
        self.enemy.physicsBody?.affectedByGravity = false
        
        // Make Enemy Bounce
        self.enemy.physicsBody!.restitution = 1.0
        self.enemy.physicsBody!.categoryBitMask = 2
        self.enemy.physicsBody!.contactTestBitMask = 3
        self.enemy.physicsBody?.collisionBitMask = 3
        
        let moveAction: SKAction = SKAction.moveBy(x: self.player.position.x-self.enemy.position.x, y: self.player.position.y-self.enemy.position.y, duration: 5)
        self.enemy.run(moveAction)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if (touch == nil) {
            return
        }
        
        let mousePosition = touch?.location(in: self)
        
        let spriteTouched = self.atPoint(mousePosition!)
        
        if(playerObject.gameOver == false){
            if (spriteTouched.name == "upButton") {
                let movePlayer = SKAction.moveTo(y: player.position.y+30, duration: 0)
                player.run(movePlayer)
            } else if(spriteTouched.name == "downButton"){
                if(player.position.y<=0){
                } else{
                    let movePlayer = SKAction.moveTo(y: player.position.y-30, duration: 0)
                    player.run(movePlayer)
                }
            }else if (spriteTouched.name == "rightButton") {
                let movePlayer = SKAction.moveTo(x: player.position.x+30, duration: 0)
                self.player.xScale = 0.8
                self.player.run(movePlayer)
            } else if(spriteTouched.name == "leftButton"){
                if(player.position.x<=0){
                } else{
                    let movePlayer = SKAction.moveTo(x: player.position.x-30, duration: 0)
                    self.player.xScale = -0.8
                    self.player.run(movePlayer)
                }
            } else if(spriteTouched.name == "bButton"){
                let movePlayer = SKAction.moveTo(x: player.position.x+90, duration: 1)
                self.player.run(movePlayer)
            } else if(spriteTouched.name == "musicButton"){
                //testSound.play()
                if(self.playMusic == true){
                    self.backgroundSound.run(SKAction.stop())
                    self.playMusic = false
                } else if(self.playMusic == false){
                    self.backgroundSound.run(SKAction.play())
                    self.playMusic = true
                }
                
            } else if(spriteTouched.name == "reset"){
                self.restartGame()
            }
        } else{
            if (spriteTouched.name == "upButton") {
            } else if(spriteTouched.name == "downButton"){
            }else if (spriteTouched.name == "rightButton") {
            } else if(spriteTouched.name == "leftButton"){
            } else if(spriteTouched.name == "bButton"){
            } else if(spriteTouched.name == "musicButton"){
                //testSound.play()
                if(self.playMusic == true){
                    self.backgroundSound.run(SKAction.stop())
                    self.playMusic = false
                } else if(self.playMusic == false){
                    self.backgroundSound.run(SKAction.play())
                    self.playMusic = true
                }
                
            } else if(spriteTouched.name == "reset"){
                self.restartGame()
            }
        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // HINT: This code prints "Hello world" every 5 seconds
        if (dt > 1) {
            self.lastUpdateTime = currentTime
            
            self.updateEnemyPosition()
        }
        
    }
    
    // This Function Checks for any Collisions
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        print("Collision: \(nodeA?.name) hit \(nodeB?.name)")
        if(nodeA?.name == "exit" && nodeB?.name == "player"){
            if(sceneSelector.scene){
                sceneSelector.changeBool()
                self.startLevelOne()
            } else{
                sceneSelector.changeBool()
                self.startLevelTwo()
            }
        } else if(nodeA?.name == "player" && nodeB?.name == "enemy"){
            if(playerObject.returnLives() == 0){
                let labelNode = SKLabelNode()
                labelNode.fontSize = 80
                labelNode.position.y = self.frame.maxY/2
                labelNode.position.x = self.frame.maxX/2
                labelNode.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                labelNode.text = "GAME OVER"
                addChild(labelNode)
                playerObject.gameOver = true
                //self.restartGame()
            } else {
                playerObject.reduceLives()
                if(sceneSelector.scene){
                    self.startLevelTwo()
                } else{
                    self.startLevelOne()
                }
            }
            
        } else if(nodeA?.name == "wall" && nodeB?.name == "enemy"){
            self.updateEnemyPosition()
        } else if(nodeA?.name == "wallTwo" && nodeB?.name == "enemy"){
            self.updateEnemyPosition()
        } else{
            self.updateEnemyPosition()
        }
        
    }
    
    // Function to Restart Game
    func restartGame() {
        playerObject.resetLives()
        playerObject.gameOver = false
        let scene = GameScene(fileNamed:"BerzerkLevel1")
        print(scene)
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
        
    }
    
    // Function to Go to Level 2
    func startLevelTwo() {
        // load Level2.sks
        let scene = GameScene(fileNamed:"BerzerkLevel2")
        print(scene)
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    // Function to go to Level 1
    func startLevelOne() {
        // load Level1.sks
        let scene = GameScene(fileNamed:"BerzerkLevel1")
        print(scene)
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    func updateEnemyPosition(){
        let moveAction: SKAction = SKAction.moveBy(x: self.player.position.x-self.enemy.position.x, y: self.player.position.y-self.enemy.position.y, duration: 10)
        self.enemy.run(moveAction)
    }
}
