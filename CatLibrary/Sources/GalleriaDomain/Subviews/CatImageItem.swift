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

public final class CatImageItem: NSCollectionViewItem {
    public static let identifier = NSUserInterfaceItemIdentifier("CatImageItemIdentifier")
    
    //MARK: - Private properties
    private let breedImageView: NSImageView = makeImageView()
    private let placeholderImage: NSImage? = .init(
        systemSymbolName: "paw",
        accessibilityDescription: "placeholder image"
    )
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
        cancellable = ImageCache.shared.image(forUrl: url).throwingPublisher
            .catch { _ in
                self.imageTaskPublisher(for: url)
                    .cache(forUrl: url)
            }
            .replaceError(with: placeholderImage ?? .init())
            .receive(on: DispatchQueue.main)
            .sink { image in
                self.breedImageView.image = image
            }
    }
}

private extension CatImageItem {
    func imageTaskPublisher(for url: URL) -> AnyPublisher<NSImage, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap(NSImage.init(data:))
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
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
