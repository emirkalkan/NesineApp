//
//  HomeCollectionViewCell.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import Foundation
import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    /*lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Deneme"
        label.font = UIFont(name: "PingFangSC-Semibold",size: 20)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = false
        label.textColor = UIColor.black
        return label
    }()*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    /*override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }*/
    
    private func setupViews() {
        self.addSubview(productImageView)
        //self.addSubview(productNameLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            productImageView.widthAnchor.constraint(equalToConstant: 160),
            productImageView.heightAnchor.constraint(equalToConstant: 160),
            
            /*productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            productNameLabel.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor),
            productNameLabel.widthAnchor.constraint(equalToConstant: 160),
            productNameLabel.heightAnchor.constraint(equalToConstant: 50)*/
        ])
    }
    
    func setData() {
        
    }
}

