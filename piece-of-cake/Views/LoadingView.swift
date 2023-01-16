//
//  ActivityIndicatorView.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/17.
//

import UIKit

class LoadingView: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black.withAlphaComponent(0)
        
        addSubview(activityIndicator)
        
        UIView.animate(withDuration: 0.4) { self.alpha = 0.8 }
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 200),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 200),
        ])
        
        activityIndicator.startAnimating()
    }
    
}
