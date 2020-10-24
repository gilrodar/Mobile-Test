//
//  User.swift
//  Mobile Test
//
//  Created by Gil Rodarte on 24/10/20.
//

import Foundation
import CoreLocation

struct UserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name
    let gender: String
    let email: String
    let login: Login
    let picture: Picture
    let dob: Dob
    let location: Location
    
    struct Name: Codable {
        let first: String
        let last: String
        
        var fullName: String? {
            return "\(first) \(last)"
        }
    }
    
    struct Login: Codable {
        let username: String
    }
    
    struct Picture: Codable {
        let large: String
        
        var profileURL: URL {
            return URL(string: large)!
        }
    }
    
    struct Dob: Codable {
        let age: Int
    }
    
    struct Location: Codable {
        let street: Street
        let city: String
        let state: String
        let country: String
        let coordinates: Coordinates
        
        var fullAddress: String {
            var fullAddress = ""
            fullAddress += "\(street.name) \(street.number) \n"
            fullAddress += "\(city), \(state) \n"
            fullAddress += country
            return fullAddress
        }
        
        var coordinate: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: Double(coordinates.latitude)!, longitude: Double(coordinates.longitude)!)
        }
        
        struct Street: Codable {
            let number: Int
            let name: String
        }
        
        struct Coordinates: Codable {
            let latitude: String
            let longitude: String
        }
    }
}
