//
//  File.swift
//  
//
//  Created by Jood Khoja on 08/08/1445 AH.
//

import Vapor
import Fluent
import FluentPostgresDriver
//6B67C094-8E4F-43AF-BC89-06049C0B0718
final class LearnerEnrollment: Model, Content {
    // Name of the table or collection.
    static let schema = "learnerEnrollments"
    
    // Unique identifier for this LearnerEnrollments.
        @ID(key: .id)
        var id: UUID?
    
        @Parent(key: "learner_id")
        var learner: Learner
    
        @Parent(key: "course_id")
        var course: Course
        
        @Field(key: "progress")
        var progress: String

        @Field(key: "status")
        var status: String

        // Creates a new, empty.
        init() { }

    init(id: UUID? = nil, learner_id: UUID, course_id: UUID, status: String, progress: String) {
            self.id = id
            self.$learner.id = learner_id
            self.$course.id = course_id
            self.status = status
            self.progress = progress
        }
}
