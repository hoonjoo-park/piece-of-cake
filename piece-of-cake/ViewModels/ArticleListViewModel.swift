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


extension ArticleListViewModel {
    var numberOfSections: Int { return 1 }
    
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    
    func cellForRowAt(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}


