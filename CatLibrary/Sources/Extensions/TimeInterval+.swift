//
//  TimeInterval.swift
//
//
//  Created by Илья Шаповалов on 17.09.2023.
//

import Foundation

public extension TimeInterval {
    static let tenSeconds: TimeInterval = 10
    static let minute: TimeInterval = tenSeconds * 6
    static let hour: TimeInterval = minute * 60
    static let day: TimeInterval = hour * 12
}
