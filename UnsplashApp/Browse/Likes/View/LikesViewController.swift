//
//  LikesViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class LikesViewController: UIViewController, LikesViewProtocol {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: PictureDetailsViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol
    var photos = [CoreDataPhoto]()
    var nrOfItems = Int()
    
    init(viewModel: PictureDetailsViewModelProtocol, coordinator: BrowseCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.photos.bind { [weak self] photos in
            self?.updatePhotos(photos: photos)
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getThePhotos()
    }
}

// MARK: - COLLECTION VIEW FUNC

extension LikesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func updatePhotos(photos: [CoreDataPhoto]) {
        self.photos = photos
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.openPictureDetails(coreDataPhoto: photos[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nrOfItems = viewModel.numberOfPhotos()
        return nrOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = URL(string: unsplashPhoto.imageURL)
        return cell
    }

    private func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (Int(self.view.frame.size.width) - CellConstants.doubleWidth)/Int(Constants.devideByTwo), height: CellConstants.doubleHeigth)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        viewModel.getThePhotos()
    }
}
