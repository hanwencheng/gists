## Run a substrate tempalte node

1. Run the node
```
docker run substrate-node:latest --key "fatal tornado couple logic forward crime swamp short flush paper defy youth"  --name HanwensNode          

```

2. Interact with Blockchain on `https://polkadot.js.org/apps/`


## Create Custom Runtime Module

#### Add module into runtime
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
