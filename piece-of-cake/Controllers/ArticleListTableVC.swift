//
//  ViewController.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class ArticleListTableVC: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    private var articleVM: ArticleViewModel!
    var selectedIndexPath: IndexPath!
    
    var page = 1
    var hasNext = true
    var isFetching = false
    var isInitialRender = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        configureTableVC()
        fetchArticleList()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Piece of Cake"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func fetchArticleList() {
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
                
                hasNext = articles.count >= 20
                
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
            catch { throw ErrorMessages.InvalidData }
            
            isFetching = false
            isInitialRender = false
        }
    }
    
    
    private func configureTableVC() {
        view.backgroundColor = .black
        
        tableView.frame = view.bounds
        tableView.rowHeight = 140
        tableView.backgroundColor = .black
        
        tableView.register(ArticleListSkeletonCell.self, forCellReuseIdentifier: ArticleListSkeletonCell.reuseID)
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: ArticleListTableViewCell.reuseID)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 1 : self.articleListVM.numberOfSections
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isInitialRender ? 5 : articleListVM.numberOfRowsInSection(section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isInitialRender {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListSkeletonCell.reuseID, for: indexPath) as? ArticleListSkeletonCell else {
                fatalError("ArticleList Cell Not Found...")
            }
            
            return cell
            
        } else {
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
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC =  ArticleVC()
        let article = self.articleListVM.articles.value[indexPath.row]
        
        selectedIndexPath = indexPath
        articleVM = ArticleViewModel(article)
        destinationVC.articleVM = articleVM
        
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


extension ArticleListTableVC: ZoomingViewController, UINavigationControllerDelegate {
    func zoomingImageView(for transition: ZoomTransition) -> UIImageView? {
        if let indexPath = selectedIndexPath {
            let cell = tableView?.cellForRow(at: indexPath) as! ArticleListTableViewCell
            return cell.thumbnail
        }
        
        return nil
    }
    
    func zoomingBackgroundView(for transition: ZoomTransition) -> UIView? {
        return tableView
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            let transition = ZoomTransition()
            transition.operation = .push
            
            return transition
        } else {
            let transition = ZoomTransition()
            transition.operation = .pop
            
            return transition
        }
    }
}
