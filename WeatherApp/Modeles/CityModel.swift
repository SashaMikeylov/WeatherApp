//
//  CityModel.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 12.11.2023.
//

import Foundation


struct CityElement: Codable {
    let name: String?
    let localNames: [String: String]?
    let lat, lon: Double?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country
    }
}
