//
//  File.swift
//  
//
//  Created by Jood Khoja on 08/08/1445 AH.
//

import Fluent
import FluentPostgresDriver

struct createCourse: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        // Make a change to the database.
        database.schema("courses")
            .id()
            .field("name", .string, .required)
            .field("brief", .string, .required)
            .field("time", .string, .required)
            .field("video", .string, .required)
            .create()
        
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        // Undo the change made in `prepare`, if possible.
        database.schema("courses").delete()
    }
}
