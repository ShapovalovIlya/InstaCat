//
//  BreedItem.swift
//  
//
//  Created by Илья Шаповалов on 12.09.2023.
//

import Cocoa

final class BreedItem: NSCollectionViewItem {
    static let identifier = NSUserInterfaceItemIdentifier("BreedItemIdentifier")
    
    private let label: NSTextField = makeLabel()
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            
            switch isSelected {
            case true:
                view.layer?.backgroundColor = NSColor.selectedControlColor.cgColor
            case false:
                view.layer?.backgroundColor = NSColor.clear.cgColor
            }
        }
    }
    
    //MARK: - Live cycle
    override func loadView() {
        view = NSView()
        view.wantsLayer = true
        view.addSubview(label)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    //MARK: - Public methods
    func setText(_ text: String) {
        label.stringValue = text
    }
    
}

private extension BreedItem {
    //MARK: - Private methods
    func setConstraints() {
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: view.leftAnchor),
            label.rightAnchor.constraint(equalTo: view.rightAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    static func makeLabel() -> NSTextField {
        let label = NSTextField()
        label.alignment = .center
        label.isEditable = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
