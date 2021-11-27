//
//  Internship.swift
//  JS_Corp
//
//  Created by Maxim Bekmetov on 16.01.2021.
//

import Foundation


struct Internship: Codable, Hashable {
    var id: Int = 0
    var title: String = ""
    var content: String = ""
    var category: String = ""
    var internshipType: [String] = []
    var projectName: String = ""
    var illustrationUrl: String = ""
    var occupation: [String] = []
    var timing: String = ""
    var education: String = ""
    var technologies: String = ""
    var logoUrl: String = ""
    

}
