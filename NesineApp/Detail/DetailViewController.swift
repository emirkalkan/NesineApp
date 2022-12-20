//
//  DetailViewController.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var number: Int!
    var image: UIImage!
    
    private lazy var backButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    convenience init(number: Int, image: UIImage) {
        self.init()
        self.number = number
        self.selectedImageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(backButton)
        self.view.addSubview(selectedImageView)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        selectedImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        selectedImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        selectedImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        selectedImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
