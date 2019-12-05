//
//  Array+Extension.swift
//  Example
//
//  Created by Maharjan Binish on 2019/12/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

extension Array {

    /// A `forEach` that performs the next element after calling continuousHandler
    ///
    /// - Parameter body: allows calling the next element
    func forEachAsync(body: @escaping (_ element: Element, _ continuousHandler: @escaping () -> Void) -> Void) {
        var main: ((Int, Int) -> Void)? = nil
        main = { index, count in
            if index >= count {
                return
            }

            body(self[index]) {
                main?(index + 1, count)
            }
        }
        main?(0, count)
    }
}
