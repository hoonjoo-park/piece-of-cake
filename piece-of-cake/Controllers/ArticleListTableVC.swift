//
//  ViewController.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class ArticleListTableVC: LoadingVC {
    
    private var articleListVM: ArticleListViewModel!
    var articles: [Article] = []
    var page = 1
    var hasNext = true
    var isFetching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticleList()
        configureTableVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Piece of Cake"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchArticleList() {
        showLoadingView()
        
        Task {
            do {
                isFetching = true
                let articleList = try await WebService.shared.fetchArticleList(page: page)
                articles.append(contentsOf: articleList.articles)
                self.articleListVM = ArticleListViewModel(articles: articles)
                
                if articleList.articles.count >= 20 { hasNext = true }
                else { hasNext = false }
                
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
            catch {
                if let error = error as? ErrorMessages { print(error) }
            }
            
            isFetching = false
            hideLoadingView()
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
        cell.title.text = article.title
        cell.author.text = article.author ?? "John Doe"
        cell.publishedAt.text = article.publishedAt != nil ? String(article.publishedAt!.prefix(10)) : "N/A"

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC =  ArticleVC()
        let article = self.articleListVM.articles[indexPath.row]
        
        destinationVC.articleVM = ArticleViewModel(article: article)
        destinationVC.bannerImage.downloadImage(url: article.urlToImage ?? "")
        destinationVC.titleLabel.text = article.title ?? "N/A"
        destinationVC.authorLabel.text = article.author ?? "John Doe"
        destinationVC.contentLabel.text = article.content != nil ? String(article.content!.prefix(199)) : "Content Not Available..."
        destinationVC.publishedAtLabel.text = article.publishedAt != nil ? String(article.publishedAt!.prefix(10)) : "N/A"
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrolledY = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.contentSize.height
        let containerHeight = scrollView.frame.size.height
        
        if scrolledY + containerHeight + 100 >= scrollViewHeight {
            guard hasNext, !isFetching else { return }

            page += 1
            self.fetchArticleList()
        }
    }
}

