//
//  Thumbnail.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/11.
//

import UIKit

class Thumbnail: UIImageView {
    let defaultThumbnail = UIImage(named: "default-image")
    let cache = WebService.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    
    func downloadImage(url: String?) {
        Task {
            image = await WebService.shared.downloadImage(imageUrl: url ?? "") ?? defaultThumbnail
        }
    }
    
}
