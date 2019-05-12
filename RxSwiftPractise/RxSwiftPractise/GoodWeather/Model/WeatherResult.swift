//
//  WeatherResult.swift
//  RxSwiftPractise
//
//  Created by Maharjan Binish on 2019/05/04.
//  Copyright © 2019 Maharjan Binish. All rights reserved.
//

import Foundation

struct Weather: Decodable {
  let humidity: Double
  let temp: Double
}

struct WeatherResult: Decodable {
  let main: Weather
}

extension WeatherResult {
  static var emptyResult = WeatherResult(main: Weather(humidity: 0.0, temp: 0.0))
}
