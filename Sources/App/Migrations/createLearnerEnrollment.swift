//
//  File.swift
//  
//
//  Created by Jood Khoja on 08/08/1445 AH.
//

import Fluent
import FluentPostgresDriver

struct createLearnerEnrollment: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        // Make a change to the database.
        database.schema("learnerEnrollments")
            .id()
            .field("learner_id", .uuid, .required, .references("learners", "id"))
            .field("course_id", .uuid, .required, .references("courses", "id"))
            .field("progress", .string, .required)
            .field("status", .string, .required)
            .create()
        
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        // Undo the change made in `prepare`, if possible.
        database.schema("learnerEnrollments").delete()
    }
}
