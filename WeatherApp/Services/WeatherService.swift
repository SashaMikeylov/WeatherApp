//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Денис Кузьминов on 16.11.2023.
//

import Foundation

//MARK: - Wetaher service protocol

protocol WeatherServiceProtocol {
    func futureDates(indx: Int, timezone: Int, weekDay: Bool) -> String
    func allWeatherTemp(day: Int) -> String
    func averageHumidity(day: Int) -> String
    func primaryDescription(day: Int) -> String
    func primaryIco(day: Int) -> String
    func halfDayTemp(day: Int, isNight: Bool) -> String
    func halfDayIco(day: Int, isNight: Bool) -> String
    func halfDayDesc(day: Int, isNight: Bool) -> String
    func halfDayValue(valueType: WeatherStackType, day: Int, isNight: Bool) -> String
}


//MARK: - Network service

final class WeatherService: WeatherServiceProtocol {
    
    private var allWeatherModel: AllWeatherModel?
    private var futureDays: [List] = []
    
    init(allWeatherModel: AllWeatherModel?) {
        self.allWeatherModel = allWeatherModel
        newDays()
    }
    
    
    //MARK: - New days
    
    private func newDays() {
        guard let allWeatherList = (allWeatherModel?.list) else { return }
        let timezone = allWeatherModel?.city?.timezone
        for (index, day) in allWeatherList.enumerated() {
            if (day.dt! + timezone!) % (24 * 60 * 60) < (3 * 60 * 60) {
                let slicedArray = [List](allWeatherList[index..<allWeatherList.count])
                futureDays = slicedArray
                return
            }
        }
    }

    //MARK: - Get dates
    
    func futureDates(indx: Int, timezone: Int, weekDay: Bool) -> String {//
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = weekDay ? "dd/MM E" : "dd/MM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = .gmt
        let today = Calendar.current.date(byAdding: .second, value: timezone, to: .now)
        let nextDate = Calendar.current.date(byAdding: .day, value: indx + 1, to: today!)
        return dateFormatter.string(from: nextDate!)
    }
    
    //MARK: - All weather temp
    
    func allWeatherTemp(day: Int) -> String {
        guard futureDays.count > ((day + 1) * 8) else { return "??°-??°" }
        
        let needDay = futureDays[(8 * day) ..< (8 * (day + 1))]
        var tempDayArray: [Double] = []
        for hour in needDay {
            tempDayArray.append(hour.main?.temp ?? 0)
        }

        let minCelsium = Int(tempDayArray.min()?.rounded() ?? 0)
        let minFahrenheit = minCelsium * 9 / 5 + 32
        let maxCelsium = Int(tempDayArray.max()?.rounded() ?? 0)
        let maxFahrenheit = maxCelsium * 9 / 5 + 32

        return UserSettingsService.isCelcia ?  "\(minCelsium)°.. \(maxCelsium)°" : "\(minFahrenheit)°.. \(maxFahrenheit)°"
    }
    
    //MARK: - Average Humidity
    
    func averageHumidity(day: Int) -> String {
        guard futureDays.count > ((day + 1) * 8) else {  return "?%" }
    
       let needDay = futureDays[(8 * day) ..< (8 * (day + 1))]
       var humidity: Int = 0
       for hour in needDay {
           humidity += hour.main?.humidity ?? 0
       }

       return "\(humidity / 8)%"
   }

   //MARK: - repeat values
    
   private func commonElementsInArray(stringArray: [String]) -> String {
       let dict = Dictionary(grouping: stringArray, by: {$0})
       let newDict = dict.mapValues({$0.count})
       return newDict.sorted(by: {$0.value > $1.value}).first?.key ?? ""
   }

   //MARK: - wetaher description
    
    func primaryDescription(day: Int) -> String {
        guard futureDays.count > ((day + 1) * 8) else {  return "--no data available--" }

       let needDay = [List](futureDays[(8 * day) ..< (8 * (day + 1))])
       var weatherDescription: [String] = []
       for hour in needDay {
           weatherDescription.append(hour.weather?.first?.description ?? "")
       }
       let result = commonElementsInArray(stringArray: weatherDescription)

       return result
   }

