//
//  File.swift
//  
//
//  Created by Данила on 23.11.2022.
//

import Foundation
import Alamofire

protocol DetailsInteractorProtocol: AnyObject {
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: Weather ) -> ())
}

class DetailsInteractor: DetailsInteractorProtocol {
    weak var presenter: DetailsPresenterProtocol?
    
    func fetchWeaher(forCity city: City, completion: @escaping (_ weather: Weather ) -> ()) {
        
        let url = "https://api.weather.yandex.ru/v2/forecast?"
        
        let headers: HTTPHeaders = [
            "X-Yandex-API-Key": "80e1e833-ed8f-483b-9870-957eeb4e86a5"
        ]
        
        let parameters: Parameters = [
            "lat" : city.latitude,
            "lon" : city.longitude,
            "lang" : "en_US",
            "limit" : 7,
            "hours" : "false",
            "extra" : "false"
        ]
        
        guard let url = URL(string: url) else { return }
        AF.request(url,method: .get, parameters: parameters, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
               
//                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : AnyObject]
//                    print("#$$$$")
//                    print(json!)
//                    print("#$$$$")
                
                guard let parsedResult: Weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    return
                }
                completion(parsedResult)
  
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

/////////////                                   fsdfllldsfsdfsf                                 sdfsdfsdfgsdf

/*
 ["forecasts": <__NSArrayM 0x600003822280>(
 {
     biomet =     {
         condition = "magnetic-field_0";
         index = 0;
     };
     date = "2022-11-25";
     "date_ts" = 1669330800;
     hours =     (
     );
     "moon_code" = 9;
     "moon_text" = "moon-code-9";
     parts =     {
         day =         {
             "_source" = "12,13,14,15,16,17";
             cloudness = 0;
             condition = clear;
             daytime = d;
             "feels_like" = 11;
             humidity = 59;
             icon = "skc_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.38";
             "soil_temp" = 12;
             "temp_avg" = 13;
             "temp_max" = 15;
             "temp_min" = 10;
             "temp_water" = 14;
             "uv_index" = 1;
             "wind_dir" = ne;
             "wind_gust" = "4.6";
             "wind_speed" = 2;
         };
         "day_short" =         {
             "_source" = "6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21";
             cloudness = 0;
             condition = clear;
             daytime = d;
             "feels_like" = 7;
             humidity = 69;
             icon = "skc_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 960;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 763;
             "pressure_pa" = 1017;
             "soil_moisture" = "0.38";
             "soil_temp" = 10;
             temp = 15;
             "temp_min" = 5;
             "temp_water" = 14;
             "uv_index" = 1;
             "wind_dir" = nw;
             "wind_gust" = "5.4";
             "wind_speed" = "2.5";
         };
         evening =         {
             "_source" = "18,19,20,21";
             cloudness = 0;
             condition = clear;
             daytime = n;
             "feels_like" = 6;
             humidity = 81;
             icon = "skc_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 240;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.38";
             "soil_temp" = 9;
             "temp_avg" = 8;
             "temp_max" = 9;
             "temp_min" = 7;
             "temp_water" = 14;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "3.3";
             "wind_speed" = "1.6";
         };
         morning =         {
             "_source" = "6,7,8,9,10,11";
             cloudness = 0;
             condition = clear;
             daytime = d;
             "feels_like" = 6;
             humidity = 72;
             icon = "skc_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 763;
             "pressure_pa" = 1017;
             "soil_moisture" = "0.39";
             "soil_temp" = 7;
             "temp_avg" = 9;
             "temp_max" = 13;
             "temp_min" = 5;
             "temp_water" = 13;
             "uv_index" = 1;
             "wind_dir" = sw;
             "wind_gust" = "5.4";
             "wind_speed" = "2.5";
         };
         night =         {
             "_source" = "0,1,2,3,4,5";
             cloudness = 0;
             condition = clear;
             daytime = n;
             "feels_like" = 4;
             humidity = 78;
             icon = "skc_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.4";
             "soil_temp" = 8;
             "temp_avg" = 7;
             "temp_max" = 7;
             "temp_min" = 6;
             "temp_water" = 14;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "5.6";
             "wind_speed" = "2.7";
         };
         "night_short" =         {
             "_source" = "0,1,2,3,4,5";
             cloudness = 0;
             condition = clear;
             daytime = n;
             "feels_like" = 4;
             humidity = 78;
             icon = "skc_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.4";
             "soil_temp" = 8;
             temp = 6;
             "temp_water" = 14;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "5.6";
             "wind_speed" = "2.7";
         };
     };
     "rise_begin" = "06:14";
     "set_end" = "16:44";
     sunrise = "06:45";
     sunset = "16:14";
     week = 47;
 },
 {
     biomet =     {
         condition = "magnetic-field_1";
         index = 1;
     };
     date = "2022-11-26";
     "date_ts" = 1669417200;
     hours =     (
     );
     "moon_code" = 9;
     "moon_text" = "moon-code-9";
     parts =     {
         day =         {
             "_source" = "12,13,14,15,16,17";
             cloudness = 1;
             condition = overcast;
             daytime = d;
             "feels_like" = 10;
             humidity = 55;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.37";
             "soil_temp" = 11;
             "temp_avg" = 13;
             "temp_max" = 13;
             "temp_min" = 12;
             "temp_water" = 13;
             "uv_index" = 1;
             "wind_dir" = s;
             "wind_gust" = "3.5";
             "wind_speed" = "1.8";
         };
         "day_short" =         {
             "_source" = "6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21";
             cloudness = 1;
             condition = overcast;
             daytime = d;
             "feels_like" = 7;
             humidity = 61;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 960;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 763;
             "pressure_pa" = 1017;
             "soil_moisture" = "0.37";
             "soil_temp" = 10;
             temp = 13;
             "temp_min" = 7;
             "temp_water" = 13;
             "uv_index" = 1;
             "wind_dir" = s;
             "wind_gust" = "7.1";
             "wind_speed" = "3.3";
         };
         evening =         {
             "_source" = "18,19,20,21";
             cloudness = 1;
             condition = overcast;
             daytime = n;
             "feels_like" = 9;
             humidity = 63;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 240;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 763;
             "pressure_pa" = 1017;
             "soil_moisture" = "0.37";
             "soil_temp" = 10;
             "temp_avg" = 12;
             "temp_max" = 12;
             "temp_min" = 12;
             "temp_water" = 13;
             "uv_index" = 0;
             "wind_dir" = n;
             "wind_gust" = "7.1";
             "wind_speed" = "3.3";
         };
         morning =         {
             "_source" = "6,7,8,9,10,11";
             cloudness = 1;
             condition = overcast;
             daytime = d;
             "feels_like" = 6;
             humidity = 65;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 763;
             "pressure_pa" = 1017;
             "soil_moisture" = "0.38";
             "soil_temp" = 7;
             "temp_avg" = 9;
             "temp_max" = 12;
             "temp_min" = 7;
             "temp_water" = 13;
             "uv_index" = 1;
             "wind_dir" = nw;
             "wind_gust" = "3.8";
             "wind_speed" = "1.8";
         };
         night =         {
             "_source" = "22,23,0,1,2,3,4,5";
             cloudness = "0.25";
             condition = "partly-cloudy";
             daytime = n;
             "feels_like" = 3;
             humidity = 82;
             icon = "skc_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 480;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.38";
             "soil_temp" = 7;
             "temp_avg" = 6;
             "temp_max" = 7;
             "temp_min" = 6;
             "temp_water" = 13;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = 4;
             "wind_speed" = "1.9";
         };
         "night_short" =         {
             "_source" = "22,23,0,1,2,3,4,5";
             cloudness = "0.25";
             condition = "partly-cloudy";
             daytime = n;
             "feels_like" = 3;
             humidity = 82;
             icon = "skc_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 480;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.38";
             "soil_temp" = 7;
             temp = 6;
             "temp_water" = 13;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = 4;
             "wind_speed" = "1.9";
         };
     };
     "rise_begin" = "06:15";
     "set_end" = "16:44";
     sunrise = "06:46";
     sunset = "16:13";
     week = 47;
 },
 {
     biomet =     {
         condition = "magnetic-field_0";
         index = 0;
     };
     date = "2022-11-27";
     "date_ts" = 1669503600;
     hours =     (
     );
     "moon_code" = 10;
     "moon_text" = "moon-code-10";
     parts =     {
         day =         {
             "_source" = "12,13,14,15,16,17";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 9;
             humidity = 71;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.4";
             "prec_period" = 360;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.41";
             "soil_temp" = 10;
             "temp_avg" = 11;
             "temp_max" = 11;
             "temp_min" = 10;
             "temp_water" = 12;
             "uv_index" = 1;
             "wind_dir" = s;
             "wind_gust" = "3.2";
             "wind_speed" = "1.6";
         };
         "day_short" =         {
             "_source" = "6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 7;
             humidity = 73;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.8";
             "prec_period" = 960;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.4";
             "soil_temp" = 9;
             temp = 11;
             "temp_min" = 9;
             "temp_water" = 12;
             "uv_index" = 1;
             "wind_dir" = nw;
             "wind_gust" = "6.4";
             "wind_speed" = "3.3";
         };
         evening =         {
             "_source" = "18,19,20,21";
             cloudness = 1;
             condition = overcast;
             daytime = n;
             "feels_like" = 7;
             humidity = 77;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 240;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.4";
             "soil_temp" = 7;
             "temp_avg" = 10;
             "temp_max" = 10;
             "temp_min" = 9;
             "temp_water" = 12;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "6.4";
             "wind_speed" = "3.3";
         };
         morning =         {
             "_source" = "6,7,8,9,10,11";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 7;
             humidity = 72;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.4";
             "prec_period" = 360;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.38";
             "soil_temp" = 9;
             "temp_avg" = 10;
             "temp_max" = 10;
             "temp_min" = 9;
             "temp_water" = 12;
             "uv_index" = 1;
             "wind_dir" = nw;
             "wind_gust" = "5.9";
             "wind_speed" = 3;
         };
         night =         {
             "_source" = "22,23,0,1,2,3,4,5";
             cloudness = 1;
             condition = overcast;
             daytime = n;
             "feels_like" = 8;
             humidity = 69;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 480;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.37";
             "soil_temp" = 10;
             "temp_avg" = 11;
             "temp_max" = 11;
             "temp_min" = 10;
             "temp_water" = 13;
             "uv_index" = 0;
             "wind_dir" = n;
             "wind_gust" = "7.1";
             "wind_speed" = "3.4";
         };
         "night_short" =         {
             "_source" = "22,23,0,1,2,3,4,5";
             cloudness = 1;
             condition = overcast;
             daytime = n;
             "feels_like" = 8;
             humidity = 69;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 480;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.37";
             "soil_temp" = 10;
             temp = 10;
             "temp_water" = 13;
             "uv_index" = 0;
             "wind_dir" = n;
             "wind_gust" = "7.1";
             "wind_speed" = "3.4";
         };
     };
     "rise_begin" = "06:16";
     "set_end" = "16:44";
     sunrise = "06:47";
     sunset = "16:12";
     week = 47;
 },
 {
     biomet =     {
         condition = "magnetic-field_0";
         index = 0;
     };
     date = "2022-11-28";
     "date_ts" = 1669590000;
     hours =     (
     );
     "moon_code" = 10;
     "moon_text" = "moon-code-10";
     parts =     {
         day =         {
             "_source" = "12,13,14,16";
             cloudness = "0.25";
             condition = "partly-cloudy";
             daytime = d;
             "feels_like" = 10;
             humidity = 55;
             icon = "skc_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 300;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 761;
             "pressure_pa" = 1014;
             "soil_moisture" = "0.38";
             "soil_temp" = 10;
             "temp_avg" = 12;
             "temp_max" = 12;
             "temp_min" = 11;
             "temp_water" = 12;
             "uv_index" = 2;
             "wind_dir" = s;
             "wind_gust" = "3.8";
             "wind_speed" = "1.3";
         };
         "day_short" =         {
             "_source" = "6,7,8,9,10,11,12,13,14,16,19";
             cloudness = 0;
             condition = clear;
             daytime = d;
             "feels_like" = 5;
             humidity = 64;
             icon = "skc_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 840;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 762;
             "pressure_pa" = 1015;
             "soil_moisture" = "0.38";
             "soil_temp" = 8;
             temp = 12;
             "temp_min" = 6;
             "temp_water" = 12;
             "uv_index" = 2;
             "wind_dir" = nw;
             "wind_gust" = "5.6";
             "wind_speed" = 3;
         };
         evening =         {
             "_source" = 19;
             cloudness = 0;
             condition = clear;
             daytime = n;
             "feels_like" = 5;
             humidity = 72;
             icon = "skc_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 180;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 758;
             "pressure_pa" = 1010;
             "soil_moisture" = "0.37";
             "soil_temp" = 7;
             "temp_avg" = 7;
             "temp_max" = 7;
             "temp_min" = 7;
             "temp_water" = 12;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "2.3";
             "wind_speed" = "1.1";
         };
         morning =         {
             "_source" = "6,7,8,9,10,11";
             cloudness = 0;
             condition = clear;
             daytime = d;
             "feels_like" = 4;
             humidity = 69;
             icon = "skc_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.38";
             "soil_temp" = 5;
             "temp_avg" = 8;
             "temp_max" = 11;
             "temp_min" = 6;
             "temp_water" = 12;
             "uv_index" = 1;
             "wind_dir" = nw;
             "wind_gust" = "5.6";
             "wind_speed" = 3;
         };
         night =         {
             "_source" = "22,23,0,1,2,3,4,5";
             cloudness = "0.5";
             condition = cloudy;
             daytime = n;
             "feels_like" = 3;
             humidity = 78;
             icon = "bkn_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 480;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.39";
             "soil_temp" = 6;
             "temp_avg" = 7;
             "temp_max" = 8;
             "temp_min" = 6;
             "temp_water" = 12;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "6.8";
             "wind_speed" = "3.4";
         };
         "night_short" =         {
             "_source" = "22,23,0,1,2,3,4,5";
             cloudness = "0.5";
             condition = cloudy;
             daytime = n;
             "feels_like" = 3;
             humidity = 78;
             icon = "bkn_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 480;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 764;
             "pressure_pa" = 1018;
             "soil_moisture" = "0.39";
             "soil_temp" = 6;
             temp = 6;
             "temp_water" = 12;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "6.8";
             "wind_speed" = "3.4";
         };
     };
     "rise_begin" = "06:17";
     "set_end" = "16:43";
     sunrise = "06:48";
     sunset = "16:12";
     week = 48;
 },
 {
     date = "2022-11-29";
     "date_ts" = 1669676400;
     hours =     (
     );
     "moon_code" = 11;
     "moon_text" = "moon-code-11";
     parts =     {
         day =         {
             "_source" = "13,16";
             cloudness = "0.5";
             condition = cloudy;
             daytime = d;
             "feels_like" = 10;
             humidity = 57;
             icon = "bkn_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.37";
             "soil_temp" = 9;
             "temp_avg" = 12;
             "temp_max" = 12;
             "temp_min" = 11;
             "temp_water" = 12;
             "uv_index" = 1;
             "wind_dir" = ne;
             "wind_gust" = "3.7";
             "wind_speed" = "1.3";
         };
         "day_short" =         {
             "_source" = "7,10,13,16,19";
             cloudness = "0.5";
             condition = cloudy;
             daytime = d;
             "feels_like" = 6;
             humidity = 64;
             icon = "bkn_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 900;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 760;
             "pressure_pa" = 1013;
             "soil_moisture" = "0.37";
             "soil_temp" = 7;
             temp = 12;
             "temp_min" = 4;
             "temp_water" = 12;
             "uv_index" = 1;
             "wind_dir" = s;
             "wind_gust" = "3.7";
             "wind_speed" = "1.4";
         };
         evening =         {
             "_source" = 19;
             cloudness = 1;
             condition = overcast;
             daytime = n;
             "feels_like" = 6;
             humidity = 69;
             icon = ovc;
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 180;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 760;
             "pressure_pa" = 1013;
             "soil_moisture" = "0.37";
             "soil_temp" = 7;
             "temp_avg" = 8;
             "temp_max" = 8;
             "temp_min" = 8;
             "temp_water" = 12;
             "wind_dir" = nw;
             "wind_gust" = "2.8";
             "wind_speed" = "1.1";
         };
         morning =         {
             "_source" = "7,10";
             cloudness = "0.5";
             condition = cloudy;
             daytime = d;
             "feels_like" = 3;
             humidity = 70;
             icon = "bkn_d";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 360;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 761;
             "pressure_pa" = 1014;
             "soil_moisture" = "0.37";
             "soil_temp" = 5;
             "temp_avg" = 6;
             "temp_max" = 8;
             "temp_min" = 4;
             "temp_water" = 11;
             "uv_index" = 1;
             "wind_dir" = s;
             "wind_gust" = "2.8";
             "wind_speed" = "1.4";
         };
         night =         {
             "_source" = "22,1,4";
             cloudness = "0.75";
             condition = cloudy;
             daytime = n;
             "feels_like" = 2;
             humidity = 75;
             icon = "bkn_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 540;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.37";
             "soil_temp" = 5;
             "temp_avg" = 5;
             "temp_max" = 5;
             "temp_min" = 5;
             "temp_water" = 12;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "3.7";
             "wind_speed" = "1.8";
         };
         "night_short" =         {
             "_source" = "22,1,4";
             cloudness = "0.75";
             condition = cloudy;
             daytime = n;
             "feels_like" = 2;
             humidity = 75;
             icon = "bkn_n";
             polar = 0;
             "prec_mm" = 0;
             "prec_period" = 540;
             "prec_prob" = 0;
             "prec_strength" = 0;
             "prec_type" = 0;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.37";
             "soil_temp" = 5;
             temp = 5;
             "temp_water" = 12;
             "uv_index" = 0;
             "wind_dir" = nw;
             "wind_gust" = "3.7";
             "wind_speed" = "1.8";
         };
     };
     "rise_begin" = "06:18";
     "set_end" = "16:43";
     sunrise = "06:50";
     sunset = "16:12";
     week = 48;
 },
 {
     date = "2022-11-30";
     "date_ts" = 1669762800;
     hours =     (
     );
     "moon_code" = 12;
     "moon_text" = "moon-code-12";
     parts =     {
         day =         {
             "_source" = "13,16";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 12;
             humidity = 75;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "1.1";
             "prec_period" = 360;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 756;
             "pressure_pa" = 1007;
             "soil_moisture" = "0.42";
             "soil_temp" = 10;
             "temp_avg" = 13;
             "temp_max" = 13;
             "temp_min" = 12;
             "temp_water" = 12;
             "wind_dir" = sw;
             "wind_gust" = "2.4";
             "wind_speed" = "1.2";
         };
         "day_short" =         {
             "_source" = "7,10,13,16,19";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 9;
             humidity = 77;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "1.9";
             "prec_period" = 900;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 757;
             "pressure_pa" = 1009;
             "soil_moisture" = "0.42";
             "soil_temp" = 10;
             temp = 13;
             "temp_min" = 8;
             "temp_water" = 12;
             "wind_dir" = w;
             "wind_gust" = "2.9";
             "wind_speed" = "1.9";
         };
         evening =         {
             "_source" = 19;
             cloudness = 1;
             condition = "light-rain";
             daytime = n;
             "feels_like" = 8;
             humidity = 81;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.5";
             "prec_period" = 180;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 757;
             "pressure_pa" = 1009;
             "soil_moisture" = "0.43";
             "soil_temp" = 9;
             "temp_avg" = 10;
             "temp_max" = 10;
             "temp_min" = 10;
             "temp_water" = 12;
             "wind_dir" = w;
             "wind_gust" = "1.9";
             "wind_speed" = "1.3";
         };
         morning =         {
             "_source" = "7,10";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 8;
             humidity = 77;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.3";
             "prec_period" = 360;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.41";
             "soil_temp" = 9;
             "temp_avg" = 10;
             "temp_max" = 11;
             "temp_min" = 8;
             "temp_water" = 11;
             "wind_dir" = nw;
             "wind_gust" = "2.9";
             "wind_speed" = "1.9";
         };
         night =         {
             "_source" = "22,1,4";
             cloudness = 1;
             condition = rain;
             daytime = n;
             "feels_like" = 5;
             humidity = 74;
             icon = "ovc_ra";
             polar = 0;
             "prec_mm" = "2.6";
             "prec_period" = 540;
             "prec_prob" = 20;
             "prec_strength" = "0.5";
             "prec_type" = 1;
             "pressure_mm" = 758;
             "pressure_pa" = 1010;
             "soil_moisture" = "0.43";
             "soil_temp" = 8;
             "temp_avg" = 8;
             "temp_max" = 8;
             "temp_min" = 8;
             "temp_water" = 12;
             "wind_dir" = nw;
             "wind_gust" = "4.4";
             "wind_speed" = "2.4";
         };
         "night_short" =         {
             "_source" = "22,1,4";
             cloudness = 1;
             condition = rain;
             daytime = n;
             "feels_like" = 5;
             humidity = 74;
             icon = "ovc_ra";
             polar = 0;
             "prec_mm" = "2.6";
             "prec_period" = 540;
             "prec_prob" = 20;
             "prec_strength" = "0.5";
             "prec_type" = 1;
             "pressure_mm" = 758;
             "pressure_pa" = 1010;
             "soil_moisture" = "0.43";
             "soil_temp" = 8;
             temp = 8;
             "temp_water" = 12;
             "wind_dir" = nw;
             "wind_gust" = "4.4";
             "wind_speed" = "2.4";
         };
     };
     "rise_begin" = "06:19";
     "set_end" = "16:42";
     sunrise = "06:51";
     sunset = "16:11";
     week = 48;
 },
 {
     date = "2022-12-01";
     "date_ts" = 1669849200;
     hours =     (
     );
     "moon_code" = 12;
     "moon_text" = "moon-code-12";
     parts =     {
         day =         {
             "_source" = "13,16";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 12;
             humidity = 71;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.2";
             "prec_period" = 360;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 758;
             "pressure_pa" = 1010;
             "soil_moisture" = "0.41";
             "soil_temp" = 11;
             "temp_avg" = 13;
             "temp_max" = 13;
             "temp_min" = 12;
             "temp_water" = 12;
             "wind_dir" = e;
             "wind_gust" = "2.8";
             "wind_speed" = "0.7";
         };
         "day_short" =         {
             "_source" = "7,10,13,16,19";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 9;
             humidity = 76;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.5";
             "prec_period" = 900;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.41";
             "soil_temp" = 9;
             temp = 13;
             "temp_min" = 9;
             "temp_water" = 12;
             "wind_dir" = e;
             "wind_gust" = "2.8";
             "wind_speed" = "1.4";
         };
         evening =         {
             "_source" = 19;
             cloudness = 1;
             condition = "light-rain";
             daytime = n;
             "feels_like" = 8;
             humidity = 81;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.1";
             "prec_period" = 180;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 761;
             "pressure_pa" = 1014;
             "soil_moisture" = "0.41";
             "soil_temp" = 9;
             "temp_avg" = 10;
             "temp_max" = 10;
             "temp_min" = 10;
             "temp_water" = 12;
             "wind_dir" = w;
             "wind_gust" = "1.9";
             "wind_speed" = "1.4";
         };
         morning =         {
             "_source" = "7,10";
             cloudness = 1;
             condition = "light-rain";
             daytime = d;
             "feels_like" = 9;
             humidity = 80;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.2";
             "prec_period" = 360;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 759;
             "pressure_pa" = 1011;
             "soil_moisture" = "0.41";
             "soil_temp" = 8;
             "temp_avg" = 10;
             "temp_max" = 11;
             "temp_min" = 9;
             "temp_water" = 12;
             "wind_dir" = w;
             "wind_gust" = "1.6";
             "wind_speed" = "0.6";
         };
         night =         {
             "_source" = "22,1,4";
             cloudness = 1;
             condition = "light-rain";
             daytime = n;
             "feels_like" = 8;
             humidity = 82;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.3";
             "prec_period" = 540;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 757;
             "pressure_pa" = 1009;
             "soil_moisture" = "0.42";
             "soil_temp" = 9;
             "temp_avg" = 10;
             "temp_max" = 10;
             "temp_min" = 9;
             "temp_water" = 12;
             "wind_dir" = nw;
             "wind_gust" = "2.8";
             "wind_speed" = "1.4";
         };
         "night_short" =         {
             "_source" = "22,1,4";
             cloudness = 1;
             condition = "light-rain";
             daytime = n;
             "feels_like" = 8;
             humidity = 82;
             icon = "ovc_-ra";
             polar = 0;
             "prec_mm" = "0.3";
             "prec_period" = 540;
             "prec_prob" = 20;
             "prec_strength" = "0.25";
             "prec_type" = 1;
             "pressure_mm" = 757;
             "pressure_pa" = 1009;
             "soil_moisture" = "0.42";
             "soil_temp" = 9;
             temp = 9;
             "temp_water" = 12;
             "wind_dir" = nw;
             "wind_gust" = "2.8";
             "wind_speed" = "1.4";
         };
     };
     "rise_begin" = "06:20";
     "set_end" = "16:42";
     sunrise = "06:52";
     sunset = "16:11";
     week = 48;
 }
 )
 , "yesterday": {
     temp = 11;
 }, "now_dt": 2022-11-25T16:39:01.878526Z, "info": {
     "_h" = 0;
     "def_pressure_mm" = 755;
     "def_pressure_pa" = 1006;
     f = 1;
     geoid = 21611;
     lat = "42.4397";
     lon = "19.2661";
     n = 1;
     nr = 1;
     ns = 1;
     nsr = 1;
     p = 0;
     slug = 21611;
     tzinfo =     {
         abbr = CET;
         dst = 0;
         name = "Europe/Belgrade";
         offset = 3600;
     };
     url = "https://meteum.ai/21611?lat=42.4397&lon=19.2661";
     zoom = 10;
 }, "now": 1669394341, "fact": {
     cloudness = 0;
     condition = clear;
     daytime = n;
     "feels_like" = 7;
     humidity = 71;
     icon = "skc_n";
     "is_thunder" = 0;
     "obs_time" = 1669392000;
     polar = 0;
     "prec_prob" = 0;
     "prec_strength" = 0;
     "prec_type" = 0;
     "pressure_mm" = 764;
     "pressure_pa" = 1018;
     season = autumn;
     "soil_moisture" = "0.38";
     "soil_temp" = 12;
     source = station;
     temp = 9;
     "temp_water" = 14;
     uptime = 1669394341;
     "uv_index" = 0;
     "wind_dir" = n;
     "wind_gust" = "2.9";
     "wind_speed" = 1;
 }, "geo_object": {
     country =     {
         id = 21610;
         name = Montenegro;
     };
     district =     {
         id = 21611;
         name = "rayon Tsentr";
     };
     locality =     {
         id = 21611;
         name = Podgorica;
     };
     province =     {
         id = 21610;
         name = "\U0433\U043b\U0430\U0432\U043d\U0438 \U0433\U0440\U0430\U0434 \U041f\U043e\U0434\U0433\U043e\U0440\U0438\U0446\U0430";
     };
 }]
 */

