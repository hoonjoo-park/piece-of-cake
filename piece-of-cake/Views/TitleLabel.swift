//
//  TitleLabel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(fontSize: CGFloat, textAlign: NSTextAlignment, color: UIColor?) {
        self.init(frame: .zero)
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textAlignment = textAlign
        self.textColor = color ?? UIColor.black
        
        configure()
    }
    
    
    func configure() {
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byTruncatingTail
        numberOfLines = 2
        minimumScaleFactor = 0.9
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
