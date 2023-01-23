//
//  SkeletonLayer.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/22.
//

import UIKit

class SkeletonLayer: CAGradientLayer {
    
    override init() {
        super.init()
        startPoint = CGPoint(x: 0, y: 0.5)
        endPoint = CGPoint(x: 1, y: 0.5)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
