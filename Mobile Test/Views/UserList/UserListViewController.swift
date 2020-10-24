//
//  UserListViewController.swift
//  Mobile Test
//
//  Created by Gil Rodarte on 23/10/20.
//

import UIKit

class UserListViewController: UIViewController {
    
    private lazy var tableView: UITableView =  {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .white
        return activityIndicatorView
    }()
    
    private let viewModel = UserListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutViews()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.showLoading = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { self.activityIndicatorView.startAnimating() }
        }
        
        viewModel.hideLoading = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { self.activityIndicatorView.stopAnimating() }
        }
        
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        
        viewModel.showError = { [weak self ] error in
            guard let self = self else { return }
            DispatchQueue.main.async { self.showError(error: error) }
        }
        
        viewModel.fetchUsers()
    }
    
    private func showError(error: UserError) {
        let tryAgainAction = UIAlertAction(title: "Try again", style: .default) { _ in
            self.viewModel.fetchUsers()
        }
        
        let alertController = UIAlertController(title: error.localizedDescription, message: "There was an error retrieving the information, please try again", preferredStyle: .alert)
        alertController.addAction(tryAgainAction)
        present(alertController, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Mobile Test"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layoutViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = viewModel.users[indexPath.row]
        let controller = UserDetailsViewController(user: user)
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true)
    }
}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let user = viewModel.users[indexPath.row]
        cell.user = user
        return cell
    }
    
}

extension UserListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard !viewModel.isLoadingUsers else { return }
            viewModel.fetchUsers()
        }
    }
}
