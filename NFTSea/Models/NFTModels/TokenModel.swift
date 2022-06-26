//
//  TokenModel.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/23/22.
//

import UIKit


class TokenModel: Codable {
    var tokenName: String
    var tokenSymbol: String
    var tokenID: Int
    var toAddress: String
    var contractAddress: String
    var nonce: String
    var hash: String
    var blockHash: String
    
    init(tokenName: String, tokenSymbol: String, tokenID: Int, toAddress: String, contractAddress: String, nonce: String, hash: String, blockHash: String) {
        self.tokenName = tokenName
        self.tokenSymbol = tokenSymbol
        self.tokenID = tokenID
        self.toAddress = toAddress
        self.contractAddress = contractAddress
        self.nonce = nonce
        self.hash = hash
        self.blockHash = blockHash
    }
}
