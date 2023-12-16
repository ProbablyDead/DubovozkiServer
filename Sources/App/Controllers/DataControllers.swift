//
//  File.swift
//  
//
//  Created by Илья Володин on 16.12.2023.
//

import Vapor

// MARK: - Get data from firestore
func getData(req: Request) async throws -> Schedule {
    try await req.application.ferno.retrieve("bus_schedule")
}

// MARK: Schudule structure
struct Schedule: Content {
    let bus_list: [Bus]
    let revision: Int
}

// MARK: Bus structure
struct Bus: Content {
    let day: Int16
    let dayTime: Int64
    let dayTimeString: String
    let direction: String
    let id: Int16
    let station: String
}

