//
//  GMParseToGTFS.swift
//  BayPass
//
//  Created by Tim Roesner on 5/3/19.
//  Copyright © 2019 Tim Roesner. All rights reserved.
//

import Foundation

struct Parse {
    let BARTGoogleToGTFS = [
        "12th Street / Oakland City Center": "12th St. Oakland City Center",
        "16th St Mission BART": "16th St. Mission",
        "19th St / Oakland": "19th St. Oakland",
        "24th St Mission": "24th St. Mission",
        "Antioch BART": "Antioch",
        "Ashby Station": "Ashby",
        "Balboa Park Station": "Balboa Park",
        //"Bay Fair",
        //"Castro Valley",
        "Civic Center": "Civic Center/UN Plaza",
        "Coliseum Station": "Coliseum",
        "Colma Station": "Colma",
        "Concord Station": "Concord",
        "Daly City Station": "Daly City",
        "Downtown Berkeley Station": "Downtown Berkeley",
        //"Dublin/Pleasanton",
        //"El Cerrito del Norte",
        //"El Cerrito Plaza",
        //"Embarcadero",
        //"Fremont",
        "Fruitvale Station": "Fruitvale",
        "Glen Park Station": "Glen Park",
        //"Hayward",
        //"Lafayette",
        "Lake Merritt Station": "Lake Merritt",
        "MacArthur Station": "MacArthur",
        //"Millbrae",
        "Montgomery": "Montgomery St.",
        "North Berkeley Station": "North Berkeley",
        "North Concord/Martinez Station": "North Concord/Martinez",
        //"Oakland International Airport",
        //"Orinda",
        "Pittsburg / Bay Point": "Pittsburg/Bay Point",
        //"Pittsburg Center",
        //"Pleasant Hill/Contra Costa Centre",
        "Powell Street Station": "Powell St.",
        "Richmond Station": "Richmond",
        "Rockridge Station": "Rockridge",
        //"San Bruno",
        "San Francisco International Airport Station": "San Francisco International Airport",
        "San Leandro Station": "San Leandro",
        "South Hayward BART Station": "South Hayward",
        //"South San Francisco",
        "Union City Station": "Union City",
        "Walnut Creek Station": "Walnut Creek",
        //"Warm Springs/South Fremont",
        //"West Dublin/Pleasanton",
        "West Oakland Station": "West Oakland"
    ]
    
    let CalTrainGoogleToGTFS = [
        "San Francisco Station": "San Francisco",
        "22nd St. Station": "22nd Street",
        // "Bayshore",
        "South San Francisco Station": "South San Francisco",
        "San Bruno Station": "San Bruno",
        "Millbrae": "Millbrae Transit Center",
        "Broadway Station": "Broadway", // Weekend only
        "Burlingame Station": "Burlingame",
        "San Mateo Station": "San Mateo",
        // "Hayward Park",
        "Hillsdale Caltrain Station": "Hillsdale",
        "Belmont Station": "Belmont",
        // "San Carlos",
        // "Redwood City",
        "Atheron Station": "Atherton", //Weekend only
        // "Menlo Park",
        "Palo Alto Station": "Palo Alto",
        //"": "Stanford", Football only
        "California Avenue Train Station": "California Ave.",
        "San Antonio Station": "San Antonio",
        "Mountain View Station - Caltrain Platform": "Mountain View",
        "Sunnyvale Station": "Sunnyvale",
        "Lawrence Station": "Lawrence",
        "Santa Clara Station": "Santa Clara",
        // "College Park",
        "San José Diridon Station": "San Jose Diridon",
        "Tamien Caltrain": "Tamien",
        "Capitol Station": "Capitol",
        // "Blossom Hill", Commute hours only
        "Morgan Hill Caltrain": "Morgan Hill",
        // "San Martin", Commute hours only
        "Gilroy Station": "Gilroy",
    ]
}
