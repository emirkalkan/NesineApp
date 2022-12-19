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
    var url = "https://itunes.apple.com/search?term="
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
    
    func getData(query: String, completion: @escaping (ItunesSearchApiModel?) -> Void) {
        let url = Constants.url+query+Constants.endPoint
        AF.request(url).responseDecodable(of: ItunesSearchApiModel.self) { response in
            guard let data = response.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
    
    /*func getImage(_ url: String, completion: @escaping (UIImage?) -> Void) {
        print(url)
        Alamofire.request(url, method: .get).responseima { response in
            if let data = response.result.value {
                completion(data)
            } else {
                completion(nil)
            }
        }
    }*/
    
}
    
