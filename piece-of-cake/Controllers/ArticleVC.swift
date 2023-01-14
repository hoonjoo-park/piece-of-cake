//
//  ArticleVC.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/12.
//

import UIKit

class ArticleVC: UIViewController {
    
    var articleVM: ArticleViewModel!
    
    let bannerImage = BannerImage(frame: .zero)
    let titleLabel = BodyLabel(fontSize: 28, textAlign: .left, color: .white)
    let authorLabel = BodyLabel(fontSize: 14, textAlign: .justified, color: .lightGray)
    let publishedAtLabel = BodyLabel(fontSize: 14, textAlign: .justified, color: .lightGray)
    let contentLabel = BodyLabel(fontSize: 18, textAlign: .justified, color: .white)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureUI() {
        let views = [bannerImage, titleLabel, authorLabel, publishedAtLabel, contentLabel]
        let padding: CGFloat = 17
        let screenSize: CGFloat = UIScreen.main.bounds.height
        authorLabel.numberOfLines = 1
        
        views.forEach { view.addSubview($0) }
        view.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImage.heightAnchor.constraint(equalToConstant: screenSize / 2),
            
            authorLabel.bottomAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: -padding),
            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),

            
            publishedAtLabel.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            publishedAtLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 15),
            
            titleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            contentLabel.topAnchor.constraint(equalTo: bannerImage.bottomAnchor, constant: 30),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }
}
