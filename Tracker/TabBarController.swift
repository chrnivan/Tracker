//
//  TabBarControleer.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 22.12.2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [createTrackerViewController(), createStatisticViewController()]
    }
    
    func createTrackerViewController() -> UINavigationController {
        let trackerViewController = TrackerViewController()
        
        trackerViewController.tabBarItem = UITabBarItem(title: "Трекеры", image: UIImage(named: "TrackerItem"), tag: 0)
        trackerViewController.view.backgroundColor = UIColor.white
        trackerViewController.title = "Трекеры"
        
        
        return UINavigationController(rootViewController: trackerViewController)
    }

    func createStatisticViewController() -> UINavigationController {
        let statisticViewController = StatisticViewController()
        
        statisticViewController.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(named: "StatisticItem"), tag: 1)
        statisticViewController.view.backgroundColor = UIColor.white
        statisticViewController.title = "Статистика"
        
        return UINavigationController(rootViewController: statisticViewController)
    }
}



