//
//  Double+.swift
//  Wheather App
//
//  Created by Sinan Kulen on 23.02.2022.
//

import Foundation

extension Double
{
    func kelvinToCelcius() -> Double
    {
        let kelvinZeroInCelcius : Double = 273
        return self - kelvinZeroInCelcius
    }

}
