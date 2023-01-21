//
//  ViewController.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class ArticleListTableVC: LoadingVC {
    
    private var articleListVM: ArticleListViewModel!
    private var articleVM: ArticleViewModel!
    private let gradient = CAGradientLayer()

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
    
    
    private func configureGradient() {
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        view.layer.addSublayer(gradient)
    }
    
    
    private func fetchArticleList() {
        showLoadingView()
        
        Task {
            do {
                isFetching = true
                let articles = try await WebService.shared.fetchArticleList(page: page)
                
                if articleListVM == nil {
                    articleListVM = ArticleListViewModel(articles)
                } else {
                    Observable(articles).subscribe { [weak self] newArticles in
                        guard let self = self else { return }
                        
                        self.articleListVM.articles.value += newArticles
                    }
                }
                
                if articles.count >= 20 { hasNext = true }
                else { hasNext = false }
                
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
            catch { throw ErrorMessages.InvalidData }
            
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
        
        articleVM = self.articleListVM.cellForRowAt(indexPath.row)
        
        articleVM.article.subscribe {
            cell.thumbnail.downloadImage(url: $0.urlToImage ?? "")
            cell.title.text = $0.title
            cell.author.text = $0.author ?? "John Doe"
            cell.publishedAt.text = $0.publishedAt != nil ? String($0.publishedAt!.prefix(10)) : "N/A"
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC =  ArticleVC()
        let article = self.articleListVM.articles.value[indexPath.row]
        
        destinationVC.articleVM = ArticleViewModel(article)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrolledY = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.contentSize.height
        let containerHeight = scrollView.frame.size.height
        
        if scrolledY + containerHeight + 120 >= scrollViewHeight {
            guard hasNext, !isFetching else { return }

            page += 1
            self.fetchArticleList()
        }
    }
}

