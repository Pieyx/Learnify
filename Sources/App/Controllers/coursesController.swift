//
//  File.swift
//  
//
//  Created by Jood Khoja on 05/08/1445 AH.
//

import Foundation
import Vapor

struct coursesController : RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let courses = routes.grouped("courses")
        
        courses.get(use : getCourses)
        
        courses.post(use : newCourse)
        
        courses.put(":id", use : updateCourse)
        
        courses.delete(":id" , use: deleteCourse)
        
        courses.get(":id", use: getCourseById)
    }
    
    func getCourses (req : Request) async throws -> String {
        return "GET all Courses"
    }
    
    func newCourse (req : Request) async throws -> String {
        return "POST new Course"
    }
    
    func updateCourse (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "Update Course with \(id)"
    }
    
    func deleteCourse (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "Delete Course with \(id)"
    }
    
    func getCourseById (req : Request) async throws -> String {
        let id = req.parameters.get("id")!
        return "GET Course with \(id)"
    }
    
    
}
