//
//  ArticleListSkeletonTableView.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/23.
//

import UIKit

class ArticleListSkeletonTableView: UITableView {
    
    var numberOfRows = 5
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(ArticleListSkeletonCell.self, forCellReuseIdentifier: ArticleListSkeletonCell.reuseID)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ArticleListSkeletonTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: ArticleListSkeletonCell.reuseID, for: indexPath) as! ArticleListSkeletonCell
        return cell
    }
}
