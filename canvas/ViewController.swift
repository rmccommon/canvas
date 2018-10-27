//
//  ViewController.swift
//  canvas
//
//  Created by Sierra Klix on 10/26/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var trayView: UIView!
    
    var originalPos : CGPoint!

    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var trayisDown = false
    
    var newFace: UIImageView!
    var newFaceCenter : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let transl = sender.translation(in: view)
        if(sender.state == .began){
            let imageV = sender.view as! UIImageView
            newFace = UIImageView(image: imageV.image)
            
            view.addSubview(newFace)
            newFace.isUserInteractionEnabled = true
            let panGestureRec = UIPanGestureRecognizer(target: self, action: #selector(didMoveface(sender:)))
            newFace.addGestureRecognizer(panGestureRec)
            newFace.center = imageV.center
            newFace.center.y += trayView.frame.origin.y
            newFaceCenter = newFace.center
            
        }else if(sender.state == .changed){
            newFace.center = CGPoint(x:newFaceCenter.x + transl.x, y:newFaceCenter.y + transl.y)
        }else if(sender.state == .ended){}
        
        
    }
    @objc func didMoveface(sender: UIPanGestureRecognizer){
        
        let transl = sender.translation(in: view)
        
        if(sender.state == .began){
            newFace = sender.view as! UIImageView
            newFaceCenter = newFace.center
        }else if(sender.state == .changed){
            newFace.center = CGPoint(x: newFaceCenter.x + transl.x, y: newFaceCenter.y + transl.y)
        }else if(sender.state == .ended){
            
        }
    }
    
    

    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        let trayDownOffset: CGFloat! = 190
        let velocity = sender.velocity(in: view)
        trayDown = CGPoint(x: trayView.center.x , y: trayView.center.y + trayDownOffset)
        trayUp = CGPoint(x: trayView.center.x , y: trayView.center.y - trayDownOffset)
        
    
        
        if(sender.state == .began){
            originalPos = trayView.center
        }else if(sender.state == .changed){
            trayView.center = CGPoint(x: originalPos.x ,y: originalPos.y)
        }else if(sender.state == .ended){
            if(velocity.y < 0 && trayisDown == true){
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
                trayisDown = false
            }else if(velocity.y > 0 && trayisDown == false){
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
                trayisDown = true
            }
        }
    }
    
}

