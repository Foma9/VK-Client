//
//  GetApiFromVK.swift
//  lessOne
//
//  Created by Евгений Ефименко on 02.05.2022.
//

import Foundation

class GetApiFromVK {

    enum parametrsApiVK {

        case namesFriends
        case photoFriends
        case groups
        case searchGroups

    }

    func loadData (_parametrs: parametrsApiVK) {

        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)

        var urlComponents = URLComponents(string: "https://api.vk.com/method")
        urlComponents?.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.120")
        ]

        switch _parametrs {
        case .namesFriends:
            urlComponents?.path = "/method/friends.get"
            urlComponents?.queryItems?.append(URLQueryItem(name: "user_id", value: Session.instance.userId))
            urlComponents?.queryItems?.append(URLQueryItem(name: "friends", value: "photo_50"))
        case .photoFriends:
            urlComponents?.path = "/method/photos.getAll"
            urlComponents?.queryItems?.append(URLQueryItem(name: "owner_id", value:Session.instance.userId))
        case .groups:
            urlComponents?.path = "/method/groups.get"
            urlComponents?.queryItems?.append(URLQueryItem(name: "user_id", value: Session.instance.userId))
            urlComponents?.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlComponents?.path = "/method/groups.search"
            urlComponents?.queryItems?.append(URLQueryItem(name: "q", value: "video"))
            urlComponents?.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        }

        guard let url = urlComponents?.url else {
            return
        }

        let task = session.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                return
            }

            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: .fragmentsAllowed
            )

            print("Вывод json из ответа: \(String(describing: json))")
        }

        task.resume()
    }
}
