//
//  GameViewController.swift
//  Pong
//
//  Created by Grzegorz Surma on 7/7/18.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import UIKit
import SpriteKit

final class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
