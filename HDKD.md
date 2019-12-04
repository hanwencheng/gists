# HDKD on Substrate

## Keypair generation process on Parity-signer / Substrate

1. The recovery phrase goes into the `tiny-bip39` crate to produce entropy: https://docs.rs/tiny-bip39/0.6.2/bip39/struct.Mnemonic.html#method.entropy
2. Generate the "mini secret key" from entropy: https://docs.rs/substrate-bip39/0.3.1/substrate_bip39/fn.mini_secret_from_entropy.html
3. "mini secret key" can be used with `schnorrkel` to create the MiniSecretKey that can be expanded into a full keypair: https://docs.rs/schnorrkel/0.8.5/schnorrkel/keys/struct.MiniSecretKey.html
4. MiniSecretKey can be used for signing, or we can derive new secrets from it. https://github.com/paritytech/parity-signer/blob/0cb137a2a3717c178be6981f9d47129ef3067e5e/rust/signer/src/sr25519.rs#L48-L51

## The form of Path

Path also refers to the Chaincode which described in [BIP32](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki/), it is totally different from BIP-32 style:
* Soft derivation start with single slash, like: `/soft`
* Hard derivation start with double slash, like: `//hard`

The encoded strings follows are limited to 32 Bytes.

## Difference of hard and soft derivated keys.

Both hard and soft derivation will create new keypair, and the following three ways work:

* Private parent key -> private child key
* Public parent key -> public child key (only works for soft keys)
* Private parent key -> public child key (for hard keys, it can only by the way that firstly derive child private key, and then derive child public key, for soften keys, there is an additional way is to first derive parent public key, and then derive the public key)

The key difference is that:
hard - Public key do not has a corresponding derivation, derived public key is not linked with parent public key, it can not be proved. 
soft - Public key has a corresponding derivation, derived public key is linked with parent public key, it can be proved. 

Soft derivation method has a pro here is that one could derive child public keys of a given parent key without knowing any private key.

## Use cases

Basically the HDKD ease the management & storiing of variant keys / recovery phrases. In addition to that it enables:

* distributing the keypairs in an organization.
* track different transactions by auditor / seller.
* sharing the whole wallet
* frequent transactions that cannot (easily) be associated
* distributing keys for multi signature.

Especially for soft derivated keys:
One may distribute the public key instead of private key, so that the owner's of parent publick key could derive child public key to monitor the transactions on the address.

## Potental Risks

Some related security reality is:

With child private key and path, could not find parent private key efficiently.
With fixed order of private key list, could not find parent private key efficiently.

And the followings are NOT true, which may lead to potential risks:

With parent and child public key, it is hard to find the path.
With parent public key and soften child private key, it is hard to find the parent private key.

NOTICE: If a derived soft child private key is compromised, and parent publick key is exposed, then the risk for compromising parent private key will be raised. So the suggestion is if you use soft derivated child keyparis, then better not to sign and submit transactions with parent private key.
More details needed to be added after talk with Jeff.

## References:
1. https://github.com/w3f/schnorrkel
2. https://wiki.polkadot.network/docs/en/learn-keys
3. https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki/
