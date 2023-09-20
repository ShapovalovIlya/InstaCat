//
//  CatImageItem.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Models
import Extensions
import Dependencies

public final class CatImageItem: NSCollectionViewItem {
    public static let identifier = NSUserInterfaceItemIdentifier("CatImageItemIdentifier")
    
    //MARK: - Private properties
    private let breedImage: NSImageView = makeImageView()
    
    //MARK: - Life cycle
    public override func loadView() {
        view = NSView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(breedImage)
    }
    
    public override func viewWillLayout() {
        setContraints()
        super.viewWillLayout()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        breedImage.image = nil
    }
    
    //MARK: - Public methods
    public func configure(with breed: BreedImage) {
        guard let url = URL(string: breed.url) else {
            return
        }
        if let image = ImageCache.shared.image(forUrl: url) {
            breedImage.image = image
        } else {
            breedImage.load(from: url) { ImageCache.shared.setImage($0, forUrl: url) }
        }
    }
}

private extension CatImageItem {
    static func makeImageView() -> NSImageView {
        let imageView = NSImageView()
        imageView.imageAlignment = .alignCenter
        imageView.isEditable = false
        imageView.animates = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func setContraints() {
        NSLayoutConstraint.activate([
            breedImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            breedImage.topAnchor.constraint(equalTo: view.topAnchor),
            breedImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            breedImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
