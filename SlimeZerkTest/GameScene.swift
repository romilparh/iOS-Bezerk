//
//  GameScene.swift
//  SlimeZerkTest
//
//  Created by Parrot on 2019-02-25.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioToolbox

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
    
    // MARK: Label variables
    var livesLabel:SKLabelNode = SKLabelNode(text:"")
    var wall:SKSpriteNode = SKSpriteNode()
    var wallTwo:SKSpriteNode = SKSpriteNode()
    var exit:SKSpriteNode = SKSpriteNode()
    
    var enemy: SKSpriteNode = SKSpriteNode()
    
    var musicItem:SKSpriteNode = SKSpriteNode()
    
    let testSound: Sound = Sound(name: "BackgroundMusic/ActionFighter", type: "wav")
    
    // MARK: Scoring and Lives variables
    
    
    // MARK: Game state variables
    
    var shapeNode = SKShapeNode()
    
    // MARK: Default GameScene functions
    // -------------------------------------
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
    
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.lastUpdateTime = 0
        
        // get sprites from Scene Editor
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
        
        
        
        // get labels from Scene Editor
        self.livesLabel = self.childNode(withName: "livesLabel") as! SKLabelNode
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        self.player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = 1
        player.physicsBody!.contactTestBitMask = 16
        player.physicsBody!.contactTestBitMask = 4
        player.physicsBody!.contactTestBitMask = 2
        
        exit.physicsBody = SKPhysicsBody(rectangleOf: exit.frame.size)
        self.exit.physicsBody?.affectedByGravity = false
        exit.physicsBody!.categoryBitMask = 4
        
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.frame.size)
        self.wall.physicsBody?.affectedByGravity = false
        wall.physicsBody!.categoryBitMask = 16
        
        wallTwo.physicsBody = SKPhysicsBody(rectangleOf: wallTwo.frame.size)
        self.wallTwo.physicsBody?.affectedByGravity = false
        wallTwo.physicsBody!.categoryBitMask = 16
        
        player.physicsBody?.isDynamic=true
        
        player.physicsBody?.collisionBitMask = 4+1
        player.physicsBody?.collisionBitMask = 2+1
        self.spawnEnemy()
        
    }
    
    func spawnEnemy() {
        self.enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        self.enemy.size = CGSize(width: 100, height: 100)
        self.enemy.physicsBody?.isDynamic = true
        // put sand at a random (x,y) position
        let x = self.size.width/2
        let y = self.size.height - 100
        self.enemy.position.x = x
        self.enemy.position.y = y
        
        // add physics
        self.enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width / 2)
        self.enemy.physicsBody?.velocity = CGVector(dx: -100, dy: -100)
        self.enemy.physicsBody?.affectedByGravity = false
        
        // make sand bounce
        self.enemy.physicsBody!.restitution = 1.0
        self.enemy.physicsBody!.categoryBitMask = 2;
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if (touch == nil) {
            return
        }
        
        let mousePosition = touch?.location(in: self)
        
        let spriteTouched = self.atPoint(mousePosition!)
        
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
            player.run(movePlayer)
        } else if(spriteTouched.name == "leftButton"){
            if(player.position.x<=0){
            } else{
                let movePlayer = SKAction.moveTo(x: player.position.x-30, duration: 0)
                player.run(movePlayer)
            }
        } else if(spriteTouched.name == "bButton"){
            let movePlayer = SKAction.moveTo(x: player.position.x+90, duration: 1)
            player.run(movePlayer)
        } else if(spriteTouched.name == "musicButton"){
            testSound.play()
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
        }
        
    }
    
    // MARK: Custom GameScene Functions
    // Your custom functions can go here
    // -------------------------------------
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        print("Collision: \(nodeA?.name) hit \(nodeB?.name)")
        if(nodeA?.name == "exit" && nodeB?.name == "player"){
            print("RESET")
            self.restartGame()
        } else if(nodeA?.name == "player" && nodeB?.name == "enemy"){
            self.restartGame()
        }
        
    }
    
    func restartGame() {
        // load Level2.sks
        let scene = GameScene(fileNamed:"BerzerkLevel2")
        print(scene)
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    class Sound {
        
        var soundEffect: SystemSoundID = 0
        init(name: String, type: String) {
            let path  = Bundle.main.path(forResource: name, ofType: type)!
            let pathURL = NSURL(fileURLWithPath: path)
            AudioServicesCreateSystemSoundID(pathURL as CFURL, &soundEffect)
        }
        
        func play() {
            AudioServicesPlaySystemSound(soundEffect)
        }
    }
    
    
}
