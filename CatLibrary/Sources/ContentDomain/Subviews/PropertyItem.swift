//
//  PropertyItem.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Extensions

final class PropertyItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("PropertyItemIdentifier")
    
    private struct Drawing {
        static let titleFontSize: CGFloat = 18
        static let ratingFontSize: CGFloat = 20
        static let offset: CGFloat = 10
    }
    
    //MARK: - Private properties
    private let titleText: NSTextField = .custom(
        font: .labelFont(ofSize: Drawing.titleFontSize),
        alignment: .left,
        numberOfLines: 1
    )
    private let ratingText: NSTextField = .custom(
        font: .boldSystemFont(ofSize: Drawing.ratingFontSize),
        alignment: .right,
        numberOfLines: 1
    )
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(
            titleText,
            ratingText
        )
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        
        setConstraints()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        configure(with: .sample)
    }
    
    //MARK: - Public methods
    func configure(with property: Property) {
        titleText.stringValue = property.title.appending(":")
        ratingText.integerValue = property.level
    }
    
}

private extension PropertyItem {
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // titleText
            titleText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Drawing.offset),
            titleText.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Drawing.offset),
            titleText.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Drawing.offset),
            titleText.rightAnchor.constraint(equalTo: ratingText.leftAnchor),
            // ratingText
            ratingText.leftAnchor.constraint(equalTo: titleText.rightAnchor),
            ratingText.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: Drawing.offset),
            ratingText.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: Drawing.offset),
            ratingText.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Drawing.offset)
        ])
    }
}

import SwiftUI
#Preview {
    PropertyItem()
}
