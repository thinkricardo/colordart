//
//  Number.swift
//  colordart
//
//  Created by Ricardo Pereira on 13/07/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

func safeguardOddNumber(_ value: Int) -> Int {
    if value % 2 == 0 {
        return value + 1;
    }

    return value;
}
