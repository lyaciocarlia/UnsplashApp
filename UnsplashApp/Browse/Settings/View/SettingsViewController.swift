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
   
    @IBAction func deletePersistentData(_ sender: Any) {
        let alertController = UIAlertController(title: title, message: AlertTitle.showDeleteDataConfrimation, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: ButtonsTitle.okButton, style: .default) { _ in
            self.viewModel.clearData()
        }
        
        let cancelActoun = UIAlertAction(title: ButtonsTitle.cancelButton, style: .default) { _ in }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelActoun)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func logOut(_ sender: Any) {
        viewModel.logOut()
        coordinator.goToAuthScreen()
    }
}
