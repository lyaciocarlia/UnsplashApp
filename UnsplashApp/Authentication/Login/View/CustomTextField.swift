//
//  CustomTextField.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 29.05.2023.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    private let underlineColor: UIColor = .label
       private let underlineWidth: CGFloat = 1.0

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - underlineWidth - 1, width: frame.width, height: underlineWidth)
        bottomLine.backgroundColor = underlineColor.cgColor
        layer.addSublayer(bottomLine)
    }
}
