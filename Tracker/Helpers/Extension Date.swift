//
//  Extension Date.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 19.01.2024.
//

import Foundation

extension Date {
    var onlyDate: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day], from: self)
    }
}
