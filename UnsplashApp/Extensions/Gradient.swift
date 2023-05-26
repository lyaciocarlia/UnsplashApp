//
//  Gradient.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 26.05.2023.
//

import Foundation
import UIKit
import CoreGraphics
import CoreImage

struct GradientPoint {
    var location: CGFloat
    var color: UIColor
}

extension UIImage {
    convenience init?(size: CGSize, gradientPoints: [GradientPoint]) {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }      
        guard let gradient = CGGradient(colorSpace: CGColorSpaceCreateDeviceRGB(), colorComponents: gradientPoints.compactMap { $0.color.cgColor.components }.flatMap { $0 }, locations: gradientPoints.map { $0.location }, count: gradientPoints.count) else {
            return nil
        }
        
        context.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions())
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: image)
        defer { UIGraphicsEndImageContext() }
    }
}


extension UIImageView {
    func gradated(gradientPoints: [GradientPoint]) {
        let gradientMaskLayer       = CAGradientLayer()
        gradientMaskLayer.frame     = CGRect(x: 0, y: 0, width: 300, height: 599)
        gradientMaskLayer.colors    = gradientPoints.map { $0.color.cgColor }
        gradientMaskLayer.locations = gradientPoints.map { $0.location as NSNumber }
        self.layer.insertSublayer(gradientMaskLayer, at: 0)
    }
}
