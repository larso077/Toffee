//
//  Locations.swift
//  KPToffee
//
//  Created by UWP_MU-gfkzby on 8/14/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation


public class Locations {

    static var locations = [
            RetailLocation(name: "Apple Holler", address: "5006 S Sylvania Ave", city: "Sturtevant", state: "WI", zipcode: 53177),
            RetailLocation(name: "Sendiks", address: "701 Meadowbrook Rd", city: "Waukesha", state: "WI", zipcode: 53188),
            RetailLocation(name: "Sweet Grass Gift Shop", address: "1721 W Canal St", city: "Milwaukee", state:"WI", zipcode: 53233),
            RetailLocation(name: "Tenuta", address: "3203 52nd St", city: "Kenosha", state: "WI", zipcode: 53144),
            RetailLocation(name: "The Fresh Market", address: "8705 N Port Washington Rd", city: "Fox Point", state: "Wi", zipcode: 53217),
            RetailLocation(name: "Von Stiehl Winery", address: "115 Navarino St", city: "Algoma", state: "WI", zipcode: 54201),
            RetailLocation(name: "Danny's Meats", address: "1317 4 mile Rd", city: "Racine", state: "WI", zipcode: 53403),
            RetailLocation(name: "Lodi Meats", address: "150 S Main St", city: "Lodi", state: "WI", zipcode: 53555),
            RetailLocation(name: "The Bottle Shop", address: "617 W Main St", city: "Lake Geneva", state: "WI", zipcode: 53147),
            RetailLocation(name: "Winkies Hallmark", address: "629 E Silver Spring Dr", city: "Whitefish Bay", state: "WI", zipcode: 53217),
            RetailLocation(name: "Whole Foods", address: "3133 University Ave", city: "Madison", state: "WI", zipcode: 53705),
            RetailLocation(name: "Von Maur", address: "20111 N Lord St", city: "Brookfield", state: "WI", zipcode: 43045),
            RetailLocation(name: "Woodlake Market", address: "795 Woodlake Rd # A", city: "Kohler", state: "WI", zipcode: 53044),
            RetailLocation(name: "Wollersheim Winery", address: "7876 WI-188", city: "Prairie Du Sac", state: "WI", zipcode: 53578),
            RetailLocation(name: "Brookhaven Market", address: "100 Burr Ridge Pkwy", city: "Burr Ridge", state: "IL", zipcode: 60527),
            RetailLocation(name: "The Chocolate Sanctuary", address: "5101 Washington St", city: "Gurnee", state: "IL", zipcode: 60031),
            RetailLocation(name: "The Fresh Market", address: "5808 North West Highway", city: "Crystal Lake", state: "IL", zipcode: 60014),
            RetailLocation(name: "The Fresh Market", address: "718 Commons Dr", city: "Geneva", state: "IL", zipcode: 60134),
            RetailLocation(name: "The Fresh Market", address: "850 N Western Ave", city: "Lake Forest", state: "IL", zipcode: 60045),
            RetailLocation(name:"The Fresh Market", address: "475 Milwaukee", city: "Lincoln", state: "IL", zipcode: 60069),
            RetailLocation(name: "Garden Fresh Market", address: "955,#1, W 75th St", city: "Naperville", state: "IL", zipcode: 60565),
            RetailLocation(name: "Grand Food Center", address: "1613, 341 Hazel Ave", city: "Glencoe", state: "IL", zipcode: 60022),
            RetailLocation(name: "Grand Food Center", address: "2257, 606 Green Bay Rd", city: "Winnetka", state: "IL", zipcode: 60093),
            RetailLocation(name: "International House of wine & Cheese", address: "11302 US-12", city: "Richmond", state: "IL", zipcode: 60071),
            RetailLocation(name: "Nohea Cafe", address: "1312 W Madison St", city: "Chicago", state: "IL", zipcode: 60607),
            RetailLocation(name: "Prisco's Fine Food", address: "1108 Prairie St", city: "Aurora", state: "IL", zipcode: 60506),
            RetailLocation(name: "Schaefer's Wines, Foods and Spirits", address: "9965 Gross Point Rd", city: "Skokie", state: "IL", zipcode: 60076),
            RetailLocation(name: "Union Leauge", address: "65 Jackson Blvd", city: "Chicago", state: "IL", zipcode: 60604),
            RetailLocation(name: "Von Maur", address: "1960 Tower Dr", city: "Glenview", state: "IL", zipcode: 60026),
            RetailLocation(name: "Whole Foods", address: "1550 n Kingsbury St", city: "Chicago", state: "IL", zipcode: 60642),
            RetailLocation(name: "Whole Foods", address: "840 Willow Rd M", city: "Northbrook", state: "IL", zipcode: 60062),
            RetailLocation(name: "Von Maur", address: "727 Veterans Memorial Parkwy", city: "Davenport", state: "IA", zipcode: 52806),
            RetailLocation(name: "Barney's Market", address: "10 N Thompson St", city: "New Buffalo", state: "MI", zipcode: 49117),
            RetailLocation(name: "Folgarellis", address: "424 W Front St", city: "Traverse City", state: "MI", zipcode: 49684),
            RetailLocation(name: "Potawatomi Resort Gift Shop", address: "1721 W Canal St", city: "Milwaukee", state: "WI", zipcode: 53233),
            RetailLocation(name: "Renard's Cheese", address: "248 Connty Rd S", city: "Algoma", state: "WI", zipcode: 54201),
            RetailLocation(name: "Sentry Albrecht's", address: "3255 Golf Rd", city: "Delafield", state: "WI", zipcode: 53018),
            RetailLocation(name: "Metcalfe's Market", address: "6700 W State St", city: "Wauwatosa", state: "WI", zipcode: 53213),
            RetailLocation(name: "Metcalfe's Market", address: "726 N Midvale Blvd", city: "Madison", state: "WI", zipcode: 53705),
            RetailLocation(name: "Metcalfe's Market", address: "7455 Mineral Point Rd", city: "Madison", state: "WI", zipcode: 53719),
            RetailLocation(name: "Sendik's", address: "2704, 18985 W Capitol Dr", city: "Brookfield", state: "WI", zipcode: 53045),
            RetailLocation(name: "Sendik's", address: "13425 Watertown Plank Rd", city: "Elm Grove", state: "WI", zipcode: 53122),
            RetailLocation(name: "Sendik's", address: "5200 W Rawson Ave", city: "Franklin", state: "WI", zipcode: 53132),
            RetailLocation(name: "Sendik's", address: "N112W15800 Mequon Rd", city: "Germantown", state: "WI", zipcode: 53022),
            RetailLocation(name: "Sendik's", address: "2195 1st Ave", city: "Grafton", state: "WI", zipcode: 53024),
            RetailLocation(name: "Sendik's", address: "7901 W Layton Ave", city: "Greenfield", state: "WI", zipcode: 53220),
            RetailLocation(name: "Sendik's", address: "10930 N Port Washington Rd", city: "Mequon", state: "WI", zipcode: 53092),
            RetailLocation(name: "Sendik's", address: "3600 S Moorland Rd", city: "New Berlin", state: "WI", zipcode: 53151),
            RetailLocation(name: "Sendik's", address: "280 N 18th Ave", city: "West Bend", state: "WI", zipcode: 53095),
            RetailLocation(name: "Sendik's", address: "20222 Lower Union St", city: "Brookfield", state: "WI", zipcode: 53045),
            RetailLocation(name: "Sendik's", address: "500 E Silver Spring Dr", city: "Milwaukee", state: "WI", zipcode: 53217),
            RetailLocation(name: "Sendik's", address: "8616 W North Ave", city: "Milwaukee", state: "WI", zipcode: 53226),
            RetailLocation(name: "Sendik's", address: "600 Hartbrook Dr", city: "Hartland", state: "WI", zipcode: 53029),
            RetailLocation(name: "Sendik's", address: "824 N 16th St", city: "Milwaukee", state: "WI", zipcode: 53233),
            RetailLocation(name: "Berres Brothers Coffee Roasters Cafe", address: "202 Air Park Drive", city: "Watertown", state: "WI", zipcode: 53094),
            RetailLocation(name: "Creatively Yours", address: "1505 West Mequon Road", city: "Mequon", state: "WI", zipcode: 53092),
            RetailLocation(name: "Fromagination", address: "12 South Carroll Street", city: "Madison", state: "WI", zipcode: 53703),
            RetailLocation(name: "Gooseberries", address: "690 W. State Street", city: "Burlington", state: "WI", zipcode: 53105),
            RetailLocation(name: "The Domes Gift and Plant Shop", address: "524 S. Layton Boulevard", city: "Milwaukee", state: "WI", zipcode: 53215),
            RetailLocation(name: "HyVee", address: "3801 East Washington Avenue", city: "Madison", state: "WI", zipcode: 53704),
            RetailLocation(name: "Hy-Vee", address: "2920 Fitchrona Road", city: "Fitchburg", state: "WI", zipcode: 53719),
            RetailLocation(name: "Crossroads Market", address: "762 Commercial Avenue", city: "Green Lake", state: "WI", zipcode: 54941),
            RetailLocation(name: "Layton Fruit Market", address: "5337, 1838 E Layton Ave", city: "St. Francis", state: "WI", zipcode: 53235),
            RetailLocation(name: "Larry's Market", address: "8737 N Deerwood Dr", city: "Milwaukee", state: "WI", zipcode: 53209),
            RetailLocation(name: "Jacobson Bros", address: "617 N Sherman Ave", city: "Madison", state: "WI", zipcode: 53704),
            RetailLocation(name: "Madison Avenue Wine Shop", address: "25 S Madison Ave", city: "Sturgeon Bay", state: "WI", zipcode: 54235),
            RetailLocation(name: "Main Street Market", address: "7770 WI-42", city: "Egg Harbor", state: "WI", zipcode: 54209),
            RetailLocation(name: "Lautenbach's Orchard Country", address: "9197 WI-42", city: "Fish Creek", state: "WI", zipcode: 54212),
            RetailLocation(name: "Mars Cheese Castle", address: "2800 W Frontage Rd", city: "Kenosha", state: "WI", zipcode: 53144),
            RetailLocation(name: "Orange Tree Imports", address: "1721 Monroe St", city: "Madison", state: "WI", zipcode: 53711),
            RetailLocation(name: "Main Street Country Market", address: "320 S Main St", city: "Walworth", state: "WI", zipcode: 53184),
            RetailLocation(name: "Outpost Natural Foods", address: "7000 W State St", city: "Wauwatosa", state: "WI", zipcode: 53213),
            RetailLocation(name: "Outpost Natural Foods", address: "2826 S Kinnickinnic Ave", city: "Milwaukee", state: "WI", zipcode: 53207),
            RetailLocation(name: "Otto's Liquors", address: "4600 W Brown Deer Rd", city: "Milwaukee", state: "WI", zipcode: 53223),
            RetailLocation(name: "Piggly Wiggly", address: "4011 Durand Ave", city: "Racine", state: "WI", zipcode: 53405),
            RetailLocation(name: "Piggly Wiggly", address: "505 Cottonwood Ave", city: "Hartland", state: "WI", zipcode: 53029),
            RetailLocation(name: "Piggly Wiggly", address: "1300 Brown St", city: "Oconomowoc", state: "WI", zipcode: 53066),
            RetailLocation(name: "Piggly Wiggly", address: "100 E Genva Square", city: "Lake Geneva", state: "WI", zipcode: 53147),
    ]
    
    
//    init(locationWI: [RetailLocation], locationIL: [RetailLocation], locationIA: [RetailLocation], locationMI: [RetailLocation], locationERROR: [RetailLocation]) {
//        self.locationWI = locationWI
//        self.locationIL = locationIL
//        self.locationIA = locationIA
//        self.locationMI = locationMI
//        self.locationERROR = locationERROR
//    }
    func sortLocationsByState() -> Array<Array<RetailLocation>> {
        var locationWI: [RetailLocation] = []
        var locationIL: [RetailLocation] = []
        var locationIA: [RetailLocation] = []
        var locationMI: [RetailLocation] = []
        var locationERROR: [RetailLocation] = []
        for location in Locations.locations {
        switch location.state {
        case "WI":
            locationWI.append(location)
        case "IL":
            locationIL.append(location)
        case "IA":
            locationIA.append(location)
        case "MI":
            locationMI.append(location)
        default:
            locationERROR.append(location)
        }
    }
        let locationsByState = [locationWI, locationIL, locationIA, locationMI]
        return locationsByState
    }
    lazy var locationsByState = sortLocationsByState()
    static var instance = Locations()
}
