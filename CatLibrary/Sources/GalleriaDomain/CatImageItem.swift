//
//  CatImageItem.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Models
import Extensions

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
    
    //MARK: - Public methods
    public func configure(with breed: BreedImage) {
        breedImage.load(from: URL(string: breed.url))
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
