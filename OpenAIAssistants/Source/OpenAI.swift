//
//  OpenAI.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Combine
import Moya

public final class OpenAI {

    let apiKey: String
    let organization: String?

    lazy var defaultDecoder: JSONDecoder = {
        $0.dateDecodingStrategy = .secondsSince1970
        $0.keyDecodingStrategy = .convertFromSnakeCase
        return $0
    }(JSONDecoder())

    let modelsProvider: MoyaProvider<Models>
    let assistantsProvider: MoyaProvider<Assistans>
    let threadsProvider: MoyaProvider<Threads>
    let messagesProvider: MoyaProvider<Messages>
    let runsProvider: MoyaProvider<Runs>
    let filesProvider: MoyaProvider<Files>

    public init(apiKey: String, organization: String? = nil) {
        self.apiKey = apiKey
        self.organization = organization
        
        let accessTokenPlugin = AccessTokenPlugin { _ in apiKey }

        modelsProvider = MoyaProvider<Models>(plugins: [accessTokenPlugin])
        assistantsProvider = MoyaProvider<Assistans>(plugins: [accessTokenPlugin])
        threadsProvider = MoyaProvider<Threads>(plugins: [accessTokenPlugin])
        messagesProvider = MoyaProvider<Messages>(plugins: [accessTokenPlugin])
        runsProvider = MoyaProvider<Runs>(plugins: [accessTokenPlugin])
        filesProvider = MoyaProvider<Files>(plugins: [accessTokenPlugin])
    }

}
