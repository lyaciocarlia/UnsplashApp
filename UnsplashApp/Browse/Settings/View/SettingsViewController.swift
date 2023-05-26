//
//  SettingsViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {

    var viewModel: SettingsViewModelProtocol?
    var coordinator: BrowseCoordinatorProtocol?
    
    @IBAction func changePassword(_ sender: Any) {
        coordinator?.openChangePasswordScreen()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
