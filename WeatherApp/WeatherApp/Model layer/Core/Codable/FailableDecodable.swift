//
//  FailableDecodable.swift
//  UseVerb
//
//  Created by AndreyBuksha on 03.12.2019.
//  Copyright © 2019 Use-Verb. All rights reserved.
//

import Foundation

struct FailableDecodable<Base: APIResponse>: APIResponse {

    let base: Base?

    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }

}
