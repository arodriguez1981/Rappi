//
//  Creds.swift
//  Rappi iOS Test
//
//  Created by Alex Rodriguez on 04/08/21.
//  Copyright © 2021 Alex Rodriguez. All rights reserved.
//


import Foundation
import Alamofire
import RealmSwift
import Realm

var APIKey = "7ab01ece0568609dace19d3396efb108"
var accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YWIwMWVjZTA1Njg2MDlkYWNlMTlkMzM5NmVmYjEwOCIsInN1YiI6IjVkMWEyZDMzY2E0ZjY3NTJiY2Q2OTA3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.468TJEhQMUxrS62wurERJi5VjBP-5IYC3VmaDuTtVlI"
var currentAccessToken = ""
var accountId = ""
var headers: HTTPHeaders!
var token = ""
var realm: Realm?
