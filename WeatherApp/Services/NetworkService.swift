//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 12.11.2023.
//

import Foundation
import CoreLocation

//MARK: - NetworkService Errors

enum NetworkErrors: Error {
    case notData
    case serverError
    case notCity
    case custom(reason: String)
}

//MARK: - NetworkService Protocol

protocol NetworkServiceProtocol {
    func networkRequest(coordinates: String, completion: @escaping (Result<Data, NetworkErrors>) -> Void)
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherModel) -> Void)
    func getCityByCoordinates(latitude: Double, longitude: Double, completion: @escaping (CityElement) -> Void)
    func getCityByName(name: String, completion: @escaping (CityElement) -> Void)
    func getAllWeather(latitude: Double, longitude: Double, completion: @escaping (AllWeatherModel) -> Void)
    func getInfoAboutCity(name: String, completion: @escaping (WeatherModel, AllWeatherModel) -> Void)
    func getInfoByCoordinates(latitude: Double, longitude: Double, completion: @escaping (WeatherModel, AllWeatherModel) -> Void)
}

//MARK: - NetworkService

final class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    private let myAPIkey: String

    private init() {
        let apiAdress: [UInt8] = [0x61, 0x34, 0x63, 0x39, 0x36, 0x30, 0x30, 0x65, 0x35, 0x35, 0x62, 0x32, 0x34, 0x65, 0x63, 0x65, 0x63, 0x35, 0x34, 0x30, 0x61, 0x37, 0x62, 0x61, 0x62, 0x64, 0x65, 0x32, 0x37, 0x65, 0x37, 0x30]
        let data = Data(apiAdress)
        self.myAPIkey = String(data: data, encoding: .utf8)!
    }

    private let url = "https://openweathermap.org/api"
    
    //MARK: - networkRequest
    
    func networkRequest(coordinates: String, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        let urlWithCoordinates = url + coordinates
        guard let mainUrl = URL(string: urlWithCoordinates.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {return}
        
        URLSession.shared.dataTask(with: mainUrl) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.serverError))
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
    }
    
    //MARK: - Get weather
    
    func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherModel) -> Void) {
        let coordinates = "data/2.5/weather?lat=\(latitude)&lon=\(longitude)&lang=ru&units=metric&appid=\(myAPIkey)"
        networkRequest(coordinates: coordinates, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completion(weatherModel)
                } catch {}
            case .failure(let error):
                print(error)
            }
        })
    }
    
    //MARK: - Get city by coordinates
    
    func getCityByCoordinates(latitude: Double, longitude: Double, completion: @escaping (CityElement) -> Void) {
        let coordinates = "geo/1.0/reverse?lat=\(latitude)&lon=\(longitude)&limit=1&lang=ru&appid=\(myAPIkey)"
        networkRequest(coordinates: coordinates, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let cityModels = try JSONDecoder().decode([CityElement].self, from: data)
                    completion(cityModels.first!)
                } catch {}
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    //MARK: - Get city by name
    
    func getCityByName(name: String, completion: @escaping (CityElement) -> Void) {
        let coordinates = "geo/1.0/direct?q=\(name)&limit=1&lang=ru&appid=\(myAPIkey)"
        networkRequest(coordinates: coordinates, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let cityModeles = try JSONDecoder().decode([CityElement].self, from: data)
                    completion(cityModeles.first!)
                } catch {}
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    //MARK: - Get all weather
    
    func getAllWeather(latitude: Double, longitude: Double, completion: @escaping (AllWeatherModel) -> Void) {
        let coordinates = "data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&lang=ru&units=metric&appid=\(myAPIkey)"
        networkRequest(coordinates: coordinates, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let allWeatherModel = try JSONDecoder().decode(AllWeatherModel.self, from: data)
                    completion(allWeatherModel)
                } catch {}
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    //MARK: - get info about city
    
    func getInfoAboutCity(name: String, completion: @escaping (WeatherModel, AllWeatherModel) -> Void) {
        getCityByName(name: name) { city in
            guard  let latitude = city.lat else {return}
            guard  let longitude = city.lon else {return }
            self.getAllWeather(latitude: latitude, longitude: longitude, completion: { allWeather in
                self.getWeather(latitude: latitude, longitude: longitude, completion:  {weather in
                    completion(weather, allWeather)
                })
            })
        }
    }
    
    //MARK: - Get info by coordinates
    
    func getInfoByCoordinates(latitude: Double, longitude: Double, completion: @escaping (WeatherModel, AllWeatherModel) -> Void) {
        getAllWeather(latitude: latitude, longitude: longitude, completion: { allWeather in
            self.getWeather(latitude: latitude, longitude: longitude, completion: { weather in
                    completion(weather, allWeather)
            })
        })
    }
}
