//
//  ProtocolCreateTypeTrackerDelegate.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 19.01.2024.
//

import Foundation

protocol CreateTypeTrackerDelegate: AnyObject {
    func plusTracker(_ tracker: Tracker, _ category: String, from: CreateTypeTrackerViewController)
}
