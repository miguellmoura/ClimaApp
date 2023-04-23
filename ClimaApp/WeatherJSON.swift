//
//  WeatherJSON.swift
//  ClimaApp
//
//  Created by Aluno on 24/10/22.
//

import Foundation

struct Main: Decodable {
    var main = ["temp": 0.0, "temp_max": 0.0, "temp_min": 0.0]
    let name: String
}
