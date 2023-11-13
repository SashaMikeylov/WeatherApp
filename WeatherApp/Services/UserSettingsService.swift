//
//  UserSettingsService.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 06.11.2023.
//


import Foundation


final class UserSettingsService {
    
    enum SettingsValue: CaseIterable {
        case isCelcia
        case isMile
        case isTwelve
        case isNotify
    }
    
    static var isCelcia: Bool {
        get {
            UserDefaults.standard.bool(forKey: "temperature")
        } set {
            UserDefaults.standard.set(newValue, forKey: "temperature")
        }
    }
    
    static var isMile: Bool {
        get {
            UserDefaults.standard.bool(forKey: "windSpeed")
        } set {
            UserDefaults.standard.set(newValue, forKey: "windSpeed")
        }
    }
    
    static var isTwelve: Bool {
        get {
            UserDefaults.standard.bool(forKey: "timeFormat")
        } set {
            UserDefaults.standard.set(newValue, forKey: "timeFormat")
        }
    }
    
    static var isNotify: Bool {
        get {
            UserDefaults.standard.bool(forKey: "notify")
        } set {
            UserDefaults.standard.set(newValue, forKey: "notify")
        }
    }
}
