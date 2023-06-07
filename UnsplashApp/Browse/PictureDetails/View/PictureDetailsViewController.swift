//
//  PictureDetailsViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class PictureDetailsViewController: UIViewController, PictureDetailsViewProtocol {

    var viewModel: PictureDetailsViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol
    
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
    }

}
