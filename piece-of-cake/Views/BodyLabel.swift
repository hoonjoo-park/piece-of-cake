//
//  BodyLabel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class BodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat, textAlign: NSTextAlignment, color: UIColor?) {
        self.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textAlignment = textAlign
        self.textColor = color ?? UIColor.white
        
        configure()
    }
    
    
    private func configure() {
        minimumScaleFactor = 0.7
        translatesAutoresizingMaskIntoConstraints = false
    }
}
