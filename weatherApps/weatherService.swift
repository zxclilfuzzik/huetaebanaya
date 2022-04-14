//
//  weatherService.swift
//  weatherApps
//
//  Created by Hero Fiennes-Tiffin on 14.04.2022.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let API_KEY = "3e6f841c3c88373ef9faa923fae2d637"
    private var completionHandler: ((weatherModel?) -> Void)?
    private var dataTask: URLSessionDataTask?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loaderWeatherData(_ completionHandler: @escaping((weatherModel) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    public func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat={\(coordinates.latitude)}&lon={\(coordinates.longitude)}&appid={\(API_KEY)}&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, respons, error in
            guard error == nil, let data = data else { return }
            
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(weatherModel(response: response))
            }
        }.resume()
    }
}

extension weatherModel: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocation locations: [CLLocation]
    ) {
        guard location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
}


struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
