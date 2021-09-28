//
//  Constants.swift
//  Interective Learning App
//
//  Created by Prefect on 11.09.2021.
//

struct Constants {
    static var currentEnviroment: Environment = .develop
    static var currentFaceName = "gordon"
    static var currentSpecher: SpecherType = .ljspeech
}

enum SpecherType: String, CaseIterable {
    case ljspeech
    case netherlands
}
