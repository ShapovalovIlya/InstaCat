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
        numberOfLines: 1
    )
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(linkText)
        linkText.isSelectable = false
        
    }
    
    override func viewWillLayout() {
        setConstraints()
        super.viewWillLayout()
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
        NSLayoutConstraint.activate([
            linkText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linkText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
