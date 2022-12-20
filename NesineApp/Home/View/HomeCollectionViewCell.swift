//
//  HomeCollectionViewCell.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import Foundation
import UIKit
import AlamofireImage

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    var blankImg: NSData? = nil
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        self.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            photoImageView.widthAnchor.constraint(equalToConstant: 160),
            photoImageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}

