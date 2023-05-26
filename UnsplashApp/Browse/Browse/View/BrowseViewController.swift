//
//  BrowseViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class BrowseViewController: UIViewController, BrowseViewProtocol {

    var viewModel: BrowseViewModelProtocol?
    var coordinator: BrowseCoordinatorProtocol?
    
    @IBAction func openPictureDetails(_ sender: Any) {
        coordinator?.openPictureDetails()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
