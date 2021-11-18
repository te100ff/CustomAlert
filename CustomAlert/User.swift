//
//  User.swift
//  JS_Corp
//
//  Created by Aleksandr Fetisov on 22.01.2021.
//

import Foundation

struct User {
    
    var name: String = ""
    var speciality: String = ""
    var city: String = ""
    var school: String = ""
    var status: String = ""
    var contactDetails: String = ""
    var skills: [String] = []
    var notifications: [Bool] = [false, false, false]
    
    enum Stage: String {
        case guest = "Гость",
             student = "Студент",
             trainee = "Стажер",
             beginning = "Начинающий",
             average = "Средний",
             expert = "Эксперт"
    }
    var favoriteCategories: [Category]  = []
}
