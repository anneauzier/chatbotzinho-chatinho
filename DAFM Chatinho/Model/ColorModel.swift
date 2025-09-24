//
//  ColorModel.swift
//  DAFMColorTool
//
//  Created by Igor Vicente on 24/09/25.
//

import FoundationModels
import SwiftUI

@Generable(description: "A basic color palette")
struct ColorPallet {
    @Guide(description: "The pallets's colors", .count(5))
    var colors: [ColorModel]
}

@Generable(description: "Basic information about a color for a color palette generator app")
struct ColorModel: Identifiable {
    
    var id: String { colorName }

    @Guide(description: "The color's name")
    var colorName: String
    
    @Guide(description: "The color's hex value, formate with the prefix # and having 6 digits (e.g. #000000)")
    var hexCode: String
    
    @Guide(description: "The color's RGB value, formate with the prefix RGB: and having 3 values (e.g. RGB: 0, 10, 255)")
    var rgbCode: String
    
    var color: Color {
        let components = rgbCode.split(separator: ",")
        let r = components[0].filter { $0.isNumber }
        let g = components[1].filter { $0.isNumber }
        let b = components[2].filter { $0.isNumber }

        if let red = Double(r), let green = Double(g), let blue = Double(b) {
            print(rgbCode)
            print(red, green, blue)
            return Color(red: red/255.0, green: green/255.0, blue: blue/255.0, opacity: 1.0)
        }

        return .red
    }
}
