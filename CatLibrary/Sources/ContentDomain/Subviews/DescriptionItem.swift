//
//  DescriptionItem.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Extensions

final class DescriptionItem: NSCollectionViewItem {
    //MARK: - Public properties
    static let identifier = NSUserInterfaceItemIdentifier("DescriptionItemIdentifier")
    
    //MARK: - Drawing properties
    private struct Drawing {
        static let offset: CGFloat = 10
        static let titleHeight: CGFloat = 60
        static let titleFontSize: CGFloat = 24
        static let descriptionFontSize: CGFloat = 16
        static let temperamentFontSize: CGFloat = 18
    }
    
    //MARK: - Private properties
    private let titleText: NSTextField = .custom(
        font: .boldSystemFont(ofSize: Drawing.titleFontSize),
        alignment: .center,
        numberOfLines: 1
    )
    private let descriptionText: NSTextField = .custom(
        font: .labelFont(ofSize: Drawing.descriptionFontSize),
        isBezeled: true
    )
    private let temperamentText: NSTextField = .custom(
        font: .messageFont(ofSize: Drawing.temperamentFontSize),
        numberOfLines: 1
    )
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
        
        view.addSubviews(
            titleText,
            descriptionText,
            temperamentText
        )
        view.clipsToBounds = true
    }
    
    override func viewWillLayout() {
        setConstraints()
        super.viewWillLayout()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        configure(with: .sample)
    }
    

    //MARK: - Public methods
    func configure(with description: Description) {
        titleText.stringValue = description.name
        descriptionText.stringValue = description.description
        temperamentText.stringValue = description.temperament
    }
}

private extension DescriptionItem {
    //MARK: - Private methods
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // titleText
            titleText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Drawing.offset),
            titleText.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Drawing.offset),
            titleText.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Drawing.offset),
            titleText.heightAnchor.constraint(equalToConstant: Drawing.titleHeight),
            // descriptionText
            descriptionText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Drawing.offset),
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: Drawing.offset),
            descriptionText.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Drawing.offset),
            descriptionText.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.3),
            // temperamentText
            temperamentText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Drawing.offset),
            temperamentText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: Drawing.offset),
            temperamentText.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Drawing.offset),
            temperamentText.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -Drawing.offset)
        ])
    }
}

import SwiftUI
#Preview {
    DescriptionItem()
}
