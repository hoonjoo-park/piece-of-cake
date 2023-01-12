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
    let titleLabel = TitleLabel(fontSize: 16, textAlign: .left, color: .white)
    let authorLabel = BodyLabel(fontSize: 12, textAlign: .justified, color: .systemGray)
    let publishedAtLabel = BodyLabel(fontSize: 12, textAlign: .justified, color: .systemGray)
    let contentLabel = BodyLabel(fontSize: 14, textAlign: .justified, color: .white)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = [bannerImage, titleLabel, authorLabel, publishedAtLabel, contentLabel]
        
        views.forEach { view.addSubview($0) }
        view.backgroundColor = .black
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
