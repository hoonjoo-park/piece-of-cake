//
//  ArticleListSkeletonCell.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/22.
//

import UIKit

class ArticleListSkeletonCell: UITableViewCell {
    static let reuseID = "ArticleListSkeletonCell"
    
    let thumbnail = SkeletonView()
    let title = SkeletonView()
    let author = SkeletonView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

// MARK: Shimmer 방식 Skeleton Animation
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let subViews = [thumbnail, title, author]
//        let animationGroup = makeSkeletonAnimationGroup()
//
//        subViews.forEach {
//            let gradient = SkeletonLayer()
//
//            gradient.frame = $0.bounds
//            gradient.cornerRadius = 10
//            gradient.add(animationGroup, forKey: "backgroundColor")
//
//            $0.layer.addSublayer(gradient)
//        }
//
//    }

    
    private func configureUI() {
        backgroundColor = .black
        [thumbnail, title, author].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            thumbnail.widthAnchor.constraint(equalToConstant: 80),
            thumbnail.heightAnchor.constraint(equalToConstant: 80),
            thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            title.topAnchor.constraint(equalTo: thumbnail.topAnchor),
            title.heightAnchor.constraint(equalToConstant: 25),
            
            author.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            author.trailingAnchor.constraint(equalTo: title.centerXAnchor),
            author.bottomAnchor.constraint(equalTo: thumbnail.bottomAnchor),
            author.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

}

extension ArticleListSkeletonCell: SkeletonLoadable {}
