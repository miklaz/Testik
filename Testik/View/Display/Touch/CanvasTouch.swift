//
//  Canvas.swift
//  Testik
//
//  Created by Михаил Зайцев on 27.06.2021.
//

import UIKit

final class CanvasTouch: UIView {
    
    override func draw(_ rect: CGRect) {
        // custom dawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        /*
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 100, y: 100)
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        */
        
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(60)
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    
    
    
    //var line = [CGPoint]()
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {
            return}
        
        //print (point)
        
        guard var lastLine = lines.popLast() else {
            return
        }
        lastLine.append(point)
        lines.append(lastLine)
        
        //var lastLine = lines.last
        //lastLine?.append(point)
        //line.append(point)
        
        setNeedsDisplay()
    }
    
}
