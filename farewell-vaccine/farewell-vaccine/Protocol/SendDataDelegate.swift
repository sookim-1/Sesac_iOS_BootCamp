//
//  SendDataDelegate.swift
//  farewell-vaccine
//
//  Created by sookim on 2021/11/29.
//

import Foundation

protocol SendDataDelegate {
    func sendData(testResultCount: Int , category: TestCategory)
}

protocol OnboardingPresentMainVC {
    func presentMainVC()
}
