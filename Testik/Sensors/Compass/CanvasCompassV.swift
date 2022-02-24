//
//  CanvasV.swift
//  Testik
//
//  Created by Михаил Зайцев on 27.06.2021.
//

import UIKit

final class CanvasCompassV: UIView {
    
    // MARK: - Const, Var & Outlets
    var halfFrameWidth: CGFloat = 0
    var fullFrameWidth: CGFloat = 0
    let needleBottomWith: CGFloat = 10
    var needleLength: CGFloat = 0
    var centerView: CGPoint?
    var changeDegree = 90
    
    // MARK: - Methods
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        halfFrameWidth = bounds.width / 2
        fullFrameWidth = bounds.width
        needleLength = halfFrameWidth * 0.5
        centerView = CGPoint(x: halfFrameWidth, y: halfFrameWidth)
        
        createNeedle()
        createCompassMarks()
    }
    
    func createNeedle() {
        //red triangle
        let upperNeedle = UIBezierPath()
        upperNeedle.move(to: CGPoint(x: halfFrameWidth - needleBottomWith, y: halfFrameWidth))
        upperNeedle.addLine(to: CGPoint(x: halfFrameWidth, y: needleLength))
        upperNeedle.addLine(to: CGPoint(x: halfFrameWidth + needleBottomWith, y: halfFrameWidth))
        upperNeedle.close()
        UIColor.red.setFill()
        upperNeedle.fill()
        
        //blue triangle
        let bottomNeedle = UIBezierPath()
        bottomNeedle.move(to: CGPoint(x: halfFrameWidth - needleBottomWith, y: halfFrameWidth))
        bottomNeedle.addLine(to: CGPoint(x: halfFrameWidth, y: fullFrameWidth - needleLength))
        bottomNeedle.addLine(to: CGPoint(x: halfFrameWidth + needleBottomWith, y: halfFrameWidth))
        bottomNeedle.close()
        UIColor.blue.setFill()
        bottomNeedle.fill()
        
        //small circle in center
        let centerPin = UIBezierPath(arcCenter: centerView!, radius: 5.0, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        UIColor.darkGray.setFill()
        centerPin.fill()
        
        let innerRing = UIBezierPath(arcCenter: centerView!, radius: halfFrameWidth *  0.9, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        UIColor.black.setStroke()
        innerRing.lineWidth = 2
        innerRing.stroke()
        
        let outerRing = UIBezierPath(arcCenter: centerView!, radius: halfFrameWidth *  0.98, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        UIColor.black.setStroke()
        outerRing.lineWidth = 1
        outerRing.stroke()
        
    }
    
    //lines of inner circle
    func createCompassMarks() {
        for degree in stride(from: 0, to: 360, by: 2) {
            
            let markLength = degree % 10
            var innerArcDistance: CGFloat = 0
            if markLength == 0 {
                innerArcDistance = 0.8
                
                if changeDegree == 360 {
                    changeDegree = 0
                }
                addDegree(degree: changeDegree, location: arcLocationPoint(degree: CGFloat(degree), distance: 0.95))
                changeDegree += 10
                
            } else {
                innerArcDistance = 0.85
            }
            
            let outerArcPoint = arcLocationPoint(degree: CGFloat(degree), distance: 0.9)
            let innerArcPoint = arcLocationPoint(degree: CGFloat(degree), distance: innerArcDistance)
            
            let markLine = UIBezierPath()
            markLine.move(to: outerArcPoint)
            markLine.addLine(to: innerArcPoint)
            UIColor.black.setStroke()
            markLine.lineWidth = 1
            markLine.stroke()
        }
        
        var degree = 0
        for result in ["E", "SE", "S", "SW", "W", "NW", "N", "NE"] {
            addDirection(direction: result, degree: degree, location: arcLocationPoint(degree: CGFloat(degree), distance: 0.75))
            degree += 45
        }
        
    }
    
    func arcLocationPoint(degree: CGFloat, distance: CGFloat) -> CGPoint {
        var location: CGPoint?
        let radion: CGFloat = degree * .pi / 180
        let arcPath = UIBezierPath(arcCenter: centerView!, radius: halfFrameWidth *  distance, startAngle: 0, endAngle: radion, clockwise: true)
        location = arcPath.currentPoint
        return location!
    }
    
    func addDegree(degree: Int, location: CGPoint) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: location.x - 10 , y: location.y - 5, width: 20, height: 10)
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.fontSize = CGFloat(11)
        textLayer.font = "ArialMT" as CFString
        textLayer.string = String(degree)
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(textLayer)
        textLayer.transform = CATransform3DMakeRotation(CGFloat(degree) * .pi / 180, 0.0, 0.0, 1.0)
    }
    
    func addDirection(direction: String, degree: Int, location: CGPoint) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: location.x - 15 , y: location.y - 10, width: 30, height: 20)
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.fontSize = CGFloat(18)
        textLayer.font = "ArialMT" as CFString
        textLayer.string = String(direction)
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(textLayer)
        textLayer.transform = CATransform3DMakeRotation(CGFloat(degree + 90) * .pi / 180, 0.0, 0.0, 1.0)
    }

}
