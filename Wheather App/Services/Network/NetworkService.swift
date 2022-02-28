//
//  NetworkService.swift
//  Wheather App
//
//  Created by Sinan Kulen on 18.02.2022.
//

import Foundation

protocol NetworkServiceProtocol
{
    func get<T:Decodable>(from endPoint: String, completion: @escaping(T?, NetworkError?)->Void)
}

enum NetworkError : Error
{
    case invalidUrl
    case custom(String?)
    case decoding(String?)
    case noData
}

class NetworkService : NetworkServiceProtocol
{
    private let apiKey = ""
    private let baseURL = "http://api.openweathermap.org/data/2.5/"
    
    func get<T:Decodable>(from endPoint: String, completion: @escaping(T?, NetworkError?)->Void)
    {
        guard let url = URL(string: baseURL + endPoint + apiKey) else
        {
            completion(nil, NetworkError.invalidUrl)
            return
        }
        
        createTask(from: url, completion: completion).resume()
    }
    
    private func createTask<T:Decodable>(from url: URL, completion: @escaping (T?, NetworkError?)-> Void) -> URLSessionDataTask
    {
        return URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            guard error == nil else
            {
                completion(nil, NetworkError.custom(error!.localizedDescription))
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            do{
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData, nil)
            }
            catch
            {
                completion(nil, NetworkError.decoding(error.localizedDescription))
            }
        }
    }
}
