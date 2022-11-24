//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import Alamofire

protocol DetailsInteractorProtocol: AnyObject {
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: WeatherSimple ) -> ())
}

class DetailsInteractor: DetailsInteractorProtocol {
    weak var presenter: DetailsPresenterProtocol?
    
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: WeatherSimple ) -> ()) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast?"
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "80e1e833-ed8f-483b-9870-957eeb4e86a5"
        ]
        
        let parameters: Parameters = [
            "lat" : city.latitude,
            "lon" : city.longitude,
            "lang" : "en_US",
            "limit" : 1,
            "hours" : "false",
            "extra" : "false"
        ]
        
        guard let url = URL(string: url) else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : AnyObject]
//                    print("#$$$$")
//                    print(json!)
                    print("#$$$$")
                    guard let parsedResult: WeatherSimple = try? JSONDecoder().decode(WeatherSimple.self, from: data) else {
                        print("proebal ^^^^^^^^^^^^^^^")
                        return
                    }
                    print(parsedResult)
                    completion(parsedResult)

                } catch {
                    
                }
                print("$$$$")
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

/*

["info": {
    
    "_h" = 0;
    "def_pressure_mm" = 747;
    "def_pressure_pa" = 995;
    f = 1;
    geoid = 213;
    lat = "55.7558";
    lon = "37.6178";
    n = 1;
    nr = 1;
    ns = 1;
    nsr = 1;
    p = 0;
    slug = 213;
    tzinfo =     {
        
        abbr = MSK;
        dst = 0;
        name = "Europe/Moscow";
        offset = 10800;                   ///////
        
    };
    url = "https://meteum.ai/213?lat=55.7558&lon=37.6178";
    zoom = 10;
    
},
 
 "now_dt": 2022-11-24T11:48:17.948198Z,
 
 "forecasts": <__NSArrayM 0x600002a95050>({
    biomet =     {
        
        condition = "magnetic-field_0";
        index = 0;
        
    };
    date = "2022-11-24";
    "date_ts" = 1669237200;
    hours =     (
    );
    "moon_code" = 8;
    "moon_text" = "moon-code-8";
    parts =     {
        
        day =         {
            
            "_source" = "12,13,14,15,16,17";
            cloudness = 1;
            condition = "light-snow";
            daytime = d;
            "feels_like" = "-9";
            "fresh_snow_mm" = "1.8";
            humidity = 86;
            icon = "ovc_-sn";
            polar = 0;
            "prec_mm" = "0.1";
            "prec_period" = 360;
            "prec_prob" = 90;
            "prec_strength" = "0.25";
            "prec_type" = 3;
            "pressure_mm" = 753;
            "pressure_pa" = 1003;
            "soil_moisture" = "0.37";
            "soil_temp" = 0;
            "temp_avg" = "-4";
            "temp_max" = "-3";
            "temp_min" = "-4";
            "uv_index" = 0;
            "wind_dir" = ne;
            "wind_gust" = "5.7";
            "wind_speed" = "3.4";
            
        };
        "day_short" =         {
            
            "_source" = "6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21";
            cloudness = 1;
            condition = "light-snow";
            daytime = d;
            "feels_like" = "-9";
            "fresh_snow_mm" = "9.800000000000001";
            humidity = 88;
            icon = "ovc_-sn";
            polar = 0;
            "prec_mm" = "0.9";
            "prec_period" = 960;
            "prec_prob" = 90;
            "prec_strength" = "0.25";
            "prec_type" = 3;
            "pressure_mm" = 752;
            "pressure_pa" = 1002;
            "soil_moisture" = "0.37";
            "soil_temp" = "-1";
            temp = "-3";
            "temp_min" = "-4";
            "uv_index" = 0;
            "wind_dir" = ne;
            "wind_gust" = 6;
            "wind_speed" = "3.6";
            
        };
        evening =         {
            
            "_source" = "18,19,20,21";
            cloudness = 1;
            condition = "light-snow";
            daytime = n;
            "feels_like" = "-9";
            "fresh_snow_mm" = 2;
            humidity = 87;
            icon = "ovc_-sn";
            polar = 0;
            "prec_mm" = "0.2";
            "prec_period" = 240;
            "prec_prob" = 20;
            "prec_strength" = "0.25";
            "prec_type" = 3;
            "pressure_mm" = 754;
            "pressure_pa" = 1005;
            "soil_moisture" = "0.37";
            "soil_temp" = "-1";
            "temp_avg" = "-4";
            "temp_max" = "-4";
            "temp_min" = "-4";
            "uv_index" = 0;
            "wind_dir" = ne;
            "wind_gust" = 6;
            "wind_speed" = "3.6";
            
        };
        morning =         {
            
            "_source" = "6,7,8,9,10,11";
            cloudness = 1;
            condition = "light-snow";
            daytime = d;
            "feels_like" = "-9";
            "fresh_snow_mm" = 6;
            humidity = 90;
            icon = "ovc_-sn";
            polar = 0;
            "prec_mm" = "0.6";
            "prec_period" = 360;
            "prec_prob" = 30;
            "prec_strength" = "0.25";
            "prec_type" = 3;
            "pressure_mm" = 750;
            "pressure_pa" = 999;
            "soil_moisture" = "0.37";
            "soil_temp" = "-1";
            "temp_avg" = "-4";
            "temp_max" = "-3";
            "temp_min" = "-4";
            "uv_index" = 0;
            "wind_dir" = ne;
            "wind_gust" = "5.6";
            "wind_speed" = "3.3";
            
        };
        night =         {
            
            "_source" = "0,1,2,3,4,5";
            cloudness = 1;
            condition = "light-snow";
            daytime = n;
            "feels_like" = "-7";
            "fresh_snow_mm" = "0.6";
            humidity = 93;
            icon = "ovc_-sn";
            polar = 0;
            "prec_mm" = "0.6";
            "prec_period" = 360;
            "prec_prob" = 40;
            "prec_strength" = "0.25";
            "prec_type" = 3;
            "pressure_mm" = 748;
            "pressure_pa" = 997;
            "soil_moisture" = "0.37";
            "soil_temp" = 0;
            "temp_avg" = "-2";
            "temp_max" = "-2";
            "temp_min" = "-3";
            "uv_index" = 0;
            "wind_dir" = ne;
            "wind_gust" = "5.6";
            "wind_speed" = "3.3";
        };
        
        "night_short" =         {
            
            "_source" = "0,1,2,3,4,5";
            cloudness = 1;
            condition = "light-snow";
            daytime = n;
            "feels_like" = "-7";
            "fresh_snow_mm" = "0.6";
            humidity = 93;
            icon = "ovc_-sn";
            polar = 0;
            "prec_mm" = "0.6";
            "prec_period" = 360;
            "prec_prob" = 40;
            "prec_strength" = "0.25";
            "prec_type" = 3;
            "pressure_mm" = 748;
            "pressure_pa" = 997;
            "soil_moisture" = "0.37";
            "soil_temp" = 0;
            temp = "-3";
            "uv_index" = 0;
            "wind_dir" = ne;
            "wind_gust" = "5.6";
            "wind_speed" = "3.3";
        };
        
    };
    
    "rise_begin" = "07:38";
    "set_end" = "16:53";
    sunrise = "08:21";
    sunset = "16:10";
    week = 47;
}),
 
"fact": {
    "accum_prec" =     {
        1 = "1.2207328";
        3 = "14.691289";
        7 = "22.85338";
    };
    cloudness = 1;
    condition = overcast;
    daytime = d;
    "feels_like" = "-8";
    humidity = 83;
    icon = ovc;
    "is_thunder" = 0;
    "obs_time" = 1669287600;
    polar = 0;
    "prec_prob" = 0;
    "prec_strength" = 0;
    "prec_type" = 0;
    "pressure_mm" = 752;
    "pressure_pa" = 1002;
    season = autumn;
    "soil_moisture" = "0.37";
    "soil_temp" = 0;
    source = station;
    temp = "-3";                         ///
    uptime = 1669290497;
    "uv_index" = 0;
    "wind_dir" = ne;
    "wind_gust" = "5.6";
    "wind_speed" = "3.3";
}, "geo_object": {
    country =     {
        id = 225;
        name = Russia;
    };
    district =     {
        id = 120540;
        name = "Tverskoy District";
    };
    locality =     {
        id = 213;
        name = Moscow;
    };
    province =     {
        id = 213;
        name = Moscow;
    };
},
 "now": 1669290497,
 "yesterday": {
    
    temp = 0;
    
}]

*/
