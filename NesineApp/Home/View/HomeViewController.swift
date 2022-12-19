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
}

class HomeViewController: UIViewController {
    /*enum PhotoCategories: String {
        case "0-100"
        case "100-250"
        case "250-500"
        case "500"
    }*/
    
    //MARK: Variables & UI
    private var homeViewModel = HomeViewModel()
    private var photoCategories = [0, 100, 250, 500]
    
    private var items = ["black", "black", "black", "black", "black", "black", "black", "black", "black", "black"]
    private var items2 = [".black", ".black", ".black", ".black", ".black", ".black", ".black", ".black", ".black", ".black"]
    
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

    override func viewWillAppear(_ animated: Bool) {
        //homeViewModel.fetchData()
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
}

//MARK: Searchbar
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            //clean arrays
            homeViewModel.imageUrl?.removeAll()
            noDataView.removeFromSuperview()
        } else {
            self.collectionView.reloadData()
            self.homeViewModel.fetchData(query: searchText)
        }
    }
    
}

//MARK: CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.homeViewModel.imageUrl?.count ?? 0
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 2
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        guard let data = homeViewModel.imageUrl else { return cell }
        if indexPath.section == 0 {
            cell.setData(item: data[indexPath.row])
            //cell.photoImageView.backgroundColor = .yellow
        } else if indexPath.section == 1 {
            cell.photoImageView.backgroundColor = .red
            //cell.productImageView.backgroundColor = UIImage(named: items2[indexPath.row])
        } else if indexPath.section == 2 {
            cell.photoImageView.backgroundColor = .black
        } else if indexPath.section == 3 {
           
        } else {
           
        }
        //if indexPath.section
        //cell.productImageView.image = UIImage(named: productImages[indexPath.row])
        //cell.productNameLabel.text = productNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected section: \(indexPath.section), selected row: \(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        var selectedIndex: Int? = 0
        if indexPath.section == 0 {
            selectedIndex = indexPath.row
            
        } else if indexPath.section == 1 {
           
        } else if indexPath.section == 2 {
            
        } else if indexPath.section == 3 {
            
        }

        let vc = DetailViewController(number: selectedIndex!)
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
}

