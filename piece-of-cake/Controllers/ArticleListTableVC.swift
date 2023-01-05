//
//  ViewController.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class ArticleListTableVC: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        configureTableVC()
    }
    
    private func configureTableVC() {
        Task {
            do {
                let articleList = try await WebService.shared.fetchArticleList()
                
                self.articleListVM = ArticleListViewModel(articles: articleList.articles)
                
            } catch {
                if let error = error as? ErrorMessages {
                    print(error)
                }
            }
            
        }
    }
}

