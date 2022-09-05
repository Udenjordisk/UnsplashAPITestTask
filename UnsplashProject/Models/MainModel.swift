//
//  MainModel.swift
//  BelashovTestTask
//
//  Created by Кирилл on 04.09.2022.
//


import Foundation
import UIKit

struct MainModel: Codable {
    var id: String
    var created_at: String? //CAMAL CASE NEED
    var urls: Urls
    var user: User
    var location: Location?
    var downloads: Int?
    var likes: Int
    

}

struct Urls: Codable {
    var full: String
    var small: String
}

struct User: Codable {
    var name: String
}

struct Location: Codable {
    var name: String?
}






