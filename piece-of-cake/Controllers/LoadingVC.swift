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
        loadingContainer = LoadingView(frame: view.bounds)
        view.addSubview(loadingContainer)
    }
    
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.loadingContainer.removeFromSuperview()
            self.loadingContainer = nil
        }
    }
}
