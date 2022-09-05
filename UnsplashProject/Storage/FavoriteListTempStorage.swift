//
//  FavoriteListTempStorage.swift
//  BelashovTestTask
//
//  Created by Кирилл on 04.09.2022.
//


import Foundation

class FavoriteListTempStorage: Codable{
    static let shared = FavoriteListTempStorage()

    var favoriteModels: [MainModel] = []
    var likeChecker = Set<String>()
    var likeChekerDict = [String:Int]()
    
    private init(){}
}
