//
//  DetailsViewController.swift
//  BelashovTestTask
//
//  Created by Кирилл on 04.09.2022.
//
import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    var model: MainModel
    var date: String?
    var newDate = ""
    var isLiked = false
    
   var authorLabel = UILabel()
   var locationLabel = UILabel()
   var image = UIImageView()
    
    var likeButton = UIButton()
    
    init(with model: MainModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        date = model.created_at ?? ""
        
        guard let url = URL(string: model.urls.full) else {return}
        image.sd_setImage(with: url, placeholderImage: nil, options: [.progressiveLoad,.continueInBackground,.forceTransition], completed: nil)
        
        getDate()
        authorLabel.text = "Author: \(model.user.name ?? "noname")\nLocation: \(model.location?.name ?? "unknown")\nDate: \(newDate)\nDownloads: \(model.downloads ?? 0)"
        
        
        view.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: view.topAnchor,constant: 100).isActive = true
        image.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
        view.addSubview(authorLabel)
        authorLabel.numberOfLines = 4
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 25).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: image.leftAnchor, constant: 25).isActive = true
        
        view.addSubview(likeButton)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.rightAnchor.constraint(equalTo: image.rightAnchor, constant: -25).isActive = true
        likeButton.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 25).isActive = true
        likeButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        view.backgroundColor = .white
        
        if FavoriteListTempStorage.shared.likeChecker.contains(model.id){
            isLiked = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        
        
    }
    
    
    
    @objc func pressed() {
        print(authorLabel.text)
        if isLiked == true{
            isLiked = false
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            modelRemoveFromSingleTon(model: model)
            StorageManager.shared.saveData()
            alert(title: "Removed", message: "photo removed from list", actionTitle: "Ok")
            
        }else{
            isLiked = true
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            modelAddToSingleTon(model: model)
            StorageManager.shared.saveData()
            alert(title: "Added", message: "Photo added to favorite photo list", actionTitle: "Ok")
            
        }
        
        
        
        }
    
    
//
//    func likeButtonPressed(_ sender: UIButton) {
//        if isLiked == true{
//            isLiked = false
//            sender.setImage(UIImage(systemName: "heart"), for: .normal)
//            modelRemoveFromSingleTon(model: model)
//            StorageManager.shared.saveData()
//            alert(title: "Removed", message: "photo removed from list", actionTitle: "Ok")
//
//        }else{
//            isLiked = true
//            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//            modelAddToSingleTon(model: model)
//            StorageManager.shared.saveData()
//            alert(title: "Added", message: "Photo added to favorite photo list", actionTitle: "Ok")
//
//        }
//
//    }
//
    
    

    private func getDate(){
        if  date != "" {
            let dateString = date!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ-00:00"
            let date = formatter.date(from: dateString)
            formatter.dateFormat = "dd-MM-yyyy"
            newDate = formatter.string(from: date!)
        }
    }
    private func modelAddToSingleTon(model: MainModel){
        FavoriteListTempStorage.shared.favoriteModels.append(model)
        FavoriteListTempStorage.shared.likeChecker.insert(model.id)
        FavoriteListTempStorage.shared.likeChekerDict[model.id] = FavoriteListTempStorage.shared.favoriteModels.count - 1
    }
    private func modelRemoveFromSingleTon(model: MainModel){
        FavoriteListTempStorage.shared.favoriteModels.remove(at: FavoriteListTempStorage.shared.likeChekerDict[model.id]!)
        FavoriteListTempStorage.shared.likeChecker.remove(model.id)
        FavoriteListTempStorage.shared.likeChekerDict.removeValue(forKey: model.id)
    }
    
    private func alert(title: String, message: String, actionTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
