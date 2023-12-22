//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 22.12.2023.
//

import UIKit

final class TrackerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White")
        addNewHabit()
        setupView()
        setupConstraints()
    }
    
    private func addNewHabit() {
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "AddNewHabit"),
            style: .plain,
            target: self, 
            action: #selector(self.didTapButton))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        leftBarButtonItem.tintColor = .black
    }
    
    @ objc private func didTapButton() {
        print("tap")
    }
    
    private var stubViewImage: UIImageView = {
        let image = UIImage(named: "Stub")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var stubViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(stubViewImage.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(stubViewImage.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        
        constraints.append(stubViewLabel.centerXAnchor.constraint(equalTo: stubViewImage.centerXAnchor))
        constraints.append(stubViewLabel.topAnchor.constraint(equalTo: stubViewImage.bottomAnchor, constant: 8))
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupView() {
        view.addSubview(stubViewImage)
        view.addSubview(stubViewLabel)
    }
}
