//
//  ArticleViewModel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import Foundation
import UIKit

struct ArticleListViewModel {
    let articles: [Article]
}


extension ArticleListViewModel {
    var numberOfSections: Int { return 1 }
    
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    
    func cellForRowAt(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
    
    
    func updateCell(cell: ArticleListTableViewCell, article: Article) {
        cell.thumbnail.downloadImage(url: article.urlToImage ?? "")
        cell.title.text = article.title
        cell.author.text = article.author ?? "John Doe"
        cell.publishedAt.text = article.publishedAt != nil ? String(article.publishedAt!.prefix(10)) : "N/A"
    }
}
