---
layout:     post
title:      "Devcon2 - Day one"
subtitle:   ""
author:     "Riccardo Casatta"
---

# Initial roadmap

## Martin Becze

researching on EVM 2

## Peter Szilagyi

Team GO
sorry for network problem
Jeff had a baby (main release) si he is in charge

## Christian Reitwiessner

Cpp Team
accelerated interpreter
Remix, mix restart from scratch -> serverless IDE
Solidity more flexible and safer

## Alex Van de Sande

MIST team
started from go become own team

## Vitalik Buterin

He is on research of future protocol feature. he, vlad
sharding (there is a test client)

## Peter Van Valkenburh

### Regulatory considerations for dapp development

CoinCenter promote regulatory climate preserving freedom to innovate
A lot of bitcoin company supporters
Like Ferdinando they commented ESMA consultation
They was bitcoin only 2 years ago, (Washingtion DC at least know it) but now also ethereum and Consensus Open network
Howey test, US security laws if something is a good investment
After paycoin they created a Framework for securities regulations of cryptos
what is less likely to treated as securities:
* token purchased of use value not for profit expectation
* token purchased after is already up and running
* token value is dependent on owners efforts
so, things to avoid
* Initial coin offering
* Profit sharing
* endorsing of unregistered securities

available to contact for any doubt of offering


## Vitalik Buterin

### Ethereum in 25 minutes

A guided tour through the depths of the Merkle underworld
2013 blockchain is useful for stuff... Colored coins, dns...
Most blockchain single purpose device (calculator, or swiss army knife)
Ethereum is like a Windows Phone (platform for application)

state =current information
* balances
* nonces
* contract code and storage
history = things happened
* transactions
* receipts
full node keep state and optionally history
every account object has:
* nonces
* balance
* contract code (empty for user)
* contract root trie
Every node process all tx

futures:
* PoS
* privacy support, zk-snark precompiles ring sig, not at base protocol level
* blockchain representvm upgrades
* more flexible use of storage
* scalability

### Panel: Evolving the EVM

* Greg Colvin CPP
* Martin Ethereum JS
* Pawel Bilica EVM JIT
* Christian Reitwiessner Solidity
* Alex Bergsazi Solidity

Evm code to WebAssembly transpiler
Why web assemply? code format for browser fast/efficent/portable designed to run on untrested env
EVM C for writing smart contract in C

## Philip Daian
IC3 initc3.org

* Scaling / Performance
* Correctness
* Confidentiality
* Authenticated data

The problems are bugs, security more closely tied than anywhere (attacker anonymously monetize, code is public)

 * formal verification
 * escape
 * bug bounties

 Good practices:

 * Specfication, more rigorous the better.
  * english
  * formal (their work Oyente "Making Smart Contract Smarter")
escape hatches, you need a human in the loop

## Aron Fischer and Vitktor Tron

### Swap, swear and swindle, Swarm incentivization

Swarm is storage solutions for ethereum, whisper
get data, calculate H of data and the closest node should store that. routing continuosly ask nearest peer that gives nearest and so on

accounting of used bandwith

chequebook smart contract used to not pay for every check served. Only the last check is payed. Different from channel
if peers get paid they are incentivized to keep popular content. no guarantee that less popular content will remain available -> pay nodes to keep your content.
Overtime challenge the swarm for proof of custody for the data still avilable, the proof of custordy release the payment. What if you can't find the data you paid for? Security deposits for insurance. Swindle

## Private talk with Joseph Poon

he's interested in atomic swap between chains, this requires software talking and he is here to let someone code this for him.
They probably have 12 persons working on lightning network and they will be probabli not in the lab.

## Greg Colvin

### Making the EVM scream

From infinite precision to 512 bit
gas from 256 to 64 bits
Other changes, lots of improvement on speed

## Heiko Hees

### Raiden Network, Off-chain state network

