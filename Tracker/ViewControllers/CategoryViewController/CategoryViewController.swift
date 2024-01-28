//
//  CategoryViewController.swift
//  Tracker
//
//  Created by Ivan Cherkashin on 13.01.2024.
//

import UIKit

final class CategoryViewController: UIViewController {
    //MARK: - Delegate
    weak var delegate: CategoryViewControllerDelegate?
    //MARK: - Private Properties
    private var selectedCategory: String = ""
    private let categoryStore = TrackerCategoryStore.shared
    private let viewModel: CategoryViewModel
    //MARK: - UI
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Категория"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .ypBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var addCategoryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить категорию", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .ypWhite
        button.backgroundColor = .ypBlack
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(addCategoryButtonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stubImageView: UIImageView = {
        let image = UIImage(named: "StubImage")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stubLabel: UILabel = {
        let label = UILabel()
        label.text = "Привычки и события можно \nобъединить по смыслу"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .ypBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryTableView: UITableView = {
        var tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Initializers
    init() {
        viewModel = CategoryViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        view.backgroundColor = .ypWhite
        showOrHideEmptyLabels()
        viewModel.onChange = { [weak self] in
            self?.showOrHideEmptyLabels()
            self?.categoryTableView.reloadData()
        }
    }
    
    // MARK: - LifeCycle:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedCategory = delegate?.selectedCategory ?? ""
    }
    //MARK: - Private Metods
    private func showOrHideEmptyLabels() {
        if !viewModel.categories.isEmpty {
            stubLabel.isHidden = true
            stubImageView.isHidden = true
            categoryTableView.isHidden = false
        } else {
            categoryTableView.isHidden = true
            stubLabel.isHidden = false
            stubImageView.isHidden = false
        }
    }
    
    private func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        //Текстовая картинка в центре главного экрана
        constraints.append(stubImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(stubImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(stubImageView.heightAnchor.constraint(equalToConstant: 80))
        constraints.append(stubImageView.widthAnchor.constraint(equalToConstant: 80))
        
        //Текстовая заглушка в центре главного экрана
        constraints.append(stubLabel.centerXAnchor.constraint(equalTo: stubImageView.centerXAnchor))
        constraints.append(stubLabel.topAnchor.constraint(equalTo: stubImageView.bottomAnchor, constant: 8))
        constraints.append(stubLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(stubLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        
        constraints.append(titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38))
        
        constraints.append(categoryTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16))
        constraints.append(categoryTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16))
        constraints.append(categoryTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38))
        constraints.append(categoryTableView.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor))
        
        constraints.append(addCategoryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(addCategoryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        constraints.append(addCategoryButton.heightAnchor.constraint(equalToConstant: 60))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(addCategoryButton)
        view.addSubview(stubImageView)
        view.addSubview(stubLabel)
        view.addSubview(categoryTableView)
    }
    //MARK: - Objc Metods
    @objc private func addCategoryButtonClicked() {
        let viewController = CreateNewCategoryViewController()
        self.present(viewController, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath)
                as? UITableViewCell
        else {
            assertionFailure("Не удалось выполнить приведение к UITableViewCell")
            return UITableViewCell()
        }
        cell.textLabel?.text = viewModel.categories[indexPath.row].headerName
        cell.selectionStyle = .none
        cell.backgroundColor = .ypBackground
        cell.layer.masksToBounds = true
        if viewModel.categories.count == 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1000)
        } else if indexPath.row == viewModel.categories.count - 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1000)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            cell.layer.cornerRadius = 0
        }
        if selectedCategory == cell.textLabel?.text {
            cell.accessoryView = UIImageView(image: UIImage(named: "DoneCollectionButton"))
        }
        return cell
    }
}
//MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.accessoryView != .none {
            selectedCategory = ""
        } else {
            cell?.accessoryView = UIImageView(image: UIImage(named: "DoneCollectionButton"))
            selectedCategory = cell?.textLabel?.text ?? ""
        }
        delegate?.selectedCategory = selectedCategory
        delegate?.didSelectCategory()
        self.dismiss(animated: true)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView = .none
        selectedCategory = ""
    }
}

