//
//  NSSplitViewController.swift
//  
//
//  Created by Илья Шаповалов on 11.09.2023.
//

import AppKit

public extension NSSplitViewController {
    convenience init(
        sideBarController: NSViewController,
        contentController: NSViewController
    ) {
        self.init(nibName: nil, bundle: nil)
        
        let sideBarSplitItem = NSSplitViewItem(sidebarWithViewController: sideBarController)
        let contentSplitItem = NSSplitViewItem(viewController: contentController)
        
        self.addSplitViewItem(sideBarSplitItem)
        self.addSplitViewItem(contentSplitItem)
    }
}
