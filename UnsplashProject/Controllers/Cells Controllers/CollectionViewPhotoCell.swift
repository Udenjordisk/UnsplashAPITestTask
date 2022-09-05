//
//  CollectionViewPhotoCell.swift
//  BelashovTestTask
//
//  Created by Кирилл on 04.09.2022.
//

import UIKit

class CollectionViewPhotoCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewPhotoCell"
    
  //  @IBOutlet weak var photoImageView: UIImageView!
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    
    var image: UIImage?
    var model: MainModel?
    
    
    func configur(model: MainModel){
        self.model = model
        
        guard let url = URL(string: model.urls.small) else {return}
       
        photoImageView.sd_setImage(with: url, placeholderImage: nil, options: [.progressiveLoad,.continueInBackground], completed: nil)
   
        
     
    }
}
