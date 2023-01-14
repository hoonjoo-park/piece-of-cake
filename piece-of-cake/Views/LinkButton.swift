//
//  LinkButton.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/14.
//

import UIKit

class LinkButton: UIButton {
    let buttonText = TitleLabel(fontSize: 16, textAlign: .center, color: .white)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        buttonText.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = UIColor(red: 28/255, green: 109/255, blue: 258/255, alpha: 1)
        
        buttonText.text = "URL Link"
        addSubview(buttonText)
        
        NSLayoutConstraint.activate([
            buttonText.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonText.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
    }
    
    
    
}
