//
//  UIButtonExtension.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-03.
//

import UIKit

extension UILabel {

    var isTruncated: Bool {
        HomeControllerVariables.titleLabelWidth < intrinsicContentSize.width
    }
}
