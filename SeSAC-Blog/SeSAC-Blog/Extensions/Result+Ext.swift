//
//  Result+Ext.swift
//  SeSAC-Blog
//
//  Created by sookim on 2022/01/16.
//

import Foundation

extension Result where Success == Void {
    public static func success() -> Self { .success(()) }
}
