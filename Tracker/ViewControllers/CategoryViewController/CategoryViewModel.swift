//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 28.01.2024.
//

import UIKit

final class CategoryViewModel: NSObject {
    //MARK: - Public Properties
    var onChange: (() -> Void)?
    //MARK: - Private Properties
    private let categoryStore = TrackerCategoryStore.shared
    private(set) var categories: [TrackerCategory] = [] {
        didSet {
            onChange?()
        }
    }
    // MARK: - Initializers
    override init() {
        super.init()
        categoryStore.delegate = self
        trackerCategoryDidUpdate()
    }
}
//MARK: - TrackerCategoryDelegate
extension CategoryViewModel: TrackerCategoryDelegate {
    func trackerCategoryDidUpdate() {
        categories = categoryStore.categories
    }
}
