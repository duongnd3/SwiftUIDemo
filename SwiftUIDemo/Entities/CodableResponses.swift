//
//  CodableResponses.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation

struct NDRootResponse<T: Codable>: Codable {
    let data: NDDataResponse<T>
    let code: Int
    let status: Bool
    let message: String
}

struct NDDataResponse<T: Codable>: Codable {
    let results: [T]
    let total: Int
    let count: Int
}

