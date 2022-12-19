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
    
    func fetchData() {
        guard let delegate = delegate else { return }
        
        NetworkService.shared.getData { response in
            if response != nil {
                self.responseData = response
                //delegate.updateUI()
            }
        }
    }
}
