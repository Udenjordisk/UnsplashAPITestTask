//
//  FavoriteCell.swift
//  BelashovTestTask
//
//  Created by Кирилл on 04.09.2022.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let identifier = "favoriteCell"
    var model: MainModel?
    private lazy var ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(ImageView)
        contentView.addSubview(authorLabel)
    }
    
    private func setupLayout() {
        ImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15).isActive = true
        ImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        ImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/10).isActive = true
        
        authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: ImageView.rightAnchor, constant: 10).isActive = true
        authorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 5/10).isActive = true
    }
    
    
    func configur(model: MainModel){
            self.model = model
    
            guard let url = URL(string: model.urls.small) else {return}
    
        ImageView.sd_setImage(with: url, placeholderImage: nil, options: [.progressiveLoad,.continueInBackground], completed: nil)
        authorLabel.text = model.user.name
    }
    
//    func configure(with model: AdditionalPhotoInfo) {
//        let imageURL = model.urls["thumb"]
//        //thumbImageView.sd_setImage(with: URL(string: imageURL ?? ""), completed: nil)
//        authorLabel.text = "Author: \(model.user.username) - \(model.user.name)"
//    }
//}
//    static let identifier = "favoriteCell"
//
//    var photoImageView = UIImageView()
//
//    var label = UILabel()
//    var image = UIImage()
//    var model: MainModel?
//
//
//    func configur(model: MainModel){
//        self.model = model
//
//        guard let url = URL(string: model.urls.small) else {return}
//
//        photoImageView.sd_setImage(with: url, placeholderImage: nil, options: [.progressiveLoad,.continueInBackground], completed: nil)
//        label.text = model.user.name
//
        
     
    }

