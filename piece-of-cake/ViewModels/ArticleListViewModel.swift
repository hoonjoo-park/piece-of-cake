//
//  ArticleViewModel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import Foundation
import UIKit

struct ArticleListViewModel {
    let articles: Observable<[Article]>
}


extension ArticleListViewModel {
    var numberOfSections: Int { return 1 }
    
    
    init(_ articles: [Article]) {
        self.articles = Observable(articles)
    }
    
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.value.count
    }
    
    
    func cellForRowAt(_ index: Int) -> ArticleViewModel {
        let article = self.articles.value[index]
        return ArticleViewModel(article)
    }
}
