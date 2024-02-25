//
//  File.swift
//  
//
//  Created by Jood Khoja on 05/08/1445 AH.
//

import Foundation
import Vapor

struct learnerEnrollmentsController : RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let learnerEnrollments = routes.grouped("learnerEnrollments")
        
        learnerEnrollments.get(use : getLearnerEnrollments)
        
        learnerEnrollments.post( "learners", ":learnersid","courses", ":coursesid", use : newLearnerEnrollment)
        
        learnerEnrollments.put( use : updateStatus)
        learnerEnrollments.put( use : updateProgress)
        
        learnerEnrollments.get(":id", use: getlearnerEnrollmentById)
    }
    
    func getLearnerEnrollments (req : Request) async throws -> [LearnerEnrollment] {
        try await LearnerEnrollment.query(on: req.db).all()
    }
    
    func newLearnerEnrollment (req : Request) async throws -> LearnerEnrollment {
        let enrollmentData = try req.content.decode(LearnerEnrollment.self)
        guard let course = try await Course.find(req.parameters.get("coursesid"), on: req.db) else {
            throw Abort(.notFound)
        }
        guard let learner = try await Learner.find(req.parameters.get("learnersid"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        try await course.$learners.attach(learner, on: req.db){ pivot in
            pivot.progress = enrollmentData.progress
            pivot.status = enrollmentData.status
        }
        return enrollmentData
    }
    
    func updateStatus (req : Request) async throws -> LearnerEnrollment {
        guard let learnerEnrollment = try await LearnerEnrollment.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedLearnerEnrollment = try req.content.decode(LearnerEnrollment.self)
        learnerEnrollment.status = updatedLearnerEnrollment.status
        try await learnerEnrollment.save(on: req.db)
        return learnerEnrollment
    }
    func updateProgress (req : Request) async throws -> LearnerEnrollment {
        guard let learnerEnrollment = try await LearnerEnrollment.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedLearnerEnrollment = try req.content.decode(LearnerEnrollment.self)
        learnerEnrollment.progress = updatedLearnerEnrollment.progress
        try await learnerEnrollment.save(on: req.db)
        return learnerEnrollment
    }
    
    func getlearnerEnrollmentById (req : Request) async throws -> LearnerEnrollment {
        guard let learnerEnrollment = try await LearnerEnrollment.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return learnerEnrollment
    }
    
    
}
