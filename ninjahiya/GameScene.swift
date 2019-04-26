//
//  GameScene.swift
//  ninjahiya
//
//  Created by HANNAH EVANS on 4/8/19.
//  Copyright © 2019 CLC.Evans. All rights reserved.
//


 import SpriteKit
 import GameplayKit
 
struct PhysicsCategory {
    static let none:UInt32 = 0
    static let all:UInt32 = UInt32.max
    static let ninja:UInt32 = 1
    static let projectile: UInt32 = 2
    static let player: UInt32 = 4
}
 
 class GameScene: SKScene, SKPhysicsContactDelegate {
 
 
 
 var player = SKSpriteNode(imageNamed: "ninja")
 
 
 
 override func didMove(to view: SKView) {
 
 
 physicsWorld.contactDelegate = self
 backgroundColor = UIColor.white
 
 
 
 let backgroundMusic = SKAudioNode(fileNamed: "gameMusic.mp3")
 
 backgroundMusic.autoplayLooped = true
 
 addChild(backgroundMusic)
 
 physicsWorld.gravity = CGVector.zero // sets zero gravity of zero to whole screen
 
 
 
 createplayer()
 
 //for var a in 0...9{
 
 //reateninja()
 
// }
 
 //createFire()
    run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createninja),SKAction.wait(forDuration: 1.0)])))
 
 }
 
 
 
 func randomPoint() -> CGPoint {
 
 var xPos = Int.random(in: 0...Int(self.size.width))
 
 var yPos = Int.random(in: 0...Int(self.size.height))
 
 
 
 return CGPoint(x: xPos, y: yPos)
 
 }
 
 
 
 func createplayer()   {
 
 //var player = SKSpriteNode(imageNamed: "ninja")
 
 //player.position = randomPoint()
    player.position = CGPoint(x: 50, y: 200)
 
 player.scale(to: CGSize(width: 100, height: 100))
 player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
 player.physicsBody?.mass = 100
    player.physicsBody?.pinned = true
 
 
 
 //player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width, height: player.size.height))
 
 player.physicsBody?.affectedByGravity = false
 player.physicsBody?.isDynamic = true
    player.physicsBody?.categoryBitMask = PhysicsCategory.player
    player.physicsBody?.contactTestBitMask = PhysicsCategory.ninja
 
 
 addChild(player)
 
 //player.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 0))
 
   
    
 //createninja()
 
 }
 
 
 
 func createninja() {
 
 var ninja = SKSpriteNode(imageNamed: "enemy")
 
    //ninja.position = randomPoint()fire.position = CGPoint(x: self.size.width, y: 300)
    ninja.position = CGPoint(x: self.size.width, y: 300)
    ninja.scale(to: CGSize(width: 100, height: 100))
 
 ninja.physicsBody = SKPhysicsBody(rectangleOf: ninja.size)
 
 
 
    ninja.physicsBody?.mass = 1
    ninja.physicsBody?.categoryBitMask = PhysicsCategory.ninja
   ninja.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
 
 addChild(ninja)
    let actionMove = SKAction.move(to:CGPoint(x: 0, y: 300), duration: TimeInterval(CGFloat.random(in: 2.0...4.0)))
 
    let actionMoveDone = SKAction.removeFromParent()
    ninja.run(SKAction.sequence([actionMove,actionMoveDone]))
 }
 
 
 
 
 
 
 
 
 
 override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
 
 //step one
 
 guard let touch = touches.first else {
 
 return
 
 } // getting the location of the last touch
 
 let touchloction = touch.location(in: self)
 
 
 
 //step two set the loaction of the proectile
 
 let projectile = SKSpriteNode(imageNamed: "star")
 
 projectile.position = player.position
 
 projectile.physicsBody = SKPhysicsBody(rectangleOf: projectile.size)
 projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
    projectile.physicsBody?.contactTestBitMask = PhysicsCategory.ninja
   // projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
    
    
    
    
    //giving the projectrile a category of 1 bitmask
  //  projectile.physicsBody?.contactTestBitMask = 2 //being notified of who I colide w
    
 addChild(projectile)
 
 
 
 
 
 
 
 //Step 3 determin where to fire the projectile
 
 let offset  = touchloction - projectile.position
 
 
 
 
 
 let direction = offset.normalized()
 
 let shootAmount = direction*1000
 
 let realDest = shootAmount + projectile.position
 
 
 
 //step 4 create the action
 
 let actionMove = SKAction.move(to: realDest, duration: TimeInterval(2.0))
 
 
 
 let actionDone = SKAction.removeFromParent()
 
 
 
 projectile.run(SKAction.sequence( [actionMove, actionDone] ))
 
 
 
 }
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact")
    
 let one = contact.bodyA.node as? SKSpriteNode
let two = contact.bodyB.node as? SKSpriteNode
    one?.removeFromParent()
    two?.removeFromParent()
    }

}
