//
//  NSImageView+.swift
//
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import AppKit

public extension NSImageView {
    func load(from url: URL?) {
        DispatchQueue.global().async { [weak self] in
            guard
                let url = url,
                let data = try? Data(contentsOf: url),
                let image = NSImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
