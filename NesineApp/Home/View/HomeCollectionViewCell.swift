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
        //self.addSubview(productNameLabel)
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            photoImageView.widthAnchor.constraint(equalToConstant: 160),
            photoImageView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    func setData(item: String) {
        photoImageView.af.setImage(withURL: (URL(string: item) ?? URL(string: ""))!)
        /*let img: UIImage? = photoImageView.image
        let imgData: NSData = UIImageJPEGRepresentation(img, 0)*/
        //print("Size of Image: \(imgData.length) bytes")
        guard let photo = photoImageView.image else { return }
        let imgData = NSData(data: photo.jpegData(compressionQuality: 1)!)
        var imageSize: Int = imgData.count
        print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
    }
}

