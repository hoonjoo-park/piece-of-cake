//
//  Article.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let author: String?
    let title: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
