//
//  LinkItem.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Extensions

final class LinkItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("LinkItemIdentifier")
    
    private struct Drawing {
        static let titleFontSize: CGFloat = 16
        static let offset: CGFloat = 10
    }
    
    //MARK: - Private properties
    private let linkText: NSTextField = .custom(
        font: .labelFont(ofSize: Drawing.titleFontSize),
        alignment: .center,
        numberOfLines: 1,
        isBezeled: true
    )
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(linkText)
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
    func configure(with link: Link) {
        let attributedTitle = NSMutableAttributedString(string: link.title)
        attributedTitle.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedTitle.length)
        )
        linkText.attributedStringValue = attributedTitle
    }
}

private extension LinkItem {
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            linkText.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: Drawing.offset),
            linkText.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: -Drawing.offset),
            linkText.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -Drawing.offset),
            linkText.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: Drawing.offset)
        ])
    }
}

import SwiftUI
#Preview {
    LinkItem()
}