   // MARK: - primar icon
    
    func primaryIco(day: Int) -> String {
       guard futureDays.count > ((day + 1) * 8) else {
           return "fog"
       }
       let needDay = [List](futureDays[(8 * day) ..< (8 * (day + 1))])
       var weatherIco: [String] = []
       for hour in needDay {
           weatherIco.append(hour.weather?.first?.icon ?? "fog")
       }
       let result = commonElementsInArray(stringArray: weatherIco)

       return result
   }

   //MARK: - Day temperature or night temperature
    
   func halfDayTemp(day: Int, isNight: Bool) -> String {
       guard futureDays.count > ((day + 1) * 8) else {
           return "??°"
       }
       let needDay = [List](futureDays[(8 * day) ..< (8 * (day + 1))])
       let temp = isNight ? needDay[1].main?.temp : needDay[5].main?.temp
       let celsium = Int(temp?.rounded() ?? 0)
       let fahrenheit = celsium * 9 / 5 + 32

       return UserSettingsService.isCelcia ? "\(celsium)°" : "\(fahrenheit)°"
   }
   
    //MARK: - Day or night icon

   func halfDayIco(day: Int, isNight: Bool) -> String {
       guard futureDays.count > ((day + 1) * 8) else {
           return "fog"
       }
       let needDay = [List](futureDays[(8 * day) ..< (8 * (day + 1))])
       let ico = isNight ? needDay[1].weather?.first?.icon : needDay[5].weather?.first?.icon

       return ico ?? "fog"
   }
    
  //MARK: - Day or night description
    
   func halfDayDesc(day: Int, isNight: Bool) -> String {
       guard futureDays.count > ((day + 1) * 8) else {
           return "?no data?"
       }
       let needDay = [List](futureDays[(8 * day) ..< (8 * (day + 1))])
       let desc = needDay[isNight ? 1 : 0].weather?.first?.description

       return desc ?? "?no data?"
   }

   //MARK: - Only day or night icon
    
   func halfDayValue(valueType: WeatherStackType, day: Int, isNight: Bool) -> String {
       guard futureDays.count > ((day + 1) * 8) else {
           return "??"
       }
       let needDay = [List](futureDays[(8 * day) ..< (8 * (day + 1))])
       var result = ""
       switch valueType {
       case .temp:
           let temp = isNight ? needDay[1].main?.feelsLike : needDay[5].main?.feelsLike
           let celsium = Int(temp?.rounded() ?? 0)
           let fahrenheit = celsium * 9 / 5 + 32
           result = UserSettingsService.isCelcia ?  "\(celsium)°" : "\(fahrenheit)°"
       case .wind:
           let wind = isNight ? needDay[1].wind?.speed : needDay[5].wind?.speed
           let windSpeed = UserSettingsService.isMile ? 2.237 * (wind?.rounded() ?? 0) : (wind?.rounded() ?? 0)
           let ending = UserSettingsService.isMile ? " mph, " : " м/с, "
           var windDirectionStr: String = ""
           if let windDirection = needDay[isNight ? 1 : 5].wind?.deg {
                   switch windDirection {
                   case 0..<90: windDirectionStr = "СВ"
                   case 90..<180: windDirectionStr = "СЗ"
                   case 180..<270: windDirectionStr = "ЮЗ"
                   default: windDirectionStr = "ЮВ"
                   }
           }
//            let windStr = String(Int(windSpeed)) + ending + windDirectionStr
           result = String(Int(windSpeed)) + ending + windDirectionStr
       case .ultraviolet:
           let visible = isNight ? needDay[1].visibility : needDay[5].visibility
           let distance = UserSettingsService.isMile ? (visible ?? 1613) / 1613 : (visible ?? 1000) / 1000
           result = String(distance) + (UserSettingsService.isMile ? " миль" : " км")
       case .rainfall:
           let hum = isNight ? needDay[1].main?.humidity : needDay[5].main?.humidity
           result = "\(hum ?? 0)%"
       case .cloud:
           let cloud = isNight ? needDay[1].clouds?.all : needDay[5].clouds?.all
           result = "\(cloud ?? 0)%"
       }

       return result
   }
    
}
