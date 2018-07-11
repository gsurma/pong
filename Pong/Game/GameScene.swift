//
//  GameScene.swift
//  Pong
//
//  Created by Grzegorz Surma on 7/7/18.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import SpriteKit

final class GameScene: SKScene {
    
    private let goalLine: CGFloat = 30.0
    private let playerYPosition: CGFloat = 50.0
    
    private var ball = SKSpriteNode()
    private var topPlayer = SKSpriteNode()
    private var bottomPlayer = SKSpriteNode()
    private var topPlayerScoreLabel = SKLabelNode()
    private var bottomPlayerScoreLabel = SKLabelNode()
    
    private var topPlayerScore = 0
    private var bottomPlayerScore = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        topPlayerScoreLabel = childNode(withName: "topPlayerScoreLabel") as! SKLabelNode
        bottomPlayerScoreLabel = childNode(withName: "bottomPlayerScoreLabel") as! SKLabelNode
        ball = childNode(withName: "ball") as! SKSpriteNode
        
        topPlayer = childNode(withName: "topPlayer") as! SKSpriteNode
        topPlayer.position.y = (self.frame.height/2) - playerYPosition
        
        bottomPlayer = childNode(withName: "bottomPlayer") as! SKSpriteNode
        bottomPlayer.position.y = (-self.frame.height/2) + playerYPosition
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        topPlayerScore = 0
        bottomPlayerScore = 0
        updateScores()
        randomStart()
    }
    
    func addPoint(winner: SKSpriteNode){
        if winner == bottomPlayer {
            bottomPlayerScore += 1
        } else if winner == topPlayer {
            topPlayerScore += 1
        }
        updateScores()
        randomStart()
    }
    
    func randomStart() {
        ball.position = CGPoint.zero
        ball.physicsBody?.velocity =  CGVector.zero
        let randomX = Bool.random() ? Int.random(in: -10...5) : Int.random(in: 5...10)
        let randomY = Bool.random() ? 10 : -10
        ball.physicsBody?.applyImpulse(CGVector(dx: randomX, dy: randomY))
    }
    
    private func updateScores() {
        topPlayerScoreLabel.text = "\(topPlayerScore)"
        bottomPlayerScoreLabel.text = "\(bottomPlayerScore)"
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            bottomPlayer.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        topPlayer.run(SKAction.moveTo(x: ball.position.x, duration: 1.0)) // TODO: add more sophisticated AI :)
        
        if ball.position.y <= bottomPlayer.position.y - goalLine {
            addPoint(winner: topPlayer)
        } else if ball.position.y >= topPlayer.position.y + goalLine {
            addPoint(winner: bottomPlayer)
        }
    }
}
