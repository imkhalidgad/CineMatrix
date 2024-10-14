//
//  String+trimm.swift
//  BM Task 1
//
//  Created by Apple on 20/07/2024.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
