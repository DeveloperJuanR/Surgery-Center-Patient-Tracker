//
//  ProcedureStage.swift
//  Patient-Tracker
//
//  Created by Juan Rodriguez on 3/14/25.
//

import Foundation

enum ProcedureStage: String, CaseIterable, Identifiable {
    case frontDesk = "Front Desk"
    case preOp = "Pre-op"
    case procedureRoom = "Procedure Room"
    case postOp = "Post-op"
    case left = "Left"
    
    var id: String { self.rawValue }
    
    // Provide a simple “next stage” helper.
    func next() -> ProcedureStage? {
        let allStages = ProcedureStage.allCases
        if let index = allStages.firstIndex(of: self), index < allStages.count - 1 {
            return allStages[index + 1]
        }
        return nil
    }
}
