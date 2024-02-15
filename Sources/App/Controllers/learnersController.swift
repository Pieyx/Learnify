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
    
    func getLearners (req : Request) async throws -> String {
        return "GET all Learners"
    }
    
    func newLearner (req : Request) async throws -> String {
        return "POST new Learner"
    }
    
    func updateLearner (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "Update Learner with \(id)"
    }
    
    func deleteLearner (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "Delete Learner with \(id)"
    }
    
    func getLearnerById (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "GET Learner with \(id)"
    }
    
    
}
