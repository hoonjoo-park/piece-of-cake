//
//  WebService.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class WebService {
    static let shared = WebService()
    
    private let baseUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2be128801b9046e59e727d741e86f924"
    
    let decoder = JSONDecoder()
    let cache = NSCache<NSString, UIImage>()
    
    func fetchArticleList(page: Int) async throws -> ArticleList {
        guard let url = URL(string: baseUrl + "&page=\(page)") else { throw ErrorMessages.InvalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ErrorMessages.InvalidResponse
        }
        
        do {
            let articleList = try decoder.decode(ArticleList.self, from: data)
            return articleList
        } catch {
            throw ErrorMessages.InvalidData
        }
    }
    
    func downloadImage(imageUrl: String) async -> UIImage? {
        let cacheKey = NSString(string: imageUrl)
        // 이미 캐싱된 이미지가 있으면 return
        if let cachedImage = cache.object(forKey: cacheKey) { return cachedImage }
        
        guard let url = URL(string: imageUrl) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            
            return image
        } catch {
            return nil
        }
    }
}
