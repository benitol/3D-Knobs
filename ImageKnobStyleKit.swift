//
//  ImageKnobStyleKit.swift
//  AudioKit
//
//  Created by Matthew Fecher on 10/19/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//



import UIKit

public class ImageKnobStyleKit : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawImageKnob(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 150, height: 150), resizing: ResizingBehavior = .aspectFit, newImage: UIImage = UIImage(named: "image.png")! ) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 150, height: 150), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 150, y: resizedFrame.height / 150)

        //// Image Declarations
     
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 150, height: 150))
        context.saveGState()
        rectanglePath.addClip()
        context.scaleBy(x: 1, y: -1)
        context.draw(newImage.cgImage!, in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height), byTiling: true)
        context.restoreGState()
        
        context.restoreGState()
    }

    @objc(ImageKnobStyleKitResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
