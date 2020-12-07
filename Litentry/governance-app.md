# Proposal: [Governance-focused Mobile App for all Substrate-based networks]
Proponent: (Hanwen/Litentry) `12R4GcpJaQyrDAVZJogjg4UEB4X7cnaUwP9B6c8xHaQc3R2S`

Date: 27.11.2020

Requested DOT:

Short description: Governance-focused Mobile App for all Substrate-based networks

---
## 1. Context of Proposal

Hanwen Cheng is the former product owner of [Parity Signer](https://github.com/paritytech/parity-signer). He has rich experience in building mobile and web applications, also very familiar with Substrate based tools. Now he is working for [Litentry Technologies GmbH](https://www.litentry.com/), a technology company focusing on building a [cross-chain identity aggregator](https://litentry.medium.com/why-we-need-cross-chain-identity-on-polkadot-d59a90c9329c), which includes the substrate-based network and related tools. The team has solid substrate development experience and specialization in mobile engineering.

Aggregated identity means an identity linked with accounts from different blockchains and off-chain applications/services, which represent the owner behind the accounts, and further present the owner's credibility and reputation from various aspects. In this proposal, we provide a governance app, with gathered participants' info integration. It could facilitate the governance process, integrate participants' more information from linked accounts on other networks, and encourage more users to join on-chain governance once we provide Litentry native token as incentives.

Though Polkadot uses Phragmén Method to equalize stake holder's voting power in elections, the blockchains probably consider the reputations of identity while the calculation of voting power in elections in the future. That is why we think identity is critical in governance, and we need to gather and show participants' info in this mobile app.

## 2. Problem statement:

There are a few identified issues when it comes to on-chain governance as we experience it on Polkadot and Kusama:

a. Low Voting Participation Rate: Currently the on-chain governance participation rate is quite low, even for controversial decisions like Kusama redenomination, (where there is only about 10% of stakeholders take part in the vote).

b. Missing Identity Governance Stats: When voting for the council members, it is hard to know who, from all councilors, has made the most contributions to the ecosystem and who has participated the most in the discussions. Currently, there is no dashboard to show on-chain governance stats of identity. Also, on [Polkadot.js Apps](http://polkadot.js.org/apps/) and [Polkassembly](https://polkadot.polkassembly.io/), the identity tooltip is limited to certain fields, therefore more rich information is needed to be shown when users browse and participate in governance. Opensquare has made a [proposal](https://kusama.polkassembly.io/post/352) on Kusama about the treasury reputation recording system, and this system is currently in the web app side.

c. After investigating the wallets listed on https://wiki.polkadot.network/docs/en/build-wallets, currently only [Polkawallet](https://polkawallet.io/) natively supports for governance module. The rest wallets either use integrated governance DApp in a WebView, or do not even have governance module integration at the moment. Furthermore, each mobile app has its own governance UI, the engineering power is wasted and lacks interoperability.

Imtoken |  Math Wallet | Polkawallet
:-------------------------:|:-------------------------:|:---|
![imtoken](./imgs/GovernanceImtoken.jpeg)  |  ![mathwallet](./imgs/GovernanceMath.jpeg)| ![polkawallet](./imgs/GovernancePolkawallet.jpeg)

d. Polkadot.js Apps is mostly employed by experienced users or developers. Besides, it exposes low-level APIs to interact with substrate-based blockchains, which is unfriendly to end-users. More specifically, it aims to be a general-purpose front-end application.

e. There is no mobile application that could relay the transactions from other wallets on the Polkadot ecosystem. And only a few mobile wallets like Parity Signer and [Math Wallet](https://mathwallet.org/) could sign the transactions from Polkadot.js Apps. The wallets' ecosystems are relatively closed.

## 3. Proposal Objective/solution/s:

### Objective

We want to create a governance mobile application which could:

1. Offer native governance support integration to Polkadot UI and Polkassembly off-chain discussion.
2. Improve user engagement by allowing them to receive and customize **Push Notification** of governance-related updates.
3. Provide participants with good governance statistics and gamification score to incentive users to join governance.

|Current Governance Ecosystem| Targeting Governance Ecosystem|
|-------------------------|-------------------------|
|![imtoken](./imgs/governanceBefore.png)|![mathwallet](./imgs/governanceNow.png)|

### Solutions / Milestones

#### Milestone 1: Integrate identity registration
* Offer user the capability to verify Identity (e.g. email, riot) in App.
* Provide a registrar service to automatically verify the submit identity.
* Display a basic dashboard of governance related activities for this identity
* Display Identity registration Status on Polkadot/Kusama.

#### Milestone 2: On-chain governance basic support
* Support native governance actions on Polkadot/Kusama with good information hierarchy and UX.
* Allow user to subscribe governance related updates via Push Notification to improve engagement. (e.g. when a new proposal is up, or it either being accepted or rejected.)
* Build further on governance dashboard, allowing user to see goverance related statistics of any Account. (e.g. if user
  is browsing a proposal and want to learn more about the **proposer**)


#### Milestone 3: Identity Dashboard and customization
* Allow user to further customize **Push Notification** settings to receive tailored governance related digest.
* ?Show identity on-chain governance states on Polkadot/Kusama.(Extends on Openquare's treasury [reputation data](https://kusama.polkassembly.io/post/352))
* Allow user to participate in discussions from Polkassemby natively in app.
* Further enrich governance dashboard's data of an Identity from different chains.


#### Milestone 5 Governance Score and Lottery integration
* Be able to do OCG actions on different networks.
* Add gamification score for users who joined on-chain governance.
* Integrate substrate [lottery](https://hackmd.io/68rduBydTEy4X-ULevd90g) support.

### Network Benefit

* Have more users share their voice on important elections. (`vote`)
* Encourage users to register on-chain identity. (`identity`, `setIdentity`, `requestJudgement`)
* Have users change/update their validator nominations on a regular schedule. (`nominate`)
* Encourage brainstorming of ideas in future updates and changes (`propose_bounty`)
* Encourage user to use tipping system (`tip`, `reportAwesome`)
* Have more users (change their) backing of (candidate) council members (`electionPhragmen`, `vote`)
* Encourage users to use lottery modules and join vote (`buy_tickets`, `vote`)
* Encourage users to join the off-chain discussion on Polkassembly.

## 4. Why Polkadot Network.

The governance on Polkadot affects most users, and it is of the most important features among all substrate-based networks.

The technical implementation does not have much difference when we compare Polkadot/Kusama/other Substrate-based networks. So we are doing the work firstly on both Polkadot and Kusama, and then it will be extended to all the substrate-based networks.

 ## 5. Payments and Conditions (TBD)

 |Milestones | estimate development time | total cost (USD) | DOT value |
 |---|---|---|---|
 |Milestone 1|  100 | 8000 |
 |Milestone 2|  100 | 8000 |
 |Milestone 3|  100 | 8000 |
 |Milestone 4|  100 | 8000 |
 |Milestone 5|  100 | 8000 |
