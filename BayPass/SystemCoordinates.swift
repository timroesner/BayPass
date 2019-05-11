//
//  SystemCoordinates.swift
//  BayPass
//
//  Created by Ayesha Khan on 4/11/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation
import MapKit

extension System {
    func getAllCoordinates() -> [Coordinates] {
        var coordinates = [Coordinates]()

        // South Bay
        let downtownSJ = Coordinates(latitude: 37.338475, longitude: -121.885794, radius: 1000, max: 50)
        let conventionCenter = Coordinates(latitude: 37.330074, longitude: -121.889635, radius: 1000, max: 50)
        let sjsuDorms = Coordinates(latitude: 37.334797, longitude: -121.875908, radius: 1000, max: 50)
        let alameda = Coordinates(latitude: 37.331902, longitude: -121.905742, radius: 1000, max: 50)
        let countyLibrary = Coordinates(latitude: 37.341810, longitude: -121.894284, radius: 1000, max: 50)
        let riverOaks = Coordinates(latitude: 37.404865, longitude: -121.941755, radius: 2000, max: 50)
        let airport = Coordinates(latitude: 37.365069, longitude: -121.917321, radius: 1000, max: 50)
        let campbell = Coordinates(latitude: 37.285945, longitude: -121.943840, radius: 2000, max: 50)
        let valleyFair = Coordinates(latitude: 37.323403, longitude: -121.948498, radius: 2000, max: 50)
        let bascom = Coordinates(latitude: 37.299638, longitude: -121.929645, radius: 2000, max: 50)
        let levis = Coordinates(latitude: 37.404399, longitude: -121.971249, radius: 2000, max: 50)
        coordinates.append(contentsOf: [downtownSJ, conventionCenter, sjsuDorms, alameda, countyLibrary, riverOaks, airport, campbell, valleyFair, bascom, levis])
        
        // SF
        let pier39 = Coordinates(latitude: 37.808389, longitude: -122.409947, radius: 1000, max: 50)
        let fishermensWharft = Coordinates(latitude: 37.807779, longitude: -122.419469, radius: 1000, max: 50)
        let chestnut = Coordinates(latitude: 37.800403, longitude: -122.439565, radius: 1000, max: 50)
        let goldenGate = Coordinates(latitude: 37.807631, longitude: -122.474727, radius: 1000, max: 50)
        let unionSquare = Coordinates(latitude: 37.787910, longitude: -122.408367, radius: 1000, max: 50)
        let salesforce = Coordinates(latitude: 37.788894, longitude: -122.396536, radius: 1000, max: 50)
        let attPark = Coordinates(latitude: 37.779192, longitude: -122.390248, radius: 1000, max: 50)
        let chaseCenter = Coordinates(latitude: 37.768680, longitude: -122.389246, radius: 1000, max: 50)
        coordinates.append(contentsOf: [pier39, fishermensWharft, chestnut, goldenGate, unionSquare, salesforce, attPark, chaseCenter])
        
        // Caltrain Stations
        let sfStation = Coordinates(latitude: 37.775975, longitude: -122.394335, radius: 2000, max: 50)
        let c22ndStreet = Coordinates(latitude: 37.757000, longitude: -122.391130, radius: 2000, max: 50)
        let bayshore = Coordinates(latitude: 37.707906, longitude: -122.401290, radius: 2000, max: 50)
        let southSF = Coordinates(latitude: 37.655393, longitude: -122.403899, radius: 2000, max: 50)
        let sanBruno = Coordinates(latitude: 37.629761, longitude: -122.411647, radius: 2000, max: 50)
        let milbrea = Coordinates(latitude: 37.600730, longitude: -122.387134, radius: 2000, max: 50)
        let broadway = Coordinates(latitude: 37.587253, longitude: -122.362625, radius: 2000, max: 50)
        let burlingame = Coordinates(latitude: 37.580108, longitude: -122.345648, radius: 2000, max: 50)
        let sanMateo = Coordinates(latitude: 37.567756, longitude: -122.323600, radius: 1500, max: 50)
        let redwoodCity = Coordinates(latitude: 37.486097, longitude: -122.231037, radius: 1500, max: 50)
        let paloAlto = Coordinates(latitude: 37.444245, longitude: -122.165308, radius: 1500, max: 50)
        let calAvenue = Coordinates(latitude: 37.429200, longitude: -122.141900, radius: 500, max: 50)
        let mountainView = Coordinates(latitude: 37.400300, longitude: -122.063873, radius: 1500, max: 50)
        let sunnyvale = Coordinates(latitude: 37.378002, longitude: -122.030887, radius: 1000, max: 50)
        let santaClara = Coordinates(latitude: 37.353221, longitude: -121.936990, radius: 1000, max: 50)
        let diridon = Coordinates(latitude: 37.330146, longitude: -121.902067, radius: 1000, max: 50)
        coordinates.append(contentsOf: [sfStation, c22ndStreet, bayshore, southSF, sanBruno, milbrea, broadway, burlingame, sanMateo, redwoodCity, paloAlto, calAvenue, mountainView, sunnyvale, santaClara, diridon])
        
        // Bart Stations
        let westOakland = Coordinates(latitude: 37.804800, longitude: -122.295100, radius: 500, max: 50)
        let warmSprings = Coordinates(latitude: 37.502200, longitude: -121.939300, radius: 500, max: 50)
        let unionCity = Coordinates(latitude: 37.590600, longitude: -122.017400, radius: 500, max: 50)
        let southHayward = Coordinates(latitude: 37.634400, longitude: -122.057200, radius: 500, max: 50)
        let sfo = Coordinates(latitude: 37.616000, longitude: -122.392500, radius: 500, max: 50)
        let rockridge = Coordinates(latitude: 37.844700, longitude: -122.251400, radius: 500, max: 50)
        let pittsburg = Coordinates(latitude: 38.016900, longitude: -121.889100, radius: 500, max: 50)
        let orinda = Coordinates(latitude: 37.878400, longitude: -122.183700, radius: 500, max: 50)
        let northConcord = Coordinates(latitude: 38.003200, longitude: -122.024700, radius: 500, max: 50)
        let macArthur = Coordinates(latitude: 37.829100, longitude: -122.267000, radius: 500, max: 50)
        let lafayette = Coordinates(latitude: 37.893200, longitude: -122.124700, radius: 500, max: 50)
        let fremont = Coordinates(latitude: 37.557500, longitude: -121.976600, radius: 500, max: 50)
        let elCePlaza = Coordinates(latitude: 37.902600, longitude: -122.298900, radius: 500, max: 50)
        let dublin = Coordinates(latitude: 37.701600, longitude: -121.899200, radius: 500, max: 50)
        let montgomery = Coordinates(latitude: 37.789341, longitude: -122.401304, radius: 500, max: 50)
        let b17 = Coordinates(latitude: 37.706200, longitude: -122.468900, radius: 500, max: 50)
        let b18 = Coordinates(latitude: 37.684600, longitude: -122.466300, radius: 500, max: 50)
        let b19 = Coordinates(latitude: 37.781632, longitude: -122.411333, radius: 1000, max: 50)
        let b20 = Coordinates(latitude: 37.696900, longitude: -122.126500, radius: 500, max: 50)
        let b21 = Coordinates(latitude: 37.853000, longitude: -122.270000, radius: 500, max: 50)
        let b22 = Coordinates(latitude: 37.752300, longitude: -122.418500, radius: 500, max: 50)
        let b23 = Coordinates(latitude: 37.765400, longitude: -122.419600, radius: 500, max: 50)
        let b24 = Coordinates(latitude: 37.801493, longitude: -122.275756, radius: 500, max: 50)
        let b25 = Coordinates(latitude: 37.699700, longitude: -121.928200, radius: 500, max: 50)
        let b26 = Coordinates(latitude: 37.905700, longitude: -122.067500, radius: 500, max: 50)
        let b27 = Coordinates(latitude: 37.664200, longitude: -122.444000, radius: 500, max: 50)
        let b28 = Coordinates(latitude: 37.721900, longitude: -122.160800, radius: 500, max: 50)
        let b29 = Coordinates(latitude: 37.637800, longitude: -122.416300, radius: 500, max: 50)
        let b30 = Coordinates(latitude: 37.936800, longitude: -122.354000, radius: 500, max: 50)
        let b31 = Coordinates(latitude: 37.928700, longitude: -122.055700, radius: 500, max: 50)
        let b32 = Coordinates(latitude: 38.018900, longitude: -121.945100, radius: 500, max: 50)
        let b33 = Coordinates(latitude: 37.712800, longitude: -122.212100, radius: 500, max: 50)
        let b34 = Coordinates(latitude: 37.874000, longitude: -122.283400, radius: 500, max: 50)
        let b35 = Coordinates(latitude: 37.600200, longitude: -122.386800, radius: 500, max: 50)
        let b36 = Coordinates(latitude: 37.797000, longitude: -122.265200, radius: 500, max: 50)
        let b37 = Coordinates(latitude: 37.669800, longitude: -122.086900, radius: 500, max: 50)
        let b38 = Coordinates(latitude: 37.774800, longitude: -122.224200, radius: 500, max: 50)
        let b39 = Coordinates(latitude: 37.792050, longitude: -122.398419, radius: 500, max: 50)
        let b40 = Coordinates(latitude: 37.925200, longitude: -122.316900, radius: 500, max: 50)
        let b41 = Coordinates(latitude: 37.870100, longitude: -122.268100, radius: 500, max: 50)
        let b42 = Coordinates(latitude: 37.973700, longitude: -122.029100, radius: 500, max: 50)
        let b43 = Coordinates(latitude: 37.753800, longitude: -122.197000, radius: 500, max: 50)
        let b44 = Coordinates(latitude: 37.690700, longitude: -122.075600, radius: 500, max: 50)
        let b45 = Coordinates(latitude: 37.721600, longitude: -122.447500, radius: 500, max: 50)
        let b46 = Coordinates(latitude: 38.017800, longitude: -121.816200, radius: 500, max: 50)
        let b47 = Coordinates(latitude: 37.808800, longitude: -122.268500, radius: 500, max: 50)
        coordinates.append(contentsOf: [westOakland, warmSprings, unionCity, southHayward, sfo, rockridge, pittsburg, orinda, northConcord, macArthur, lafayette, fremont, elCePlaza, dublin, montgomery, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32, b33, b34, b35, b36, b37, b38, b39, b40, b41, b42, b43, b44, b45, b46, b47])

        return coordinates
    }
}
