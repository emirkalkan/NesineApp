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
    var imageUrl: [String]?
    
    func fetchData(query: String) {
        guard let delegate = delegate else { return }
        
        NetworkService.shared.getData(query: query) { response in
            if response != nil {
                if response?.resultCount != 0 {
                    self.responseData = response
                    guard let data = response?.results else { return }
                    for item in data {
                        self.imageUrl = item.screenshotUrls
                        print(self.imageUrl?.count)
                        print(self.imageUrl?[0])
                    }
                    delegate.updateUI()
                } else {
                    delegate.showNoDataView()
                }
            }
        }
    }
    
    /*func downloadImage(url: String) {
        guard let delegate = delegate else { return }
        NetworkService.shared.getImage("") { image in
            if image != nil {
                let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
                var imageSize: Int = imgData.count
                print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
                //self.imageData?.append(image)
                delegate.updateUI()
            }
        }
    }*/
}
