//
//  NetworkServivce.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    //ios user input
    var url = "https://itunes.apple.com/search?term=ios"
    var endPoint = "&media=software"
    
    func returnUrl() -> String {
        return url + endPoint
    }
    
    func apiRequest(url: String, endPoint: String, completion: @escaping (ItunesSearchApiModel?) -> ()) {
        let totalUrl = url + endPoint
        let url = URL(string: totalUrl)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                
            } else if let data = data {
                var dataList: ItunesSearchApiModel?
                
                do{
                    dataList = try JSONDecoder().decode(ItunesSearchApiModel.self, from: data)
                    if let dataList = dataList {
                        completion(dataList)
                    }
                } catch {
                    print("Error! \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func getData(completion: @escaping (ItunesSearchApiModel?) -> Void) {
        AF.request(returnUrl()).responseDecodable(of: ItunesSearchApiModel.self) { response in
            guard let data = response.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
    
