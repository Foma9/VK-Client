//
//  Session.swift
//  lessOne
//
//  Created by Евгений Ефименко on 26.04.2022.
//

import Foundation

struct Session {
    private init() {}
    static let instance = Session()

    var token = "" // Хранение токена
    var userId = 0 // Хранение индентификатора


}
