//
//  UserListViewModel.swift
//  Mobile Test
//
//  Created by Gil Rodarte on 24/10/20.
//

import Foundation

class UserListViewModel {
    
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var reloadTableView: (() -> ())?
    var showError: ((UserError) -> ())?
    
    var users: [User] = [] {
        didSet {
            reloadTableView?()
        }
    }
    
    var page = 1
    var isLoadingUsers = false
    
    func fetchUsers() {
        showLoading?()
        isLoadingUsers = true
        
        NetworkManager.shared.fetchUsers(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.users.append(contentsOf: response.results)
                self.page += 1
            case .failure(let error):
                self.showError?(error)
            }
            
            self.hideLoading?()
            self.isLoadingUsers = false
        }
    }
    
}
