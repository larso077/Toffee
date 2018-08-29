//
//  Locations.swift
//  KPToffee
//
//  Created by UWP_MU-gfkzby on 8/14/18.
//  Copyright © 2018 Erik Fisch. All rights reserved.
//

import Foundation


public class Locations {

    public static let locations = [
        RetailLocation(name: "Apple Holler", address: "5006 S Sylvania Ave", city: "Sturtevant", state: "WI", zipcode: 53177, lat: 42.6747834, lon: -87.9548212),
        RetailLocation(name: "Sendiks", address: "701 Meadowbrook Rd", city: "Waukesha", state: "WI", zipcode: 53188, lat: 43.0220091, lon: -88.28391099999999),
        RetailLocation(name: "Sweet Grass Gift Shop", address: "1721 W Canal St", city: "Milwaukee", state: "WI", zipcode: 53233, lat: 43.0302135, lon: -87.934859),
        RetailLocation(name: "Tenuta", address: "3203 52nd St", city: "Kenosha", state: "WI", zipcode: 53144, lat: 42.5878674, lon: -87.84845279999999),
        RetailLocation(name: "The Fresh Market", address: "8705 N Port Washington Rd", city: "Fox Point", state: "Wi", zipcode: 53217, lat: 43.1750205, lon: -87.9144075),
        RetailLocation(name: "Von Stiehl Winery", address: "115 Navarino St", city: "Algoma", state: "WI", zipcode: 54201, lat: 44.6094077, lon: -87.43537099999999),
        RetailLocation(name: "Danny's Meats", address: "1317 4 mile Rd", city: "Racine", state: "WI", zipcode: 53403, lat: 42.7842527, lon: -87.7959683),
        RetailLocation(name: "Lodi Meats", address: "150 S Main St", city: "Lodi", state: "WI", zipcode: 53555, lat: 43.3127356, lon: -89.5259679),
        RetailLocation(name: "The Bottle Shop", address: "617 W Main St", city: "Lake Geneva", state: "WI", zipcode: 53147, lat: 42.5919345, lon: -88.4320434),
        RetailLocation(name: "Winkies Hallmark", address: "629 E Silver Spring Dr", city: "Whitefish Bay", state: "WI", zipcode: 53217, lat: 43.1182706, lon: -87.90238219999999),
        RetailLocation(name: "Whole Foods", address: "3133 University Ave", city: "Madison", state: "WI", zipcode: 53705, lat: 43.0749571, lon: -89.442814),
        RetailLocation(name: "Von Maur", address: "20111 N Lord St", city: "Brookfield", state: "WI", zipcode: 43045, lat: 43.0335775, lon: -88.1636202),
        RetailLocation(name: "Woodlake Market", address: "795 Woodlake Rd # A", city: "Kohler", state: "WI", zipcode: 53044, lat: 43.7443453, lon: -87.78179039999999),
        RetailLocation(name: "Wollersheim Winery", address: "7876 WI-188", city: "Prairie Du Sac", state: "WI", zipcode: 53578, lat: 43.28651929999999, lon: -89.7079431),
        RetailLocation(name: "Brookhaven Market", address: "100 Burr Ridge Pkwy", city: "Burr Ridge", state: "IL", zipcode: 60527, lat: 41.7497147, lon: -87.912897),
        RetailLocation(name: "The Chocolate Sanctuary", address: "5101 Washington St", city: "Gurnee", state: "IL", zipcode: 60031, lat: 42.3618945, lon: -87.92850109999999),
        RetailLocation(name: "The Fresh Market", address: "5808 North West Highway", city: "Crystal Lake", state: "IL", zipcode: 60014, lat: 42.22781699999999, lon: -88.31220800000001),
        RetailLocation(name: "The Fresh Market", address: "718 Commons Dr", city: "Geneva", state: "IL", zipcode: 60134, lat: 41.8972954, lon: -88.3435654),
        RetailLocation(name: "The Fresh Market", address: "850 N Western Ave", city: "Lake Forest", state: "IL", zipcode: 60045, lat: 42.2551301, lon: -87.8411258),
        RetailLocation(name: "The Fresh Market", address: "475 Milwaukee", city: "Lincoln", state: "IL", zipcode: 60069, lat: 42.1987751, lon: -87.93113869999999),
        RetailLocation(name: "Garden Fresh Market", address: "955,#1, W 75th St", city: "Naperville", state: "IL", zipcode: 60565, lat: 41.7475353, lon: -88.1672421),
        RetailLocation(name: "Grand Food Center", address: "1613, 341 Hazel Ave", city: "Glencoe", state: "IL", zipcode: 60022, lat: 42.1334788, lon: -87.75830460000002),
        RetailLocation(name: "Grand Food Center", address: "2257, 606 Green Bay Rd", city: "Winnetka", state: "IL", zipcode: 60093, lat: 42.1079903, lon: -87.7358837),
        RetailLocation(name: "International House of wine & Cheese", address: "11302 US-12", city: "Richmond", state: "IL", zipcode: 60071, lat: 42.4901597, lon: -88.30624019999999),
        RetailLocation(name: "Nohea Cafe", address: "1312 W Madison St", city: "Chicago", state: "IL", zipcode: 60607, lat: 41.8817455, lon: -87.6603094),
        RetailLocation(name: "Prisco's Fine Food", address: "1108 Prairie St", city: "Aurora", state: "IL", zipcode: 60506, lat: 41.7519251, lon: -88.3426793),
        RetailLocation(name: "Schaefer's Wines, Foods and Spirits", address: "9965 Gross Point Rd", city: "Skokie", state: "IL", zipcode: 60076, lat: 42.0619654, lon: -87.73069029999999),
        RetailLocation(name: "Union Leauge", address: "65 Jackson Blvd", city: "Chicago", state: "IL", zipcode: 60604, lat: 41.877931, lon: -87.63002469999999),
        RetailLocation(name: "Von Maur", address: "1960 Tower Dr", city: "Glenview", state: "IL", zipcode: 60026, lat: 42.0900951, lon: -87.8255628),
        RetailLocation(name: "Whole Foods", address: "1550 n Kingsbury St", city: "Chicago", state: "IL", zipcode: 60642, lat: 41.9087429, lon: -87.6527428),
        RetailLocation(name: "Whole Foods", address: "840 Willow Rd M", city: "Northbrook", state: "IL", zipcode: 60062, lat: 42.1067411, lon: -87.8007844),
        RetailLocation(name: "Von Maur", address: "727 Veterans Memorial Parkwy", city: "Davenport", state: "IA", zipcode: 52806, lat: 41.5874666, lon: -90.5670093),
        RetailLocation(name: "Barney's Market", address: "10 N Thompson St", city: "New Buffalo", state: "MI", zipcode: 49117, lat: 41.795004, lon: -86.74332679999999),
        RetailLocation(name: "Folgarellis", address: "424 W Front St", city: "Traverse City", state: "MI", zipcode: 49684, lat: 44.7643804, lon: -85.6293948),
        RetailLocation(name: "Potawatomi Resort Gift Shop", address: "1721 W Canal St", city: "Milwaukee", state: "WI", zipcode: 53233, lat: 43.0302135, lon: -87.934859),
        RetailLocation(name: "Renard's Cheese", address: "248 Connty Rd S", city: "Algoma", state: "WI", zipcode: 54201, lat: 44.6822869, lon: -87.3975319),
        RetailLocation(name: "Sentry Albrecht's", address: "3255 Golf Rd", city: "Delafield", state: "WI", zipcode: 53018, lat: 43.053179, lon: -88.364994),
        RetailLocation(name: "Metcalfe's Market", address: "6700 W State St", city: "Wauwatosa", state: "WI", zipcode: 53213, lat: 43.0466315, lon: -87.9957982),
        RetailLocation(name: "Metcalfe's Market", address: "726 N Midvale Blvd", city: "Madison", state: "WI", zipcode: 53705, lat: 43.0741778, lon: -89.45248579999999),
        RetailLocation(name: "Metcalfe's Market", address: "7455 Mineral Point Rd", city: "Madison", state: "WI", zipcode: 53719, lat: 43.057899, lon: -89.51052),
        RetailLocation(name: "Sendik's", address: "2704, 18985 W Capitol Dr", city: "Brookfield", state: "WI", zipcode: 53045, lat: 43.0902264, lon: -88.1483712),
        RetailLocation(name: "Sendik's", address: "13425 Watertown Plank Rd", city: "Elm Grove", state: "WI", zipcode: 53122, lat: 43.04224019999999, lon: -88.0792744),
        RetailLocation(name: "Spendik's", address: "5200 W Rawson Ave", city: "Franklin", state: "WI", zipcode: 53132, lat: 42.9174282, lon: -87.9817107),
        RetailLocation(name: "Spendik's", address: "N112W15800 Mequon Rd", city: "Germantown", state: "WI", zipcode: 53022, lat: 43.2221698, lon: -88.106071),
        RetailLocation(name: "Spendik's", address: "2195 1st Ave", city: "Grafton", state: "WI", zipcode: 53024, lat: 43.3025457, lon: -87.9664051),
        RetailLocation(name: "Spendik's", address: "7901 W Layton Ave", city: "Greenfield", state: "WI", zipcode: 53220, lat: 42.95810789999999, lon: -88.0120465),
        RetailLocation(name: "Spendik's", address: "10930 N Port Washington Rd", city: "Mequon", state: "WI", zipcode: 53092, lat: 43.2166408, lon: -87.9223418),
        RetailLocation(name: "Spendik's", address: "3600 S Moorland Rd", city: "New Berlin", state: "WI", zipcode: 53151, lat: 42.9792684, lon: -88.1066128),
        RetailLocation(name: "Spendik's", address: "280 N 18th Ave", city: "West Bend", state: "WI", zipcode: 53095, lat: 43.4255693, lon: -88.2027444),
        RetailLocation(name: "Spendik's", address: "20222 Lower Union St", city: "Brookfield", state: "WI", zipcode: 53045, lat: 43.0357209, lon: -88.1641899),
        RetailLocation(name: "Spendik's", address: "500 E Silver Spring Dr", city: "Milwaukee", state: "WI", zipcode: 53217, lat: 43.1188607, lon: -87.9036739),
        RetailLocation(name: "Spendik's", address: "8616 W North Ave", city: "Milwaukee", state: "WI", zipcode: 53226, lat: 43.0607614, lon: -88.02003619999999),
        RetailLocation(name: "Spendik's", address: "600 Hartbrook Dr", city: "Hartland", state: "WI", zipcode: 53029, lat: 43.1109445, lon: -88.3360006),
        RetailLocation(name: "Spendik's", address: "824 N 16th St", city: "Milwaukee", state: "WI", zipcode: 53233, lat: 43.0407622, lon: -87.9326999),
        RetailLocation(name: "Apple Holler", address: "5006 S Sylvania Ave", city: "Sturtevant", state: "WI", zipcode: 53177, lat: 42.6747834, lon: -87.9548212),
        RetailLocation(name: "Berres Brothers Coffee Roasters Cafe", address: "202 Air Park Drive", city: "Watertown", state: "WI", zipcode: 53094, lat: 43.1641063, lon: -88.7273699),
        RetailLocation(name: "Creatively Yours", address: "1505 West Mequon Road", city: "Mequon", state: "WI", zipcode: 53092, lat: 43.2205146, lon: -87.9272637),
        RetailLocation(name: "Fromagination", address: "12 South Carroll Street", city: "Madison", state: "WI", zipcode: 53703, lat: 43.0734172, lon: -89.38502369999999),
        RetailLocation(name: "Gooseberries", address: "690 W. State Street", city: "Burlington", state: "WI", zipcode: 53105, lat: 42.6744575, lon: -88.29758559999999),
        RetailLocation(name: "The Domes Gift and Plant Shop", address: "524 S. Layton Boulevard", city: "Milwaukee", state: "WI", zipcode: 53215, lat: 43.025764, lon: -87.94743629999999),
        RetailLocation(name: "HyVee", address: "3801 East Washington Avenue", city: "Madison", state: "WI", zipcode: 53704, lat: 43.1177159, lon: -89.3183571),
        RetailLocation(name: "Hy-Vee", address: "2920 Fitchrona Road", city: "Fitchburg", state: "WI", zipcode: 53719, lat: 43.0133009, lon: -89.4796819),
        RetailLocation(name: "Crossroads Market", address: "762 Commercial Avenue", city: "Green Lake", state: "WI", zipcode: 54941, lat: 43.8533166, lon: -88.9378584),
        RetailLocation(name: "Layton Fruit Market", address: "5337, 1838 E Layton Ave", city: "St. Francis", state: "WI", zipcode: 53235, lat: 42.9594562, lon: -87.88626810000001),
        RetailLocation(name: "Larry's Market", address: "8737 N Deerwood Dr", city: "Milwaukee", state: "WI", zipcode: 53209, lat: 43.1768268, lon: -87.96407049999999),
        RetailLocation(name: "Jacobson Bros", address: "617 N Sherman Ave", city: "Madison", state: "WI", zipcode: 53704, lat: 43.10777789999999, lon: -89.3633256),
        RetailLocation(name: "Madison Avenue Wine Shop", address: "25 S Madison Ave", city: "Sturgeon Bay", state: "WI", zipcode: 54235, lat: 44.8285579, lon: -87.38471849999999),
        RetailLocation(name: "Main Street Market", address: "7770 WI-42", city: "Egg Harbor", state: "WI", zipcode: 54209, lat: 45.0489864, lon: -87.27892159999999),
        RetailLocation(name: "Lautenbach's Orchard Country", address: "9197 WI-42", city: "Fish Creek", state: "WI", zipcode: 54212, lat: 45.1171204, lon: -87.24621859999999),
        RetailLocation(name: "Mars Cheese Castle", address: "2800 W Frontage Rd", city: "Kenosha", state: "WI", zipcode: 53144, lat: 42.6146539, lon: -87.9543466),
        RetailLocation(name: "Orange Tree Imports", address: "1721 Monroe St", city: "Madison", state: "WI", zipcode: 53711, lat: 43.0654831, lon: -89.4158927),
        RetailLocation(name: "Main Street Country Market", address: "320 S Main St", city: "Walworth", state: "WI", zipcode: 53184, lat: 42.5267208, lon: -88.59902249999999),
        RetailLocation(name: "Outpost Natural Foods", address: "7000 W State St", city: "Wauwatosa", state: "WI", zipcode: 53213, lat: 43.0479689, lon: -87.9996512),
        RetailLocation(name: "Outpost Natural Foods", address: "2826 S Kinnickinnic Ave", city: "Milwaukee", state: "WI", zipcode: 53207, lat: 42.9941436, lon: -87.89186839999999),
        RetailLocation(name: "Otto's Liquors", address: "4600 W Brown Deer Rd", city: "Milwaukee", state: "WI", zipcode: 53223, lat: 43.1785669, lon: -87.9683568),
        RetailLocation(name: "Piggly Wiggly", address: "4011 Durand Ave", city: "Racine", state: "WI", zipcode: 53405, lat: 42.69457939999999, lon: -87.82841839999999),
        RetailLocation(name: "Piggly Wiggly", address: "505 Cottonwood Ave", city: "Hartland", state: "WI", zipcode: 53029, lat: 43.09767739999999, lon: -88.34933300000002),
        RetailLocation(name: "Piggly Wiggly", address: "1300 Brown St", city: "Oconomowoc", state: "WI", zipcode: 53066, lat: 43.1271824, lon: -88.4629181),
        RetailLocation(name: "Piggly Wiggly", address: "100 E Genva Square", city: "Lake Geneva", state: "WI", zipcode: 53147, lat: 42.6060646, lon: -88.4239073)
    ]
    
    
}

