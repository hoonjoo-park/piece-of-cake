//
//  BannerImage.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/13.
//

import UIKit

class BannerImage: UIImageView {
    let defaultBannerImage = UIImage(named: "default-image")
    var overlay: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        
        overlay = UIView(frame: self.bounds)
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        addSubview(overlay)
    }
    
    
    func downloadImage(url: String?) {
        Task {
            image = await WebService.shared.downloadImage(imageUrl: url ?? "") ?? defaultBannerImage
            configureUI()
        }
    }
    
}
