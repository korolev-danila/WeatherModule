//
//  File.swift
//  
//
//  Created by Данила on 24.11.2022.
//

import Foundation
import SwiftUI

// https://habr.com/ru/post/414221/

// Simple Weather request struct


// Detailed weather request
struct Weather: Decodable {
    
    var now: String
    var now_dt: Double
    var info: Info
    var fact: Fact
  //  var forecasts: Forecasts
}

struct Info: Decodable {
    
    var lat: Double
    var lon: Double
    var tzinfo: Tzinfo
    var defPressureMm: Double
    var defPressurePa: Double
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case tzinfo
        case defPressureMm = "def_pressure_mm"
        case defPressurePa = "def_pressure_pa"
        case url
    }
      
}

struct Tzinfo: Decodable {
    
    var offset: Double
    var name: String
    var abbr: String
    var dst: Bool
}

struct Fact: Decodable {
    var temp: Double
    var feelsLike: Double
    var icon: String
    var condition: String
    var windSpeed: Double
    var windGust: Double
    var windDir: String
    var pressureMm: Double
    var pressurePa: Double
    var humidity: Double
    var daytime: String
    var polar: Bool
    var season: String
    var precType: Double
    var precStrength: Double
    var isThunder: Bool
    var cloudness:Double
    var obsTime: Double
    var phenomIcon: String
    var phenomCondition: String
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case icon
        case condition
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity
        case daytime
        case polar
        case season
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case isThunder = "is_thunder"
        case cloudness
        case obsTime = "obs_time"
        case phenomIcon = "phenom_icon"
        case phenomCondition = "phenom-condition"
    }
}

struct Forecasts: Decodable {
    
}
