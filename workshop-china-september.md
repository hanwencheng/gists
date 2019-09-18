# Parity China Workshop

## Exercise 1: Deploying a Substrate blockchain to a private network

## Run a substrate tempalte node

#### 1. Install substrate, Build the node binary

```shell
# Install Rust toolchains
$ curl https://sh.rustup.rs -sSf | sh -s -- -y && \
	export PATH="$PATH:$HOME/.cargo/bin"
# Build the node binrary
$ git clone -b v1.0 https://github.com/paritytech/substrate
$ cargo install --force --path subkey subkey
$ cd node-template && ./scripts/init.sh && ./scripts/build.sh
$ cargo build --release
```

#### 2. Start as a boot node as Alice 


```shell
$ cd ..
$ ./target/release/node-template \
  --base-path /tmp/alice \
  --chain=local \
  --key //Alice \
  --port 30333 \
  --telemetry-url ws://telemetry.polkadot.io:1024 \
  --validator \
  --name AlicesNode
```

#### 3. Joins in as Bob

```shell
$ ./target/release/node-template \
  --base-path /tmp/bob \
  --chain=local \
  --key //Bob \
  --port 30334 \
  --telemetry-url ws://telemetry.polkadot.io:1024 \
  --validator \
  --name BobsNode \
  --bootnodes /ip4/<Alices IP Address>/tcp/<Alices Port>/p2p/<Alices Node ID>
```

#### 4. Check the State of your blockchai

1. open `https://polkadot.js.org/apps/#/settings`
2. use custom endpoint and input `ws://localhost:9944/`
3. Choose `Explorer` in the left panel, and see the new blocks are generated almost every 10 seconds.

#### Troubleshooting
When consensus is rejected, try clear the data of the chain
1. purge chain data with `./target/release/node-template purge-chain`.
2. delete the temp data in base path. 

## Exercise 2: Build a simple proof of existence blockchain

Create new file called `poe.rs` under `./node-template/runtime/src`, now let's add some stuff in it.

#### 1. Import necessary dependencies
```rust
use support::{decl_module, decl_storage, decl_event, ensure,
    StorageMap, dispatch::Result};
use support::traits::{Currency, ReservableCurrency};
use rstd::vec::Vec;
use system::ensure_signed;
use runtime_primitives::traits::As;

const POE_FEE: u64 = 1000;

type BalanceOf<T> = <<T as Trait>::Currency as Currency<<T as system::Trait>::AccountId>>::Balance;
```

#### 2. Configure your module to emit events

```rust
pub trait Trait: timestamp::Trait {
    type Currency: ReservableCurrency<Self::AccountId>;
    type Event: From<Event<Self>> + Into<<Self as system::Trait>::Event>;
}
```

#### 3. Define your module’s event

```rust
decl_event!(
	pub enum Event<T> where
        <T as system::Trait>::AccountId,
        <T as timestamp::Trait>::Moment
    {
        ClaimCreated(AccountId, Moment, Vec<u8>),
		ClaimRevoked(AccountId, Vec<u8>),
    }
);
```

#### 4. Add the storage/state items
```rust
decl_storage! {
	trait Store for Module<T: Trait> as POEStorage {
		Proofs get(proofs): map Vec<u8> => (T::AccountId, T::Moment);
	}
}
```

#### 5. Add your callable "public" module functions
```rust
decl_module! {
    pub struct Module<T: Trait> for enum Call where origin: T::Origin {
        fn deposit_event<T>() = default;

        fn create_claim(origin, digest: Vec<u8>) -> Result {
            let sender = ensure_signed(origin)?;

            ensure!(!<Proofs<T>>::exists(&digest), "This digest has already been claimed");
            let time = <timestamp::Module<T>>::now();

            T::Currency::reserve(&sender, BalanceOf::<T>::sa(POE_FEE))?;
            <Proofs<T>>::insert(&digest, (sender.clone(), time.clone()));

            Self::deposit_event(RawEvent::ClaimCreated(sender, time, digest));
            Ok(())
        }

        fn revoke_claim(origin, digest: Vec<u8>) -> Result {
            let sender = ensure_signed(origin)?;

            ensure!(<Proofs<T>>::exists(&digest), "This digest has not been claimed yet");
            let (owner, _time) = Self::proofs(&digest);

            ensure!(sender == owner, "You must own this claim to revoke it");

            <Proofs<T>>::remove(&digest);
            T::Currency::unreserve(&sender, BalanceOf::<T>::sa(POE_FEE));

            Self::deposit_event(RawEvent::ClaimRevoked(sender, digest));
            Ok(())
        }
    }
}      
```

#### 6. Add module into runtime

Edit the `lib.rs` file in the same folder.

```rust
# Step 1: Add module into runtime
mod poe;
```

```rust
# Step 2: Add the trait implementation
impl poe::Trait for Runtime {
	type Event = Event;
}
```

```rust
# Step 3: Update `construct_runtime`
construct_runtime!(
  pub enum Runtime where
  Block = Block,
  NodeBlock = opaque::Block,
  UncheckedExtrinsic = UncheckedExtrinsic
  {
    ...
    POEModule: poe::{Module, Call, Storage, Event<T>},
  }
);
```

#### 7. Compile! 
```shell
cargo build --release
```

For detail, check Shawn's [Create your first Substrate blockchan tutorial](https://hackmd.io/B-jWKzRCQmq1gPtFFkXjFA#Proof-Of-Existence-Chain), which maybe slightly difference from the tutorial here.

## Exercise 3: Perform a forkless upgrade to our blockchain!

#### 
1. open the blockechain explorer here `https://polkadot.js.org/apps/#/sudo`
2. copy the wasm file into clipboard 
```shell
$ xxd -p ./node_template_runtime_wasm.compact.wasm | pbcopy
```
3. Update it under `Sudo` and paste the code to `setCode`
