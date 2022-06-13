//
//  ControlTower.swift
//  ControlTower
//
//  Created by Kris Rajendren on Apr/3/16.
//  Copyright © 2016 pusht. All rights reserved.
//

import Foundation

// MARK: protocols

typealias Knots = Int

protocol Flying {
    var descentSpeed: Knots { get }
}

struct LandingInstructions {
    let runway: ControlTower.Runway
}

protocol Landing {
    func requestLandingInstructions() -> LandingInstructions
}

protocol AirlineType {}

protocol Airline: Flying, Landing {
    var type: AirlineType { get }
}

// MARK: Airline Type

enum DomesticAirline: AirlineType {
    case Delta
    case United
    case American
}

enum InternationalAirline: AirlineType {
    case Lufthansa
    case AirFrance
    case KLM
}

// MARK: Control Tower

final class ControlTower {
    enum Runway: String {
        case A123
        case B123
        case C123
        case D123
        
        static func assignRunway(Speed: Knots) -> Runway {
            switch Speed {
            case 0..<91: return .A123
            case 91...120: return .B123
            case 121...140: return .C123
            case 141...165: return .D123
                
            default: return .D123
            }
        }
    }
    
    enum Terminal {
        case A(Int?)
        case B(Int?)
        case C(Int?)
        case International(Int?)
        case Private(Int?)
        
        static func assignTermial(airline: Airline) -> Terminal {
            switch airline.type {
            case is DomesticAirline:
                let airlineType = airline.type as! DomesticAirline
                switch airlineType {
                case .American :
                    return .A(nil)
                case .Delta :
                    return .B(nil)
                case .United :
                    return .C(nil)
                }
            case is InternationalAirline:
                return .International(nil)
            default :
                return .Private(nil)
            }
        }
    }
    
    func land(airline: Airline) -> LandingInstructions {
        let runway = Runway.assignRunway(airline.descentSpeed)
        return LandingInstructions(runway: runway)
    }
}