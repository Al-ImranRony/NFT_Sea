//
//  WalletInit.swift
//  NFTSea
//
//  Created by iRny - Bitmorpher 4 on 6/19/22.
//

import web3swift
import FirebaseFirestore


public struct Web3UserWallet: Equatable {
    let address: String
    let data: Data?
    let name: String
    let type: WalletType
}
enum WalletType: Equatable {
    case normal
    case hd(mnemonics: String?)
}

public struct User {
    var uid: String
    var userName: String
    var email: String
}
public var currentUser = User(uid: "", userName: "", email: "")

let defaultData = [Any]()
public var currentUserWallet = Web3UserWallet(address: "", data: defaultData as? Data, name: "", type: .hd(mnemonics: ""))

public var secretKey: String!
public var privateKey: String!

public let defaults = UserDefaults.standard


public func createNewWallet(name: String, email: String) {
    let walletUserName = name
    let password = "HD wallet pass"  // Should set by user
    
    let bitsOfEntropy: Int = 128  // Measure of password strength. Usually used 128/256 bits
    let mnemonics = try! BIP39.generateMnemonics(bitsOfEntropy: bitsOfEntropy)!
    let keystore = try! BIP32Keystore(
        mnemonics: mnemonics,
        password: password,
        mnemonicsPassword: "",
        language: .english)!
    let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
    let address = keystore.addresses!.first!.address
    currentUserWallet = Web3UserWallet(address: address, data: keyData, name: name, type: .hd(mnemonics: mnemonics))
    let publicAddress = EthereumAddress(currentUserWallet.address)!
    let myPrivateKey = try! keystore.UNSAFE_getPrivateKeyData(password: password, account: publicAddress)
    privateKey = myPrivateKey.toHexString()
    
    currentUser.uid = publicAddress.address
    currentUser.userName = walletUserName
    currentUser.email = email
    
    setUserDefaults(userId: currentUser.uid, password: password, secretKey: mnemonics, privateKey: privateKey)
}

public func importExistingWallet(name: String, email: String, mnemonics: String, pKey: String) {
    let walletUserName = name
    let password = "Imported HD wallet pass"  // Should set by user
    let mnemonics = mnemonics
    let myPrivateKey = pKey
    
    
    if (mnemonics != "") {
        let keystore = try! BIP32Keystore(
            mnemonics: mnemonics,
            password: password,
            mnemonicsPassword: "",
            language: .english)!
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        currentUserWallet = Web3UserWallet(address: address, data: keyData, name: name, type: .hd(mnemonics: mnemonics))
        let publicAddress = EthereumAddress(currentUserWallet.address)!
        let myPrivateKey = try! keystore.UNSAFE_getPrivateKeyData(password: password, account: publicAddress)
        privateKey = myPrivateKey.toHexString()
        
        currentUser.uid = publicAddress.address
        currentUser.userName = walletUserName
        currentUser.email = email
        
        setUserDefaults(userId: currentUser.uid, password: password, secretKey: mnemonics, privateKey: privateKey)
    }else {
        let formattedKey = pKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let dataKey = Data.fromHex(formattedKey)!
        let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        currentUserWallet = Web3UserWallet(address: address, data: keyData, name: name, type: .hd(mnemonics: mnemonics))
        let publicAddress = EthereumAddress(currentUserWallet.address)!
        
        currentUser.uid = publicAddress.address
        currentUser.userName = walletUserName
        currentUser.email = email
        
        setUserDefaults(userId: currentUser.uid, password: password, secretKey: mnemonics, privateKey: formattedKey)
    }
}


public func setUserDefaults(userId: String, password: String, secretKey: String, privateKey: String) {
    defaults.set(userId, forKey: "userId")
    defaults.set(password , forKey: "password")
    defaults.set(secretKey, forKey: "secretKey")
    defaults.set(privateKey, forKey: "privateKey")
    
}

