//
//  PatientCard.swift
//  Patient-Tracker
//
//  Created by Juan Rodriguez on 3/14/25.
//

import SwiftUI

// MARK: - Patient Card View

struct PatientCard: View {
    let patient: Patient
    var onAdvance: () -> Void
    var onDelete: () -> Void
    var onToggleAwake: () -> Void
    var onTogglePickup: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(patient.name)
                    .font(.headline)
                Spacer()
                // Delete button
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
            Text("Room: \(patient.room)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 12) {
                // Icon for awake alert
                Button(action: onToggleAwake) {
                    Image(systemName: patient.isAwake ? "person.fill.checkmark" : "person")
                }
                
                // Icon for ride pickup
                Button(action: onTogglePickup) {
                    Image(systemName: patient.readyForPickup ? "car.fill" : "car")
                }
            }
            .font(.title2)
            
            // Advance button
            Button("Next Stage", action: onAdvance)
                .font(.caption)
                .padding(4)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
