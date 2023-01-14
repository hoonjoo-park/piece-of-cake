//
//  BannerImage.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/13.
//

import UIKit

class BannerImage: UIImageView {
    let defaultBannerImage = UIImage(named: "defaultImage")
    let overlay = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(overlay)
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        
        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlay.topAnchor.constraint(equalTo: topAnchor),
            overlay.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    
    func downloadImage(url: String?) {
        Task {
            image = await WebService.shared.downloadImage(imageUrl: url ?? "") ?? defaultBannerImage
        }
    }
    
}
