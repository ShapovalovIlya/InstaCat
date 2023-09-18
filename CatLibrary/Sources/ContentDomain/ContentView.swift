//
//  ContentView.swift
//  
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Cocoa
import Extensions

protocol ContentViewProtocol: NSView {
    var collection: NSCollectionView { get }
}

final class ContentView: NSView, ContentViewProtocol {
    let collection: NSCollectionView = makeCollection()
    
    
}

private extension ContentView {
    static func makeCollection() -> NSCollectionView {
        let collection = NSCollectionView()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }
}
