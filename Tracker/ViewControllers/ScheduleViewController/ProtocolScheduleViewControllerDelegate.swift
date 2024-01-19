//
//  ProtocolScheduleViewControllerDelegate.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 19.01.2024.
//

import Foundation

protocol ScheduleViewControllerDelegate: AnyObject {
    func didSelectDays(_ days: [Weekday])
}
