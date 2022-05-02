//
//  Session.swift
//  lessOne
//
//  Created by Евгений Ефименко on 26.04.2022.
//

import Foundation

struct Session {
    private init() {}
    static var instance = Session()

    var token = "" // Хранение токена
    var userId = "" // Хранение индентификатора


}
