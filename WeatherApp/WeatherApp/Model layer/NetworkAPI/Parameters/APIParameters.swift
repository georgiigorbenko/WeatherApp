//
//  APIParameters.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 07.06.2021.
//  Copyright © 2021 Verb. All rights reserved.
//

import Moya

typealias APIParametersEncoding = ParameterEncoding
typealias APIJSONEncoding = JSONEncoding
typealias APIURLEncoding = URLEncoding

protocol APIParameters: Encodable {}
