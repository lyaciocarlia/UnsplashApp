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
    
    init(viewModel: BrowseViewModelProtocol, coordinator: BrowseCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func openPictureDetails(_ sender: Any) {
        coordinator.openPictureDetails()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
