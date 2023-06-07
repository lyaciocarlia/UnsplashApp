//
//  SettingsViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {

    var viewModel: SettingsViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol
    
    init(viewModel: SettingsViewModelProtocol, coordinator: BrowseCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func changePassword(_ sender: Any) {
        coordinator.openChangePasswordScreen()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
