//
//  ArticleViewModel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import Foundation

struct ArticleListViewModel {
    let articles: [Article]
}

struct ArticleViewModel {
    private let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}


