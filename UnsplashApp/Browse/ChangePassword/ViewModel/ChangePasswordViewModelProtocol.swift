//
//  ChangePasswordViewModelProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation

protocol ChangePasswordViewModelProtocol {
    var isValidOldPassord: Observable<Bool> { get }
    var isValidNewPassword: Observable<Bool> { get }
    var isPasswordEquals: Observable<Bool> { get }
    var isButtonEnabled: Observable<Bool> { get }
    var isErrorMessageHiden: Observable<Bool> { get }
    var isPasswordChanged: Observable<Bool> { get }

    func buttonWasTapped(newPassword: String)
    func validateOldPassword (_ password: String)
    func validateNewPassword (_ passsword: String)
    func comparePasswords(target first: String, with second: String)
}
