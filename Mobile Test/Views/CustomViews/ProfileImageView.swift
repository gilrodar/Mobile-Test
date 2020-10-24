//
//  ProfileImageView.swift
//  Mobile Test
//
//  Created by Gil Rodarte on 24/10/20.
//

import UIKit

class ProfileImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
}
