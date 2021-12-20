//
//  Error.swift
//  beerProject
//
//  Created by sookim on 2021/12/21.
//

import Foundation

enum ProjectError: String, Error {
    case invalidBeername = "This beername created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
