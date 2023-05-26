//
//  PictureDetailsViewProtocol.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import Foundation
import UIKit

protocol PictureDetailsViewProtocol: UIViewController {
    var viewModel: PictureDetailsViewModelProtocol? { get set }
    var coordinator: BrowseCoordinatorProtocol? { get set }
}
