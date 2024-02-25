//
//  File.swift
//  
//
//  Created by Jood Khoja on 08/08/1445 AH.
//

import Vapor
import Fluent
import FluentPostgresDriver

//7F92A12A-454B-4931-BAA3-B04C1363C393
final class Learner: Model, Content {
    // Name of the table or collection.
    static let schema = "learners"
    
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    @Field(key: "email")
    var email: String
    @Field(key: "password")
    var password: String

    @Siblings(through: LearnerEnrollment.self, from: \.$learner, to: \.$course)
    public var courses: [Course]

    // Creates a new, empty.
    init() { }

    // Creates a new Galaxy with all properties set.
    init(id: UUID? = nil, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
