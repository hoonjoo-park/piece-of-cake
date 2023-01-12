//
//  BannerImage.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/13.
//

import UIKit

class BannerImage: UIImageView {
    let defaultBannerImage = UIImage(named: "defaultImage")

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func downloadImage(url: String?) {
        Task {
            image = await WebService.shared.downloadImage(imageUrl: url ?? "") ?? defaultBannerImage
        }
    }
    
}
