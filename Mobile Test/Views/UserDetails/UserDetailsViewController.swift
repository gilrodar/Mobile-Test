//
//  UserDetailsViewController.swift
//  Mobile Test
//
//  Created by Gil Rodarte on 24/10/20.
//

import UIKit
import Kingfisher
import MapKit

class UserDetailsViewController: UIViewController {
    
    private lazy var profileImageView: ProfileImageView = {
        let imageView = ProfileImageView(frame: .zero)
        imageView.kf.setImage(with: user.picture.profileURL)
        return imageView
    }()
    
    private lazy var usernameLabel: TitleLabel = {
        let label = TitleLabel()
        label.text = user.login.username
        return label
    }()
    
    private lazy var emailLabel: BodyLabel = {
        let label = BodyLabel()
        label.text = user.email
        return label
    }()
    
    private lazy var ageLabel: BodyLabel = {
        let label = BodyLabel()
        label.text = "\(user.dob.age) years"
        return label
    }()
    
    private lazy var genderLabel: BodyLabel = {
        let label = BodyLabel()
        label.text = user.gender.capitalized
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(genderLabel)
        return stackView
    }()
    
    private lazy var locationLabel: BodyLabel = {
        let label = BodyLabel()
        label.text = user.location.fullAddress
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let coordinate = user.location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        mapView.layer.cornerRadius = 10
        return mapView
    }()
    
    var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutViews()
    }
    
    @objc private func closeBarButtonItemPressed() {
        dismiss(animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = user.name.fullName
        
        let closeBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeBarButtonItemPressed))
        navigationItem.rightBarButtonItem = closeBarButtonItem
    }
    
    private func layoutViews() {
        view.addSubview(profileImageView)
        view.addSubview(stackView)
        view.addSubview(locationLabel)
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mapView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
}
