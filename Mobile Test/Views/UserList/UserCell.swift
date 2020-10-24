//
//  UserCell.swift
//  Mobile Test
//
//  Created by Gil Rodarte on 24/10/20.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {
    
    var user: User? {
        didSet {
            profileImageView.kf.setImage(with: user?.picture.profileURL, placeholder: UIImage(named: "Placeholder"))
            fullNameLabel.text = user?.name.fullName
            countryLabel.text = user?.location.country
        }
    }
    
    private let profileImageView = ProfileImageView(frame: .zero)
    private let fullNameLabel = TitleLabel()
    private let countryLabel = BodyLabel()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(fullNameLabel)
        stackView.addArrangedSubview(countryLabel)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
        addSubview(profileImageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
