//
//  File.swift
//  
//
//  Created by Jood Khoja on 08/08/1445 AH.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver
//2B923CB3-3FF5-4996-9055-23758781388A
final class Course: Model, Content {
    // Name of the table or collection.
    static let schema = "courses"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "brief")
    var brief: String

    @Field(key: "time")
    var time: String

    @Field(key: "video")
    var video: String

    @Siblings(through: LearnerEnrollment.self, from: \.$course, to: \.$learner)
    public var learners: [Learner]
    
    // Creates a new, empty.
    init() { }

    // Creates a new Galaxy with all properties set.
    init(id: UUID? = nil, name: String, brief: String, time: String, video: String) {
        self.id = id
        self.name = name
        self.brief = brief
        self.time = time
        self.video = video
    }
}
