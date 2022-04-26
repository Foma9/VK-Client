//
//  Constant.swift
//  lessOne
//
//  Created by Евгений Ефименко on 26.02.2022.
//

import Foundation
import UIKit

let allGroupsRowPressed = NSNotification.Name.init(rawValue: "allGroupsRowPressed")

struct Constants {
    static let leftDistanceToView: CGFloat = 20
    static let rightDistanceToView: CGFloat = 20
    static let topDistanceToView: CGFloat = 20
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - Constants.galleryMinimumLineSpacing) / 2
}

