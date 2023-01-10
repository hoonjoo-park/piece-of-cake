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
        
        configureViewModel()
        configureTableVC()
    }
    
    private func configureViewModel() {
        Task {
            do {
                let articleList = try await WebService.shared.fetchArticleList()
                self.articleListVM = ArticleListViewModel(articles: articleList.articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                if let error = error as? ErrorMessages { print(error) }
            }
            
        }
    }
    
    
    private func configureTableVC() {
        title = "Piece of Cake"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .black
        
        tableView.frame = view.bounds
        tableView.rowHeight = 140
        tableView.backgroundColor = .black
        
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: ArticleListTableViewCell.reuseID)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM.numberOfRowsInSection(section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.reuseID, for: indexPath) as? ArticleListTableViewCell else {
            fatalError("ArticleList Cell Not Found...")
        }
        let articleVM = self.articleListVM.cellForRowAt(indexPath.row)
        
        cell.thumbnail.downloadImage(url: articleVM.article.urlToImage ?? "")
        cell.title.text = articleVM.article.title ?? ""
        cell.author.text = articleVM.article.author ?? "익명"
        cell.publishedAt.text = articleVM.article.publishedAt ?? "Unknown"

        return cell
    }
}

