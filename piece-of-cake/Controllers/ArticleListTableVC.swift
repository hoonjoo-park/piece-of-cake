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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Piece of Cakes"
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
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
        let article = articleVM.article
        
        cell.thumbnail.downloadImage(url: article.urlToImage ?? "")
        cell.title.text = article.title ?? ""
        cell.author.text = article.author ?? "John Doe"
        cell.publishedAt.text = article.publishedAt ?? "Unknown"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC =  ArticleVC()
        let article = self.articleListVM.articles[indexPath.row]
        
        destinationVC.articleVM = ArticleViewModel(article: article)
        destinationVC.bannerImage.downloadImage(url: article.urlToImage ?? "")
        destinationVC.titleLabel.text = article.title ?? ""
        destinationVC.authorLabel.text = article.author ?? "John Doe"
        destinationVC.publishedAtLabel.text = article.publishedAt ?? "Unknown"
        destinationVC.contentLabel.text = article.content ?? "Content Not Available..."
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

