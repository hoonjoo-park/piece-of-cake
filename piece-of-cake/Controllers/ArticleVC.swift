//
//  ArticleVC.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/12.
//

import UIKit
import SafariServices

class ArticleVC: UIViewController {
    
    var articleVM: ArticleViewModel!
    
    let bannerImage = BannerImage(frame: .zero)
    let titleLabel = BodyLabel(fontSize: 28, textAlign: .left, color: .white)
    let authorLabel = BodyLabel(fontSize: 14, textAlign: .justified, color: .lightGray)
    let publishedAtLabel = BodyLabel(fontSize: 14, textAlign: .justified, color: .lightGray)
    let contentLabel = BodyLabel(fontSize: 18, textAlign: .justified, color: .white)
    let urlButton = LinkButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleVM.article.subscribe { [weak self] currentArticle in
            guard let self = self else { return }
            self.configureData(article: currentArticle)
        }
        
        configureUI()
        configureURLButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    
    func configureData(article: Article) {
        self.bannerImage.downloadImage(url: article.urlToImage ?? "")
        self.titleLabel.text = article.title ?? "N/A"
        self.authorLabel.text = article.author ?? "John Doe"
        self.contentLabel.text = article.content != nil ? String(article.content!.prefix(199)) : "Content Not Available..."
        self.publishedAtLabel.text = article.publishedAt != nil ? String(article.publishedAt!.prefix(10)) : "N/A"
    }
    
    
    private func configureUI() {
        let views = [bannerImage, titleLabel, authorLabel, publishedAtLabel, contentLabel, urlButton]
        let padding: CGFloat = 17
        let screenSize: CGFloat = UIScreen.main.bounds.height
        
        views.forEach { view.addSubview($0) }
        view.backgroundColor = .black
        authorLabel.numberOfLines = 1
        
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
            
            urlButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            urlButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            urlButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            urlButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
    private func configureURLButton() {
        urlButton.addTarget(self, action: #selector(onTappedURLButton), for: .touchUpInside)
    }
    
    
    @objc func onTappedURLButton() {
        guard let urlString = articleVM.article.value.url else { return }
        
        if let url =  URL(string: urlString) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Oops!", message: "Sorry... This Link Is Unavailable.", preferredStyle: .alert)
            present(alert, animated: true)
        }
    }
}


extension ArticleVC: ZoomingViewController {
    func zoomingImageView(for transition: ZoomTransition) -> UIImageView? {
        return bannerImage
    }
    
    
    func zoomingBackgroundView(for transition: ZoomTransition) -> UIView? {
        return self.view
    }
}
