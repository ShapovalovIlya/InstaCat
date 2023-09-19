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
        
    }
    
    //MARK: - Private properties
    
    
    //MARK: - Life cycle
    override func loadView() {
        view = NSView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    //MARK: - Public methods
}

import SwiftUI
#Preview {
    LinkItem()
}
