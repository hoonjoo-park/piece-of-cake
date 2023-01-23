//
//  SkeletonView.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/23.
//

import UIKit

class SkeletonView: UIView {
    let bar = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.gradientLightGrey
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(bar)
    }
    
    
    private func configureBar() {
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor.gradientDarkGrey
        bar.alpha = 0.35
        
        NSLayoutConstraint.activate([
            bar.topAnchor.constraint(equalTo: topAnchor),
            bar.bottomAnchor.constraint(equalTo: bottomAnchor),
            bar.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat], animations: {
            self.bar.transform = CGAffineTransform(translationX: 500, y: 0)
        }, completion: nil)
    }
}
