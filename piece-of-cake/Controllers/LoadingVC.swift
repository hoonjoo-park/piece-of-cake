//
//  LoadingVC.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/15.
//

import UIKit

class LoadingVC: UITableViewController {
    var loadingContainer: UIView!
    
    func showLoadingView() {
        loadingContainer = UIView(frame: view.bounds)
        view.addSubview(loadingContainer)
        loadingContainer.backgroundColor = .black.withAlphaComponent(0)
        
        UIView.animate(withDuration: 0.4) { self.loadingContainer.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        loadingContainer.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.loadingContainer.removeFromSuperview()
            self.loadingContainer = nil
        }
    }
}
