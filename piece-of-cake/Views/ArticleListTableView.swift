//
//  ArticleListTableView.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/10.
//

import UIKit

class ArticleListTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .green
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview?.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview?.trailingAnchor),
        ])
    }
    
}
