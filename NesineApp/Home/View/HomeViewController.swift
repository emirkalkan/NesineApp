//
//  HomeViewController.swift
//  NesineApp
//
//  Created by Emir Kalkan on 19.12.2022.
//

import UIKit

protocol ViewControllerDelegate: NSObject {
    func updateUI()
    func showNoDataView()
    //func findSizeOfImage(image: UIImage)
}

class HomeViewController: UIViewController {
    
    //MARK: Variables & UI
    private var homeViewModel = HomeViewModel()
    private var photoCategories = [0, 100, 250, 500]
    
    private var zeroKbs = [UIImage]()
    private var hundredKbs = [UIImage]()
    private var twoHundredFiftyKbs = [UIImage]()
    private var fiveHundredKbs = [UIImage]()
    
    private var flag = false
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier)
        return collectionView
    }()
    
    private lazy var noDataView: UILabel = {
        let label = UILabel()
        label.text = "No Data."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        homeViewModel.delegate = self
    }
    
    private func setupView() {
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func findSizeOfImage(image: UIImage) -> Double {
        let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
        var imageSize: Int = imgData.count
        print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
        return Double(imageSize) / 1000.0
    }
    
    func classifyImage(image: UIImage, size: Double) {
        if size>0, size<100 {
            self.zeroKbs.append(image)
        } else if size>=100, size<250 {
            self.hundredKbs.append(image)
        } else if size>=250, size<500 {
            self.twoHundredFiftyKbs.append(image)
        } else if size>=500 {
            self.fiveHundredKbs.append(image)
        }
    }
}

//MARK: Searchbar
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.zeroKbs.removeAll()
        self.hundredKbs.removeAll()
        self.twoHundredFiftyKbs.removeAll()
        self.fiveHundredKbs.removeAll()
        if searchText == "" {
            //clean arrays
            self.flag = false
            noDataView.removeFromSuperview()
            updateUI()
        } else {
            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: #selector(self.fetchData(text: )),
                                                       object: nil)
            self.perform(#selector(self.fetchData(text: )), with: searchText, afterDelay: 0.8)
            
        }
    }
    
    func loadImages(item: String) {
        Task {
            if let data = await self.homeViewModel.getImage(url: item) {
                if let imageData = UIImage(data: data) {
                    var size = self.findSizeOfImage(image: imageData)
                    self.classifyImage(image: imageData, size: size)
                }
            }
        }
    }
    
    @objc func fetchData(text: String) {
        print(text)
        self.homeViewModel.fetchData(query: text)
        for item in self.homeViewModel.getImageUrlValues() {
            print(item)
            self.flag = true
            //do {
            self.loadImages(item: item)
            updateUI()
            /*} catch {
                print("error")
            }*/
        }
    }
    
}

//MARK: CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return flag == false ? 0 : photoCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.zeroKbs.count
        } else if section == 1 {
            return self.hundredKbs.count
        } else if section == 2 {
            return self.twoHundredFiftyKbs.count
        } else if section == 3 {
            return self.fiveHundredKbs.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        
        if indexPath.section == 0 {
            cell.photoImageView.image = self.zeroKbs[indexPath.row]
        } else if indexPath.section == 1 {
            cell.photoImageView.image = self.hundredKbs[indexPath.row]
        } else if indexPath.section == 2 {
            cell.photoImageView.image = self.twoHundredFiftyKbs[indexPath.row]
        } else if indexPath.section == 3 {
            cell.photoImageView.image = self.fiveHundredKbs[indexPath.row]
        } else {
           
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected section: \(indexPath.section), selected row: \(indexPath.row)")
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        var selectedIndex: Int? = 0
        var selectedImage: UIImage? = nil
        if indexPath.section == 0 {
            selectedIndex = indexPath.row
            selectedImage = self.zeroKbs[indexPath.row]
        } else if indexPath.section == 1 {
            selectedImage = self.hundredKbs[indexPath.row]
        } else if indexPath.section == 2 {
            selectedImage = self.twoHundredFiftyKbs[indexPath.row]
        } else if indexPath.section == 3 {
            selectedImage = self.fiveHundredKbs[indexPath.row]
        }

        let vc = DetailViewController(number: selectedIndex!, image: selectedImage!)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.2, height: collectionView.frame.height/3+10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeCollectionHeaderView.identifier, for: indexPath) as! HomeCollectionHeaderView
        if indexPath.section == 0 {
            header.headerLabel.text = "0-100 Kb"
        } else if indexPath.section == 1 {
            header.headerLabel.text = "100-250 Kb"
        } else if indexPath.section == 2 {
            header.headerLabel.text = "250-500 Kb"
        } else if indexPath.section == 3 {
            header.headerLabel.text = "500+ Kb"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 50)
    }
}

extension HomeViewController: ViewControllerDelegate {
    func updateUI() {
            self.view.addSubview(self.collectionView)
            collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.collectionView.reloadData()
    }
    
    func showNoDataView() {
        self.collectionView.removeFromSuperview()
        self.view.addSubview(noDataView)
        
        noDataView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noDataView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        noDataView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        noDataView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    /*func findSizeOfImage(image: UIImage) {
        let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
        var imageSize: Int = imgData.count
        print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
    }*/
}

