//
//  FarewellError.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/12/02.
//

import Foundation

enum FarewellError: String, Error {
    case notOpenURL = "사이트를 열 수 없습니다."
    case notOpenSideMenu = "사이드메뉴를 열 수 없습니다."
    case dataError = "데이터를 가져올 수 없습니다."
}
