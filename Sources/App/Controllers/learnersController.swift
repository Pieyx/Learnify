//
//  File.swift
//  
//
//  Created by Jood Khoja on 05/08/1445 AH.
//

import Foundation
import Vapor

struct learnersController : RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let learners = routes.grouped("learners")
        
        learners.get(use : getLearners)
        
        learners.post(use : newLearner)
        
        learners.put(":id", use : updateLearner)
        
        learners.delete(":id" , use: deleteLearner)
        
        learners.get(":id", use: getLearnerById)
    }
    
    func getLearners (req : Request) async throws -> [Learner] {
        try await Learner.query(on: req.db).all()
    }
    
    func newLearner (req : Request) async throws -> Learner {
        let learner = try req.content.decode(Learner.self)
        try await learner.create(on: req.db)
        return learner
    }
    
    func updateLearner (req : Request) async throws -> Learner {
        guard let learner = try await Learner.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedLearner = try req.content.decode(Course.self)
        learner.name = updatedLearner.name
        try await learner.save(on: req.db)
        return learner
    }
    
    func deleteLearner (req : Request) async throws -> Learner {
        guard let learner = try await Learner.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await learner.delete(on: req.db)
        return learner
    }
    
    func getLearnerById (req : Request) async throws -> Learner {
        guard let learner = try await Learner.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return learner
    }
    
    
}
