//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 12.11.2023.
//

import Foundation

struct WeatherModel: Codable {
    let coordinates: Coordinates?
    let timezone, id: Int?
    let weather: [Weather]?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let rain: Rain?
    let snow: Snow?
    let clouds: Clouds?
    let name: String?
}


struct Coordinates: Codable {
    let lat, lon: Double?
}


struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
}

struct Wind: Codable {
    let windSpeed, windGust: Double?
    let windDeg: Int?
    
    enum CodingKeys: String, CodingKey {
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDeg = "wind_deg"
    }
}

struct Rain: Codable {
    let rain: Double?
    
    enum CodingKeys: String, CodingKey {
        case rain = "1h"
    }
}

struct Snow: Codable {
    let snow: Double?
    
    enum CodingKeys: String, CodingKey {
        case snow = "1h"
    }
}

struct Clouds: Codable {
    let all: Int?
}

struct Sys: Codable {
    let type, id: Int?
    let country: String?
    let sunrise, sunset: Double?
}


