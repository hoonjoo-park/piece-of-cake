//
//  ArticleViewModel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/13.
//

import Foundation

struct ArticleViewModel {
    let article: Article
}


extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
    
    func updateContent(viewController: ArticleVC) {
        viewController.articleVM = ArticleViewModel(article: article)
        viewController.bannerImage.downloadImage(url: article.urlToImage ?? "")
        viewController.titleLabel.text = article.title ?? "N/A"
        viewController.authorLabel.text = article.author ?? "John Doe"
        viewController.contentLabel.text = article.content != nil ? String(article.content!.prefix(199)) : "Content Not Available..."
        viewController.publishedAtLabel.text = article.publishedAt != nil ? String(article.publishedAt!.prefix(10)) : "N/A"
    }
}
