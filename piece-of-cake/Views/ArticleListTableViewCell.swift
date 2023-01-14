//
//  ArticleListTableViewCell.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/06.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {
    static let reuseID = "ArticleListCell"
    
    var article: Article!
    
    let thumbnail = Thumbnail(frame: .zero)
    let title = TitleLabel(fontSize: 18, textAlign: .left, color: .white)
    let publishedAt = BodyLabel(fontSize: 14, textAlign: .left, color: .lightGray)
    let author = BodyLabel(fontSize: 14, textAlign: .left, color: .lightGray)
    
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
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = UIImage(named: "defaultImage")
    }
    
    
    private func configureUI() {
        backgroundColor = .black
        [thumbnail, title, publishedAt, author].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            thumbnail.widthAnchor.constraint(equalToConstant: 80),
            thumbnail.heightAnchor.constraint(equalToConstant: 80),
            thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            title.topAnchor.constraint(equalTo: thumbnail.topAnchor),
            
            author.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            author.trailingAnchor.constraint(equalTo: title.centerXAnchor),
            author.bottomAnchor.constraint(equalTo: thumbnail.bottomAnchor),
            
            publishedAt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            publishedAt.bottomAnchor.constraint(equalTo: thumbnail.bottomAnchor),
        ])
    }

}
