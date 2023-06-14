//
//  SettingsViewModel.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class SettingsViewModel: SettingsViewModelProtocol {
 
    let appService = AppService()
    let authViewModel = AuthenticationViewModel()
    
    func clearData() {
        appService.deleteAllPhotos()
    }
    
    func logOut() {
        authViewModel.logOut()
        appService.logOut()
    }
}
