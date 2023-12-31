//
//  Link.swift
//
//
//  Created by Илья Шаповалов on 18.09.2023.
//

import Foundation

struct Link: Hashable {
    let title: String
    let link: String
    
    static let sample = Self(
        title: "Wikipedia",
        link: "https://en.wikipedia.org/wiki/Abyssinian_(cat)"
    )
}
