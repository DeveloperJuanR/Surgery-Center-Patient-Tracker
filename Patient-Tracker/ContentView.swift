//
//  ContentView.swift
//  Patient-Tracker
//
//  Created by Juan Rodriguez on 3/14/25.
//

import SwiftUI

struct ContentView: View {
    @State private var patients: [Patient] = [
        Patient(name: "Alice", stage: .frontDesk, room: "Room 1"),
        Patient(name: "Bob", stage: .preOp, room: "Room 2"),
        Patient(name: "Charlie", stage: .procedureRoom, room: "Room 1"),
        Patient(name: "Diana", stage: .postOp, room: "Room 2")
    ]
    
    @State private var newPatientName: String = ""
    @State private var newPatientRoom: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Kanban Board
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(ProcedureStage.allCases) { stage in
                            VStack {
                                Text(stage.rawValue)
                                    .font(.headline)
                                    .padding(.vertical, 8)
                                
                                // List patients for this stage
                                ScrollView {
                                    LazyVStack(spacing: 12) {
                                        ForEach(patients.filter { $0.stage == stage }) { patient in
                                            PatientCard(patient: patient,
                                                        onAdvance: { advancePatient(patient) },
                                                        onDelete: { deletePatient(patient) },
                                                        onToggleAwake: { toggleAwake(for: patient) },
                                                        onTogglePickup: { togglePickup(for: patient) })
                                        }
                                    }
                                    .padding()
                                }
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                            }
                            .frame(width: 200) // fixed width per stage column
                        }
                    }
                    .padding()
                }
                
                // Add Patient Section
                VStack(spacing: 8) {
                    TextField("Patient Name", text: $newPatientName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Room (e.g., Room 1)", text: $newPatientRoom)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add Patient") {
                        addPatient()
                    }
                    .padding(.vertical, 8)
                }
                .padding()
            }
            .navigationTitle("Surgery Center Board")
        }
    }
    
    // MARK: - Helper Methods
    
    private func advancePatient(_ patient: Patient) {
        if let nextStage = patient.stage.next() {
            if let index = patients.firstIndex(where: { $0.id == patient.id }) {
                patients[index].stage = nextStage
            }
        }
    }
    
    private func deletePatient(_ patient: Patient) {
        patients.removeAll { $0.id == patient.id }
    }
    
    private func addPatient() {
        guard !newPatientName.isEmpty, !newPatientRoom.isEmpty else { return }
        let patient = Patient(name: newPatientName, stage: .frontDesk, room: newPatientRoom)
        patients.append(patient)
        newPatientName = ""
        newPatientRoom = ""
    }
    
    private func toggleAwake(for patient: Patient) {
        if let index = patients.firstIndex(where: { $0.id == patient.id }) {
            patients[index].isAwake.toggle()
        }
    }
    
    private func togglePickup(for patient: Patient) {
        if let index = patients.firstIndex(where: { $0.id == patient.id }) {
            patients[index].readyForPickup.toggle()
        }
    }
}
    

#Preview {
    ContentView()
}
