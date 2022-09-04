//
//  UIButtonExtension.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-03.
//

import UIKit

extension UIButton {

    var isTruncated: Bool {
        HomeControllerVariables.titleButtonWidth < intrinsicContentSize.width
    }
}
