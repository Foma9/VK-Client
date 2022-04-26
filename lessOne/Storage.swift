//
//  Storage.swift
//  lessOne
//
//  Created by Евгений Ефименко on 26.02.2022.
//

import UIKit

class Storage: NSObject {
    
    static let shared = Storage()
    private override init() {
        super.init()
    }

    private var myGroups = [Group]()

    func getMyGroups() -> [Group] {
        return myGroups
    }

    func addGroup(group: Group) {
        myGroups.append(group)
    }


}
