//
//  ChangePasswordViewModel.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

class ChangePasswordViewModel: ChangePasswordViewModelProtocol {
    
    var isValidOldPassord: Observable<Bool> = Observable(false)
    var isValidNewPassword: Observable<Bool> = Observable(false)
    var isPasswordEquals: Observable<Bool> = Observable(false)
    var isButtonEnabled: Observable<Bool> = Observable(false)
    var isErrorMessageHiden: Observable<Bool> = Observable(true)
    var isPasswordChanged: Observable<Bool> = Observable(false)
    
    let appService = AppService()
    
    func validateOldPassword (_ password: String) {
        isValidOldPassord.value = password.count > Constants.minimPasswordSize
        changeButtonStatus()
    }
    
    func validateNewPassword (_ password: String) {
        isValidNewPassword.value = password.count > Constants.minimPasswordSize
        changeButtonStatus()
    }
    
    func comparePasswords(target first: String, with second: String) {
        if first == second {
            isPasswordEquals.value = true
            isErrorMessageHiden.value = true
        } else {
            isPasswordEquals.value = false
            isErrorMessageHiden.value = false
        }
        changeButtonStatus()
    }
    
    func buttonWasTapped(newPassword: String) {
        isPasswordChanged.value = appService.updateAccountPassword(newPassword: newPassword)
        print(isPasswordChanged.value)
        
    }
  
    private func changeButtonStatus() {
        isButtonEnabled.value = isValidOldPassord.value && isValidNewPassword.value && isPasswordEquals.value
    }
    
    
}
