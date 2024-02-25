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
    
    func getCourses (req : Request) async throws -> [Course] {
        try await Course.query(on: req.db).all()
    }
    
    func newCourse (req : Request) async throws -> Course {
        let course = try req.content.decode(Course.self)
        try await course.create(on: req.db)
        return course
    }
    
    func updateCourse (req : Request) async throws -> Course {
        guard let course = try await Course.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedCourse = try req.content.decode(Course.self)
        course.name = updatedCourse.name
        try await course.save(on: req.db)
        return course
    }
    
    func deleteCourse (req : Request) async throws -> Course {
        guard let course = try await Course.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await course.delete(on: req.db)
        return course
    }
    
    func getCourseById (req : Request) async throws -> Course {
        guard let course = try await Course.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return course
    }
    
    
}
