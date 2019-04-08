//
//  ViewController.swift
//  DrawThisDemo
//
//  Created by Phillip Eismark on 08/03/2019.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var imageView: UIImageView!
    var lastPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began\(touches.first)")
        let touch = touches.first
        if let position = touch?.location(in: imageView) {
            print(position)
            lastPosition = position
            addText(start: position)
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch moved")
        let touch = touches.first
        if let movedToPosition = touch?.location(in: imageView) {
            draw(start: lastPosition, stop: movedToPosition)
            lastPosition = movedToPosition
        }
        
    }
    
    
    
    func draw(start: CGPoint, stop:CGPoint) {
        //1. begin a graphic context
        UIGraphicsBeginImageContext(imageView.frame.size)
        
        imageView.image?.draw(in: imageView.bounds) //draw existing image into this context //context is the paper you draw on
        //when we are done drawing put whatever we draw back on the imageview
        guard let context = UIGraphicsGetCurrentContext() else {
            return
            
        }
        
        context.move(to: start)
        context.addLine(to: stop)
        context.strokePath()//from start to stop set the linex
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext() //put new drawing back on the imageview
        
        //finally end the area when you are done drawing
        UIGraphicsEndImageContext()
    }
    
    func addText(start: CGPoint) {
        
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: imageView.bounds)
        
       
        let attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont.systemFont(ofSize : 50),
            .foregroundColor : UIColor.blue
        ]
        let string = NSAttributedString(string : "hello", attributes : attributes)
        string.draw(at: start)
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

}

