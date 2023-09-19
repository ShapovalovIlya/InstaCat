//
//  TitleItem.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Models
import Kingfisher

final class TitleItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("TitleItemIdentifier")
    
    //MARK: - Private properties
    private let breedImage: NSImageView = makeImageView()
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(breedImage)
    }
    
    override func viewWillLayout() {
        setContraints()
        super.viewWillLayout()
    }
    
//    override func viewWillAppear() {
//        super.viewWillAppear()
//        configure(with: .sample)
//    }
    
    //MARK: - Public methods
    func configure(with breed: BreedImage) {
        let processor: ImageProcessor = DownsamplingImageProcessor(size: breedImage.bounds.size)
                                     |> RoundCornerImageProcessor(cornerRadius: 12)
        breedImage.kf.indicatorType = .activity
        breedImage.kf.setImage(
            with: URL(string: breed.url),
            placeholder: nil,
            options: [
                .processor(processor),
                .transition(.fade(0.3))
            ])
    }
}

private extension TitleItem {
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

//import SwiftUI
//#Preview {
//    TitleItem()
//}
