//
//  NetworkService.swift
//  WeatherTestProject_Final
//
//  Created by Андрей Федоров on 29.04.2023.
//

import Foundation

let token = "3aeea81490e5dc1ce561faf357d2257f"

class NetworkService{
    let coordinateService = CoordinateService()
    func getTemperature(completion: @escaping(Int, String) -> Void) {
        
        //MARK: - Get lan and lon from CoordinateService
        let (lat, lon) = coordinateService.getLocation() ?? (0, 0)
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(round(lat*100)/100)&lon=\(round(lon*100)/100)&appid=\(token)")!
        //print(url)
        let request = URLRequest(url: url)
        
        //MARK: - Do custom request with completion
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do{
                let result = try JSONDecoder().decode(RequestWithCityModel.self, from: data)
                let temp = Int(result.main?.temp ?? 0)
                let name = result.name ?? ""
                completion(temp, name)
            }catch{
                print(error)
                completion(0, "")
            }
        }.resume()
    }
    
    func getTemperatureForCity(city: String, completion: @escaping(Int) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(token)")!
        print(url)
        let request = URLRequest(url: url)
        
        //MARK: - Do custom request with completion
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do{
                let result = try JSONDecoder().decode(RequestWithCityModel.self, from: data)
                let temp = Int(result.main?.temp ?? 0)
                completion(temp)
            }catch{
                print(error)
                completion(0)
            }
        }.resume()
    }
    
    func getTempForWeek(city: String, completion: @escaping([Int]) -> Void){
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(token)&lang=ru&units=metric&cnt=7")!
        print(url)
        let request = URLRequest(url: url)
        
        //MARK: - Do custom request with completion
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            do{
                let result = try JSONDecoder().decode(RequestForWeekModel.self, from: data)
                var temp: [Int] = []
                for item in result.list!{
                    temp.append(Int(item.main?.temp ?? 0))
                }
                completion(temp)
            }catch{
                print(error)
                completion([])
            }
        }.resume()
    }
}
