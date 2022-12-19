//
//  DetailViewController.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var number: Int!
    
    private var backButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    convenience init(number: Int) {
        self.init()
        self.number = number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        print(self.number)
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        self.view.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
