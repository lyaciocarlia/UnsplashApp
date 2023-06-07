//
//  BrowseViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class BrowseViewController: UIViewController, BrowseViewProtocol {
    
    var viewModel: BrowseViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol
    var photos = [UnsplashPhoto]()
    var nrOfItems = Int()
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: Int(self.view.frame.size.width) - CellConstants.singleWidth, height: CellConstants.singleHeigth)
        return layout
    }()
    
    @IBOutlet weak var singleImageFlowButton: UIButton!
    @IBOutlet weak var doubleImageFlowButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    init(viewModel: BrowseViewModelProtocol, coordinator: BrowseCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - LIFE CYCLE

extension BrowseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        searchBar.delegate = self
        viewModel.photos.bind { [weak self] photos in
            self?.updatePhotos(photos: photos)
            self?.photoCollectionView.reloadData()
        }
    }
}

// MARK: - BUTTON FLOW FUNC

extension BrowseViewController {
    @IBAction func setDoubleFlow() {
        layout.itemSize = CGSize(width: (Int(self.view.frame.size.width) - CellConstants.doubleWidth)/Int(Constants.devideByTwo), height: CellConstants.doubleHeigth)
        doubleImageFlowButton.setImage(UIImage(systemName: Images.squareFill), for: .normal)
        singleImageFlowButton.setImage(UIImage(systemName: Images.square), for: .normal)
    }
    
    @IBAction func setSigleFlow() {
        layout.itemSize = CGSize(width: Int(self.view.frame.size.width) - CellConstants.singleWidth, height: CellConstants.singleHeigth)
        singleImageFlowButton.setImage(UIImage(systemName: Images.squareFill), for: .normal)
        doubleImageFlowButton.setImage(UIImage(systemName: Images.grid), for: .normal)
    }
}

// MARK: - SEARCH BAR FUNC

extension BrowseViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.request(term: searchText)
    }
}

// MARK: - COLLECTION VIEW FUNC

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func updatePhotos(photos: [UnsplashPhoto]) {
        self.photos = photos
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.openPictureDetails()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nrOfItems = viewModel.nrOfPhotos()
        return nrOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    private func setupCollectionView() {
        photoCollectionView.showsVerticalScrollIndicator = false
        photoCollectionView.setCollectionViewLayout(layout, animated: true)
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        viewModel.getThePhotosForStartApp()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomOffset = photoCollectionView.contentSize.height - photoCollectionView.contentOffset.y
        if bottomOffset <= photoCollectionView.bounds.size.height {
            viewModel.loadMorePhotos()
        }
    }
}
