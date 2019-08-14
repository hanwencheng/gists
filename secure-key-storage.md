# Parity-Signer Secure Key Storage Proposal

Here I conclude the recent research and discussions with the storage of the seed/private key in parity-signer.

### Current Implementation
![secureStorage1](https://user-images.githubusercontent.com/6014309/63015074-94ea0700-be7f-11e9-843e-f6bec812dc1d.png)
Currently, we require a user to input a pin code for encrypting the seed, and then put the encrypted seed together with other account data into a secure store. The secure store then uses the native `KeysStore` or `KeyChain` to store the encrypted account data.

### Possible improvement
![secureStorage2](https://user-images.githubusercontent.com/6014309/63015133-b77c2000-be7f-11e9-8f53-8aabe80e245b.png)

After discussion with @kirushik and @geastwood, it has the following improvement potential to achieve a higher security level than industry standard.

##### 1. Use a hash of the pin for encryption

Here the way we used to encrypt the pin data is from [EthSign](https://docs.rs/ethsign/0.6.0/ethsign/keyfile/struct.Crypto.html#method.encrypt) Rust library, I am not sure how it works, hope @maciejhirsz could give some hints on that. We could use Argon2 to create a hash of the pin, and use that hash to encrypt the seed. With Argon2, we can efficiently prevent brute force attack.

##### 2. Use FaceID, TouchID for the access of secure storage

To store the encrypted account data into the keychain, we may add an extra biometric authentication layer. One thing needs to be noticed here is that apple use a so-called [Local Authentication Framework](https://developer.apple.com/documentation/localauthentication) to bridging the biometric data in Secure Enclave, but that does not mean that the encryption key is also kept there, it is stored in the Keychain. This is also the behavior what [react-native-keychain](https://github.com/oblador/react-native-keychain/) library does.

##### 3. Use hardware backed Keystore 

iOS devices with A7 (first on iPhone6) or newer chips contain security chips but not all Android devices have the same thing. The good news is Google enforced new devices supporting Android 7 must have a hardware-backed security element. 

[on iOS Secure Enclave](https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_secure_enclave)
> The Secure Enclave is a hardware-based key manager that’s isolated from the main processor to provide an extra layer of security. When you store a private key in the Secure Enclave, you never actually handle the key, making it difficult for the key to becoming compromised. 

AFAIK, these Secure Enclave is not implemented on any react-native keychain related libraries, I suggest we contribute to [react-native-keychain](https://github.com/oblador/react-native-keychain/). 


[on Android](https://source.android.com/security/keystore)
> The availability of a trusted execution environment in a system on a chip (SoC) offers an opportunity for Android devices to provide hardware-backed, strong security services to the Android OS, to platform services, and even to third-party apps

AFAIK, this Hardware backend Keystore is not implemented on any react-native keychain related libraries (Searched `KeyInfo.isInsideSecurityHardware` in their repository). But the hardware implementation on the Android maybe variant according to the device provider. **So our priority is to implement it on iOS**.

### iOS implementation Proposal

Consider the user experience, that two authentication steps in the image2 maybe too much, And the high complexity may increase the risk at the same time, 

![secureStorage3](https://user-images.githubusercontent.com/6014309/63015136-b945e380-be7f-11e9-894c-1d49edd758ae.png)

So the proposal includes two parts as highlighted with the red rectangles:

##### 4.5 Use TouchID Authentication, and encryption key in Secure Enclave instead of Pincode

We may rely on the hardware-backed Key store instead of Argon2 hash and encryption function. They provider similar brute force prevention whereas the secure enclave could prevent software-related risks. Besides, the TouchID / FaceID supposed to be more complicated to compromise than the Pincode, if related user data are exposed, plus the Biometric data's mathematical presentation is also stored in secure enclave according to [here](https://support.apple.com/en-us/HT204587).

##### 6. Eliminate the authentication process for the access of Keychain
As we already have the authentication with biometric data before, here we may just rely on dependency's `setItem` function to help us save the account data into Keychain. Which uses `kSecClassGenericPassword`, the primary key is the combination of `kSecAttrAccount` and `kSecAttrService`. 

Remarks:
1. Consider the still the plain-text seed will be sent to Javascript runtime. We need to force run the garbage collection each time after the seed is present. According to some discussion on [Stackoverflow](https://stackoverflow.com/a/12658212/3060739), it seems uncertain that how the GC works, I suggest we use the current `delete account[key]` implementation.
2. Swift code will automatically release the memory if we use native code. While in Objective-C, we have to release it manually by 
```
if (privateKey) { CFRelease(privateKey); }
if (access)     { CFRelease(access);     }
```
3. In image2 we do not store the hash for comparison but rather throw an error on the decryption process, which could make the process longer to compromise the private key.
