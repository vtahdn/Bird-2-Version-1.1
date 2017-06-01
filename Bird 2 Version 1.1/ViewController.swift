//
//  ViewController.swift
//  Bird 1 Version 1.1
//
//  Created by Viet Anh Doan on 6/1/17.
//  Copyright © 2017 Viet. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var bird: UIImageView!
    var audio = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        birdAnimation()
        fly()
        sounds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func birdAnimation() -> Void {
        bird.animationImages = [UIImage(named:"bird0.png")!,UIImage(named:"bird1.png")!,UIImage(named:"bird2.png")!,UIImage(named:"bird3.png")!,UIImage(named:"bird4.png")!,UIImage(named:"bird5.png")!]
        bird.animationDuration = 4
        bird.animationRepeatCount = 0
        bird.startAnimating()
    }
    
    func sounds() -> Void {
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "A+ – Chào Mào Mái Hót", ofType: ".mp3")!))
        audio.numberOfLoops = -1
        audio.prepareToPlay()
        audio.play()
    }
    
    func birdMove(cx:CGFloat,cy:CGFloat,sx:CGFloat,sy:CGFloat,angle:CGFloat,fn:@escaping ()->()) -> Void {
        UIView.animate(withDuration: 3, animations: {
            self.bird.center = CGPoint(x: cx, y: cy)
        }) { (finished) in
            self.bird.transform = .identity
            self.bird.transform = CGAffineTransform(scaleX: sx, y: sy).concatenating(CGAffineTransform(rotationAngle: angle))
            fn()
        }
    }
    
    func fly() -> Void {
        let width = self.view.bounds.size.width
        let height = self.view.bounds.size.height
        birdMove(cx: width-50, cy: height-34, sx: -1, sy: 1, angle: 0) { 
            self.birdMove(cx: 50, cy: height-34, sx: 1, sy: 1, angle: -45, fn: { 
                self.birdMove(cx: width-50, cy: 34, sx: -1, sy: 1, angle: 0, fn: { 
                    self.birdMove(cx: 0, cy: 0, sx: 1, sy: 1, angle: 0, fn: self.fly)
                })
            })
        }
    }
}

