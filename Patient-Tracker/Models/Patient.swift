//
//  Patient.swift
//  Patient-Tracker
//
//  Created by Juan Rodriguez on 3/14/25.
//

import Foundation

struct Patient: Identifiable {
    let id: UUID = UUID()
    var name: String
    var stage: ProcedureStage
    var room: String  // e.g., "Room A" for the assigned doctor
    var isAwake: Bool = false
    var readyForPickup: Bool = false
}
