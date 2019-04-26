//
//  GameViewController.swift
//  ninjahiya
//
//  Created by HANNAH EVANS on 4/8/19.
//  Copyright © 2019 CLC.Evans. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating a game scene with a size the same as the view controller
        let scene = GameScene(size: view.bounds.size)
        
        //converting the view controller to a sprite kit view
       let skView = self.view as! SKView
            // Load the SKScene from 'GameScene.sks'
        
                scene.scaleMode = .resizeFill
                
                // Present the scene
                skView.presentScene(scene)
        
            
         skView.ignoresSiblingOrder = true
            
            skView.showsFPS = true
            skView.showsNodeCount = true
    


        
    }


    override var prefersStatusBarHidden: Bool {
        return true
    }
}
