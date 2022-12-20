//
//  HomeViewModel.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import Foundation

class HomeViewModel: NSObject {
    weak var delegate: ViewControllerDelegate?
    
    var responseData: ItunesSearchApiModel?
    var resultData: [Result]?
    var imageUrl: [String]?
    
    func fetchData(query: String) {
        guard let delegate = delegate else { return }
        
        NetworkService.shared.getData(query: query) { response in
            if response != nil {
                if response?.resultCount != 0 {
                    self.responseData = response
                    guard let data = response?.results else { return }
                    //print(data)
                    self.resultData = data
                    for item in data {
                        self.imageUrl = item.screenshotUrls
                        print(self.imageUrl)
                    }
                    delegate.updateUI()
                } else {
                    delegate.showNoDataView()
                }
            }
        }
    }
    
    func getImageUrlValues() -> [String] {
        guard let url = imageUrl else { return [] }
        return url
    }
    
    func getImage(url: String) async -> Data? {
        guard let imageUrl = URL(string: url) else { return nil }
        let request = URLRequest(url: imageUrl)
        let (data, _) = try! await URLSession.shared.data(for: request, delegate: nil)
        return data
        /*
        //DispatchQueue.global().async {
            var data: Data?
            do {
                data = try Data(contentsOf: imageUrl)
            } catch {
                print("Fail: \(error)")
            }
            return data*/
        //}
    }
}
