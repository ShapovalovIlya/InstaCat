//
//  TitleItem.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Models

final class TitleItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("TitleItemIdentifier")
    
    //MARK: - Private properties
    private let breedImage: NSImageView = makeImageView()
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
        
        view.addSubview(breedImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        setContraints()
    }
    
    //MARK: - Public methods
    func configure(with breed: BreedImage) {
        
    }
}

private extension TitleItem {
    static func makeImageView() -> NSImageView {
        let imageView = NSImageView()
        imageView.imageAlignment = .alignCenter
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
