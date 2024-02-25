//
//  File.swift
//  
//
//  Created by Jood Khoja on 08/08/1445 AH.
//

import Fluent
import FluentPostgresDriver

struct createLearner: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        // Make a change to the database.
        database.schema("learners")
            .id()
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("password", .string, .required)
            .create()
        
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        // Undo the change made in `prepare`, if possible.
        database.schema("learners").delete()
    }
}
