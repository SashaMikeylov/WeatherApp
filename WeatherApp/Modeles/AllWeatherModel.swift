//
//  AllWeatherModel.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 12.11.2023.
//

import Foundation

struct AllWeatherModel: Codable {
    let list: [List]?
    let city: City?
}

struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

struct Coord: Codable {
    let lat, lon: Double?
}

struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [WeatherAll]?
    let clouds: CloudsAll?
    let wind: WindAll?
    let visibility: Int?
    let pop: Double?
    let rain: RainAll?
    let snow: SnowAll?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop
        case rain, snow
    }
}

struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct WeatherAll: Codable {
    let id: Int?
    let main, description, icon: String?
}

struct CloudsAll: Codable {
    let all: Int?
}

struct WindAll: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

struct RainAll: Codable {
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case rain = "3h"
    }
}

struct SnowAll: Codable {
    let snow: Double?
    
    enum CodingKeys: String, CodingKey {
        case snow = "3h"
    }
}
