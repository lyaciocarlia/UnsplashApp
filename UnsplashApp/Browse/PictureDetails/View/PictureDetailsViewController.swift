//
//  PictureDetailsViewController.swift
//  UnsplashApp
//
//  Created by Iuliana Stecalovici  on 25.05.2023.
//

import UIKit
import SDWebImage
class PictureDetailsViewController: UIViewController, PictureDetailsViewProtocol {
    
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var likesButton: UIButton!
    
    var viewModel: PictureDetailsViewModelProtocol
    var coordinator: BrowseCoordinatorProtocol
    lazy var image = imageView.image ?? UIImage()
    var imageURL = URL(string: " ")
    var isTapped = false
    var isAdded = false
    var id = " "
    var license = " "
    var date = " "
    var location = " "
    var controller = " "
    
    var coreDataPhoto: CoreDataPhoto? {
        didSet {
            let photoUrl = coreDataPhoto?.imageURL
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            self.imageURL  = url
            self.id = coreDataPhoto?.id ?? " "
            self.license = coreDataPhoto?.license ?? " "
            self.date = coreDataPhoto?.date ?? " "
            self.location = coreDataPhoto?.location ?? " "
            self.controller = Screen.likesScr
        }
    }
    
    var unsplashPhoto: UnsplashPhoto? {
        didSet {
            let photoUrl = unsplashPhoto?.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            self.imageURL  = url
            self.id = unsplashPhoto?.id ?? " "
            self.license = unsplashPhoto?.license ?? " "
            self.date = unsplashPhoto?.createdAt ?? " "
            self.location = unsplashPhoto?.user.location ?? " "
            self.controller = Screen.browseScr
        }
    }
    
    init(viewModel: PictureDetailsViewModelProtocol, coordinator: BrowseCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func goToBrowseScreen(_ sender: Any) {
        coordinator.goBackToBrowseScreen(controller: controller)
    }
    
    @IBAction func like(_ sender: Any) {
        likesButtonTapped()
    }
    
    private func bind() {
        viewModel.isAdded.bind { [weak self] isAdded in
            self?.isAdded = isAdded
            isAdded ? self?.likesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : self?.likesButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}

// MARK: - LIFE CYCLE
extension PictureDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
        checkIfIsLiked()
        imageView.sd_setImage(with: imageURL, completed: nil)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfIsLiked()
    }
}

// MARK: - TAP GESTURE FUNC

extension PictureDetailsViewController {
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        
        let heartImageView = UIImageView(image: UIImage(systemName: Images.heartFill))
        heartImageView.tintColor = .white
        
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(heartImageView)
        
        heartImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heartImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heartImageView.widthAnchor.constraint(equalToConstant: Constants.heartImageWidth).isActive = true
        heartImageView.heightAnchor.constraint(equalToConstant: Constants.heartImageHeight).isActive = true
        
        UIView.animate(withDuration: Constants.gradientAnimationDuration, animations: {
            heartImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            heartImageView.alpha = 0.0
        }) { _ in
            heartImageView.removeFromSuperview()
        }
        
        likesButtonTapped()
    }
    
    func likesButtonTapped() {
        if isAdded {
            deletePhoto()
            viewModel.getThePhotos()
        } else {
            savePhoto()
            viewModel.getThePhotos()
        }
    }
    
    func checkIfIsLiked() {
        let isLiked = viewModel.isLikedOrNot(with: id)
        viewModel.setState(state: isLiked)
    }
    
    func savePhoto() {
        let photo = CoreDataPhoto(imageURL: imageURL?.absoluteString ?? " ", id: unsplashPhoto?.id ?? " ", location: unsplashPhoto?.user.location, date: unsplashPhoto?.createdAt  ?? " ", license: unsplashPhoto?.license)
        viewModel.addPhoto(photo: photo)
    }
    
    func deletePhoto() {
        viewModel.deletePhoto(with: id)
    }
    
    func convertDate(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func addTapGesture() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = Constants.twoTaps
        imageView.addGestureRecognizer(doubleTapGesture)
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        tapGesture.require(toFail: doubleTapGesture)
    }
    
    @objc func imageTapped() {
        if isTapped {
            licenseLabel.text = license
            dateLabel.text = convertDate(date: date)
            placeLabel.text = location
            image = imageView.image ?? UIImage()
            UIView.transition(with: imageView, duration: Constants.gradientAnimationDuration, options: .transitionCrossDissolve, animations: {
                self.imageView.image = self.applyGradientToImage(image: self.imageView.image ?? UIImage())
                self.bottomView.backgroundColor = .black
                self.showLabels(state: true)
            }, completion: nil)
        } else {
            UIView.transition(with: imageView, duration: Constants.gradientAnimationDuration, options: .transitionCrossDissolve, animations: {
                self.imageView.image = self.image
                self.bottomView.backgroundColor = .white
                self.showLabels(state: false)
            }, completion: nil)
        }
        isTapped.toggle()
    }
    
    private func showLabels(state: Bool) {
        licenseLabel.isHidden = !state
        placeLabel.isHidden = !state
        dateLabel.isHidden = !state
    }
    
    private func applyGradientToImage(image: UIImage) -> UIImage? {
        let imageSize = imageView.image?.size ?? CGSize()
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        image.draw(at: .zero)
        
        let colors = GradientColors.blackToClear
        
        let locations: [CGFloat] = [0, 1]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locations) else {
            UIGraphicsEndImageContext()
            return nil
        }
        
        let startPoint = CGPoint(x: imageSize.width / Constants.devideByTwo, y: Constants.gradientY)
        let endPoint = CGPoint(x: imageSize.width / Constants.devideByTwo, y: imageSize.height)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return gradientImage
    }
}