Problems are: throughput, finality, Confidentiality, cost.
salcing 1M+ tx/s, ERC20 compatibilities
Atomic Swaps
Already working prototype
IoT demo on using Raiden Network to pay for electricity
Collaborating with swarm guys
On chain Exchange -> maker broadcast offer, taker ask for atomic token Swap
Proble of free option, party that commits first offers free options. TOkens locked till timeout. Possible solutions is commitment deposits from a third party. Limited trust required :(

## Christian Reitwiessner

### Truebit: Trying to fool a blockchain

wokrs by doing a 1M step computation of the state root hash by both parties.
at some time they differ and I don't understand why this is useful

## Viktor Tron

### Towards web3 infrastructure

Swarm build on chunks of 4Kb. Chunks hashes build a merkle tree granting compact merkle proof and built-in integrity. Who/How the merkle tree is stored???

## TJ Saw

### Parity's launch

Gavin is not available because of a baby
Written in Rust from Mozilla foundation
UI running on a web browser from localhost:3000 very cool


## Jeff Coleman

### State channels: making your application practical

contract between two parties transact directly
judge not in the blockchain, in the end multisig with judge outside
state channel parties must be online or the can leave promises with hired "bystanders"
concrete example: etherdice. user submit bets, and hashes for random. bets stop, bets confirmed, preimage communicated, winner executed. Lot of tx lot of Problems. With state channel zero tx, almost zeros

## Martin Becze and Alex Bergsazi

### Ethereum WebAssembly

VM is the core. Performance are needed
EVM 256 bit words of computation
it has instructions GASLIMIT, BALANCE, SHA3 should't be
missing instructions
WebAssembly is portable size and load time efficieny binary. secure sandbox. Toolchain compatibility
RISC
Integer and Ffloat operationsDefinas as AST abstract state machine
easily processed and trasformed
compact binary representation. fast decoding, single pass validation
IMplemented in Chrome, FIrefox nightly, edge, nodejs 7.0,
Proposed replacement for current EVM, restricted set of WASM, ex no float point operations. Defines backward compatibility.
EVM2WASM translate from evm to wasm producing very fast code. 5000 line of wasm, 400 of js
Metering injection, decoupling from VM. Inserting calls for gas calculation at run time.
EEI Ethereum interface
VM semamntic 3 new rules
1 check contract for ewasm signauture
2 call EVM2WASM
3  use sentinel contract
light client easily written integrating the kernel <1000 lines of WebAssembly.
zcash could be build on WebAssembly
there is a ewasm-libc so you can write C contract
GAS on EVM1 calculated by benchmarking
with wasm gas cost based on the cycle count. The gas cost table is stored in a contract so any client shouldn't changes. web assembly use less cycle for example for sha256.

## Vlad Zamfir

### Correct by construcntion ....

...
byzantine consensus safety on 2/3 in async network, 1/2 in sync one
estimates are non finalized decisions or decision proposals
adversary try to change an estimates

## Jan Xie

### Ethereum on Ruby

Core principles is happyness -> readability and flexibility
teth is a smartcontract testing Framework
Test runs without chain, mining. Emulates the EVM

## Zooko Wilcox

### Zcash + Ethereum = <3

blockchain properties,
* append only - immutability
* canonicity - single source of truth

encryption properties for privacy and selectively disclosure
zcash first of his kind to have all this properties
Zooko has no idea what you can do with this.
Privacy is fundamental human right. Individual, social, business, economic value.
if you encrypt transaction, how nodes could validate transaction? zk-SNARK
ZKP you can make crypto proof they know noone can know that proof without knowing the private key of that output
how to combine privacy & programmibility
Baby ZoE add zsnark precompiler in Ethereum
Project Alchemy, include verify zcash pow in solodity, Zrelay, smart contracts to fullfill orders (decentralized exchanges) but also ethereum contracts could send and receive zcash
28 October Zcash launches

## Lucius Greg Meredith

### Types for tokens (on agenda: Behavioural types for smart contracts)

colletcive intelligence, swarm intelligence in bees is like global consensus. So it's present in nature
new kind of disciplines, not just data access errors.
a lot of verification is possible at compile time
We need formal verification for mission-critical systems
formal verification need to lower the cost to achieve globabl
when you recode the DAO bug in rholang is a Race condition
Rholang is synereo's blockchain-based social contracting language with a built-in behaviorual typing mechanism
All programming languages are generated by monads
The reason to achieve this level of abstraction is because you can make formal verification???


## Bob Summerwill

### Ethereum for resource-limited devices

Ceo of doublethink
resource-costrained device, less capable then desktop machine, limited in cpu, memory, storage, connectivity, batteries or operating system
why ethereum on this devices? ie. mobile computing is mainstream computing.
Java Ring, in 1998 public key encryption and lot of things we are talking now!
2016, samsung watch... ESP8266 2$ wifi enabled chip
ethereum scale of options, sign locally trusted sever, light client, full node, archival node
cross-cpp-ethereum to cross build in various env, also arm linux
(go version work on android)
les on raspberry 25MB binary 50Mb chain cpu 12% ram 162MB, 9 min sync
whisper dev restarted
smallest device actually raspberry A

## Virgil Griffith and Vikram Verma

### Designs fot the L4 contract programming language

legalese.com is developing a software translating a smart contract to english legalese
how do you call a runtime debugger? litigation
why not just use Solodity

## Vitalik Buterin

### The Mauve Revolution

What sucks about ethereun:
1. Privacy (zcash and ring signature)
2. Scalability
3. Pos because PoW Cost
4. Latency

#### Virtual Mining (PoS)

* pow 1000$ miner
* pos 1000$->83 ETH-> virtual miner

Casper PoC3 approach
A special contract could be invoked. with validation_code, randao, withdrawal address, if the call is made in epoch 1 you became a validator at the start of epoch+2
While in the pool you be assigned to create a block with a probability proportional to ether deposited.
A block must contain a signature of the validator (use Lamport signature which are quantum resistant)
if you want you can withdraw the eth (which you can't with physical miner) and the effects after 2 epoch. you get your deposit + rewards + penalties
VAlidatore selection:
stake grinding
marginal cost => marginal revenue?
only the validator of the next block is know
what if validator selected is not available, a list of validator is selected, every one has 4+8i time to answer
nothing at stake
in pos you can vote for 0.9 chain AND 0.1 chain (in pow you have to choose)
Dunkles, if you make a block that doesn't go in the chain you lose the block rewards
In casper wins the blockchain with most value at loss backing wins. How much validator will have to lose...? Finality why? make rollbacks expensive. Light client syncing in O(1)

#### Sharding

onchain scaling to tens of thousands tx
every node keep small tx of the transaction but can merkle verify any tx
There is home shard


## Joseph Poon

### State channels security considerations and solutions

on the blockchain economic considerations are security considerations
one of the partecipants in channel could allow one party to prove some state otherwise a timeout trigger
use relative timestamps the cost of enforcing is smaller
it's really important to keep it simple
solving the free option problem by requiring 10k steps to realize the tx, so minimizing the free option opportunity
