//
//  DetailItem.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Cocoa
import Extensions

final class DetailItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("DetailItemIdentifier")
    
    private struct Drawing {
        static let titleFontSize: CGFloat = 16
        static let offset: CGFloat = 10
    }
    
    //MARK: - Private properties
    private let titleText: NSTextField = .custom(
        font: .labelFont(ofSize: Drawing.titleFontSize),
        alignment: .center,
        numberOfLines: 1
    )
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleText)
    }
    
    override func viewWillLayout() {
        setConstraints()
        super.viewWillLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //MARK: - Public methods
    func configure(with title: String) {
        titleText.stringValue = title
    }
}

private extension DetailItem {
    //MARK: - Private methods
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Drawing.offset),
            titleText.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Drawing.offset),
            titleText.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: Drawing.offset),
            titleText.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Drawing.offset)
        ])
    }
}
