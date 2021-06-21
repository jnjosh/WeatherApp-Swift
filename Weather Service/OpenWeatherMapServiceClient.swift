//
//  OpenWeatherMapServiceClient.swift
//  WeatherApp
//
//  Created by Josh Johnson on 6/15/21.
//

import Foundation


enum WeatherServiceError : Error {
    case unknown
    case invalidURL
    case decodingFailure
}


class OpenWeatherMapServiceClient {
    private enum Endpoint : String {
        case current = "/data/2.5/weather"
        case forecast = "/data/2.5/forecast"
    }

    private let baseURLString = "api.openweathermap.org"
    private let apiKey: String


    init(apiKey: String) {
        self.apiKey = apiKey
    }


    //MARK: - Requests

    private func weatherRequest(forEndpoint endpoint: Endpoint,
                                latitude: Double,
                                longitude: Double,
                                apiKey: String) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURLString
        components.path = endpoint.rawValue
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        guard let url = components.url else {
            throw WeatherServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }


    //MARK: - Endpoints

    func weather(latitude: Double, longitude: Double) async throws -> WeatherReport {
        let request = try weatherRequest(forEndpoint: .current,
                                         latitude: latitude,
                                         longitude: longitude,
                                         apiKey: self.apiKey)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let report = try? JSONDecoder().decode(WeatherReport.self, from: data) else {
            throw WeatherServiceError.decodingFailure
        }
        return report
    }


    func forecast(latitude: Double, longitude: Double) async throws -> [WeatherReport] {
        let request = try weatherRequest(forEndpoint: .forecast,
                                         latitude: latitude,
                                         longitude: longitude,
                                         apiKey: self.apiKey)
        let (data, _) = try await URLSession.shared.data(for: request)
        guard let forecast = try? JSONDecoder().decode(WeatherForecast.self, from: data) else {
            throw WeatherServiceError.decodingFailure
        }
        return forecast.reports
    }
}
