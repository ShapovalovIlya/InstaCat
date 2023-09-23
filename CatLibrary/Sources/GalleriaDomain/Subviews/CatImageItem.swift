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
import Combine
import ImageDownloader

public final class CatImageItem: NSCollectionViewItem {
    public static let identifier = NSUserInterfaceItemIdentifier("CatImageItemIdentifier")
    
    //MARK: - Private properties
    private let breedImageView: NSImageView = makeImageView()
    private var cancellable: AnyCancellable?
    
    //MARK: - Life cycle
    public override func loadView() {
        view = NSView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(breedImageView)
    }
    
    public override func viewWillLayout() {
        setContraints()
        super.viewWillLayout()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        breedImageView.image = nil
        cancellable = nil
    }
    
    //MARK: - Public methods
    public func configure(with breed: BreedImage) {
        guard let url = URL(string: breed.url) else {
            return
        }
        
        cancellable = breedImageView.imageCancellable(
            for: url,
            options: [
                .cacheFor(url),
             //   .resizeTo(breedImageView.bounds.size),
             //   .cornerRadius(20)
            ]) { completion in
            switch completion {
            case .finished:
                print("Finish image loading")
            case let .failure(error):
                print(error)
            }
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
            breedImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            breedImageView.topAnchor.constraint(equalTo: view.topAnchor),
            breedImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            breedImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
