//
//  HeaderView.swift
//  
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Cocoa
import Extensions

final class HeaderView: NSView, NSCollectionViewElement {
    static let identifier = NSUserInterfaceItemIdentifier("HeaderViewIdentifier")
    
    private struct Drawing {
        static let titleFontSize: CGFloat = 14
    }
    
    private let titleText: NSTextField = .custom(
        font: .messageFont(ofSize: Drawing.titleFontSize),
        alignment: .left,
        numberOfLines: 1
    )
    
    //MARK: - init(_:)
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubview(titleText)
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public method
    func set(title: String) {
        titleText.stringValue = title
    }
}

private extension HeaderView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: topAnchor),
            titleText.leftAnchor.constraint(equalTo: leftAnchor),
            titleText.rightAnchor.constraint(equalTo: rightAnchor),
            titleText.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
