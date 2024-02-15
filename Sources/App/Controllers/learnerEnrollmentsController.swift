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
        
        learnerEnrollments.post(use : newLearnerEnrollment)
        
        learnerEnrollments.put(":id", use : updateLearnerEnrollment)
        
        learnerEnrollments.get(":id", use: getlearnerEnrollmentById)
    }
    
    func getLearnerEnrollments (req : Request) async throws -> String {
        return "GET all Learner Enrollments"
    }
    
    func newLearnerEnrollment (req : Request) async throws -> String {
        return "POST new Learner Enrollment"
    }
    
    func updateLearnerEnrollment (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "Update Learner Enrollment with \(id)"
    }
    
    func getlearnerEnrollmentById (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "GET Learner Enrollment with \(id)"
    }
    
    
}
