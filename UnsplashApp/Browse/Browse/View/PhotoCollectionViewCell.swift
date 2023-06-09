//
//  PhotoCollectionViewCell.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 31.05.2023.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    
    var unsplashPhoto: URL? {
        didSet {
            photoImageView.sd_setImage(with: unsplashPhoto,completed: nil)
        }
    }
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.cellCornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private func setupImageView() {
        addSubview(photoImageView)
        let imageConstraints = [
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        photoImageView.leftAnchor.constraint(equalTo:self.leftAnchor),
        photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        NSLayoutConstraint.activate(imageConstraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
