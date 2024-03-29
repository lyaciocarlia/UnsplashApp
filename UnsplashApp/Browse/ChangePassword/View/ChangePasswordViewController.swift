//
//  ChangePasswordViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class ChangePasswordViewController: UIViewController, ChangePasswordViewProtocol {

    var viewModel: ChangePasswordViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol
    
    init(viewModel: ChangePasswordViewModelProtocol, coordinator: BrowseCoordinatorProtocol) {
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
