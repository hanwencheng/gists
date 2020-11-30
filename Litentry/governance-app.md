# Proposal: [Governance-focused Mobile App for all Substrate-based networks]
Proponent: (Hanwen/Litentry) `12R4GcpJaQyrDAVZJogjg4UEB4X7cnaUwP9B6c8xHaQc3R2S`

Date: 27.11.2020

Requested DOT: 

Short description: Governance-focused Mobile App for all Substrate-based networks

---
## 1. Context of Proposal

Hanwen Cheng is the previous product owner of Parity Signer. He has rich experience in building mobile and web application, and also very familiar with Substrate based tools.

Litentry Technologies GmbH is a technical company focus on building cross-chain identity aggregator. Which includes the substrate-based network and related tools. The team has solid substrate development experience and also focus on the mobile engineering.

## 2.	Problem statement: 

a.Low Voting Participation Rate: Currently the on-chain governance partcipating rate is quite low, even for big decisions like Kusama denomination, there is only about 10% of staker holder take part in the vote.

b. Missing Identity Governance Stats: When voting for the council members, it is hard to know who make the most contribution to the ecosystem and who participates most in the disucssions. There is no dashboard to show the on-chain governance stats of identity. Also, on Polkadot.js app and Polkassembly, the tooltip of an identity is verified information within limited fields, need more information when user browser and attend governance.

c. Currently there is only Polkawallet has native support for governance functions after browsing the wallets from https://wiki.polkadot.network/docs/en/build-wallets . The others using integrated governance DApp in a WebView, most of wallets does not even has governance functions. Each mobile app has their own governance UI, the engineering power is wasted and lack interoperability.   

Imtoken |  Math Wallet | Polkawallet
:-------------------------:|:-------------------------:|:---|
![imtoken](./imgs/GovernanceImtoken.jpeg)  |  ![mathwallet](./imgs/GovernanceMath.jpeg)| ![polkawallet](./imgs/GovernancePolkawallet.jpeg)

d. The polkadot.js app is moslty used for experienced users or developers. In addition, it includes all the UI to interact with the substrate-based blockchain, and it is aims to be a general-purpose front-end application.

e. Currently, there is no any mobile application could relay the transaction from other wallet on Polkadot ecosystem, Parity Signer and Math Wallet could sign the transaction from Polkadot.js. The wallet ecosystem is relatively closed. 

## 3.	Proposal Objective/solution/s:

### Objective

We want to create a governance mobile application which could:

1. Offer native governance support integrate with Polkadot UI and Polkassembly off-chain discussion. 
2. Provider identity governance statistics for user who has participated in the governance and provide gamification score to incentive user to join governance.
3. Provider interoperability with other mobile wallets (QR code / inter-app communication) to let them sign the governance action. 
 
|Governance Ecosystem Before|Governance Ecosystem Before|
|-------------------------|-------------------------|
|![imtoken](./imgs/governanceBefore.png)|![mathwallet](./imgs/GovernanceNow.png)|

### Solutions / Milestones

#### Milestone 1: On-chain governance basic support
* Native OCG(on-chain governance) actions support on Polkadot/Kusama
* Enable interaction with Parity Signer with QR code.

#### Milestone 2: Integrate identity registration
* Offer user interface to register Identity on Polkadot/Kusama.
* Submit a new automatic registrar with status of each field on Polkadot/Kusama.
* Show Identity registration Status on Polkadot/Kusama. 

#### Milestone 3: Identity Dashboard
* Show identity OCG(on-chain governance) states on Polkadot/Kusama.
* Native support for off-chain discussion from Polkassemby

#### Milestone 4 Inter-app communication
* Interact with other wallet app and sign the transactions with inter-app communication (work together with WalletConnect if their protocol has been done).

#### Milestone 5 Governance Score and Lottery integration
* Be able to do OCG actions on different networks.
* Add gamification score for user who joined on-chain governance.
* Integrate substrate [lottery](https://hackmd.io/68rduBydTEy4X-ULevd90g) support

### Network Benefit

* Have more users share their voice on important elections. (`vote`)
* Encourage users to register on-chain identity. (`identity`,`setIdentity`,`requestJudgement`)
* Have users change/update their validator nominations on a regular schedule. (`nominate`)
* Encourage brainstorming of ideas in future updates and changes (`propose_bounty`)
* Encourage user to use tipping system (`tip`, `reportAwesome`)
* Have more users (change their) backing of (candidate) council members (`electionPhragmen`, `vote`)
* Encourage users to use lottery modules and join vote (`buy_tickets`, `vote`)
* Encourage users to join the off-chain discussion on Polkassembly.

## 4. Why Polkadot Network.

The governance on Polkadot affect the most of the people, and it is of the most important among all the substrate-based networks. 

The technical implementation does not has much diffenrece when we compare Polkadot/Kusama/other Substrate-based networks. So we are doing the work firstly on both Polkadot and Kusama, and then it will be extended to all the substrate-based network.

 ## 5. Payments and Conditions
 
 |Milestones | estimate development time | total cost | DOT value |
 |---|---|---|---|
 |Milestone 1|  
 |Milestone 2|
 |Milestone 3|
 |Milestone 4|
 |Milestone 5|
 
 
 
