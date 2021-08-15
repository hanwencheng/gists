# Polkadot Sign In

### Current Practice

In a Web2 world, OAuth is the industry-standard protocol for authorization, it obtains an access token--a string denoting a specific scope, lifetime, and other access attributes. Access tokens are issued to third-party clients by an authorization server with the approval of the resource owner. Then the client uses the access token to access the protected resources hosted by the resource server.

In Web3, injected signers are widely used for connecting accounts with dApps, for example, Metamask one-click connect gives the dApp Ethereum accounts information with `eth_account` method, WalletConnect generate a QR code to connect a mobile wallet with its handshake protocol. And after connecting, every user action needs to be signed by the injected Ethereum account, this method is safe and efficient.

Considering injected signers' "connect" feature as a sign-in method is not optimal because a malicious user could inject a custom signer like Metamask with a customized `eth_account` method so that the malicious user could pretend to be the owner of a labeled Ethereum address. So that for an injected signer, the user needs to sign a piece of data for each action, which is not efficient and has a bad user experience.

A combination with OAuth and injected signer should be raised, there is some research and practices as listed below:

[EAuth](https://github.com/pelith/node-eauth-server)
[Sign in with Magic links](https://magic.link/docs/blockchains/ethereum) rely on JsonRpcProvider
[DAuth](https://github.com/madhavanmalolan/dauth) registration by decentralized authorities.
[ethereum oauth](https://github.com/Recoblix/ethereum-oauth) 
This paper [OAuth 2.0 authorization using blockchain-based tokens]
auth0 team has make a [proposal](https://auth0.com/blog/an-introduction-to-ethereum-and-smart-contracts-part-3/)  

to ask the user to sign such a magic string with injected signers and provides it as an access tokens for Applications. But instead of verified by authorization server who holds the approval of resource owner (user), it should be verified in a decentralized way.

### Specification

#### Sign in Participants

- **Service providers** are the dApps that have the sign-in requirement.
- **Identity providers** are the injected signers which provide the authentication information of the user who holds the wallet.
- **Resource Owners** are the users who hold the crypto wallets, have registered identities on ENS.

#### Workflow

The workflow works the same with or without OAuth specification. Only the 4th step will differ.

1. A user sends a request to a service provider.
2. The service provider sends a callback address, the sign-in challenge, and required permissions to the user.
3. The user connects to the injected signer.
4. injected signed to sign the challenge, and send the signature together with the public address, an access token specifying the scopes like valid time, back to the callback address. With OAuth Implementation, the access token is compliant with the OAuth standard.
5. The service provider validates the signature, if successful, the user signed in,
6. If there is no related user information in the database, the service provider will lookup for the user information from Identity Registrar, if related TEXT records are found for this address, the information will be imported into the service provider’s database.

![Sign-in Flow](./imgs/Sign-in%20Flow.png)

### Implementation

#### Access token standard

### **Team Background**

**Litentry**

[Litentry](https://www.litentry.com/) Technologies GmbH is a Berlin-based technology company, the team builds the identity-related infrastructure of Web3, builds a Decentralized Identity Aggregation protocol across multiple networks, it features a DID indexing mechanism, and a Substrate-based credit computation network. The protocol provides a decentralized, privacy-preserving interoperable identity aggregation service that mitigates the difficulty of resolving agnostic DID mechanisms. The team has lots of experience in the DID field and has a strong background in Web3 technology. Current products include [Litentry Network](https://litentry.medium.com/developing-a-did-aggregator-on-blockchain-part-%E2%85%B1-3dab1398c512), [My Crypto Profile](https://mycryptoprofile.io/), and [a Governance-focused mobile App](https://polkadot.polkassembly.io/motion/49).

### **Roadmap and Payments**

1. Survey and discuss with related team 20 FTE hours
2. Create the specification w/o OAuth 20 FTE hours
3. Create a Javascript/Typescript library 50 FTE hours
4. Integration with a dApp as first use case 30 FTE hours

The hourly pay rate is 50 USD/hour

In total is 120 hours and the total payment will be 6000 USD equivalent BTC.
