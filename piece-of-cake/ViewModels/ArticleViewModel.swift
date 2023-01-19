//
//  ArticleViewModel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/13.
//

import Foundation

struct ArticleViewModel {
    let article: Observable<Article>
}


extension ArticleViewModel {
    init(_ article: Article) {
        self.article = Observable(article)
    }
}
