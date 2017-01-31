---
layout: post
title:  "Random Notes on Stanford Blockchainconf 2017"
---

# Decentralization and incoordination

## Tadge Dryja

- centralization
- coordination
- uniform access

defining borders/interface of blockchain sustem

decentralization
fault tolerant and other stuff

coordination/incoordination
communicate and make decisions about the system
everything defined is not coordination, this is some out of the system (like block size)
access information/ decision based on data external to the system (like passing a tx because is from frank from Canada)
ideal uniform access (miner have no idea what they are meaning) no external inforamtion (auditible but not attributible)
coordination and uniform access are closely correlated
people complain with centralization but is coordination what it matters

bitcoin
fairly decentralized nodes
mining centralized (why know because they tell us, bitcoin code there is no "mined from") this means a lot from the outside (pool)
vanitygen hurting bitcoin network
mining writing they mined a block also

2013 fork, couple of hours split
.8 and .7 version and by external communication the .8 version rolled back

2017 segwit: limits of coordination
use bip9 to signal support (25% adoption now)
comparing to 2013
- less urgent
- larger network
- disagreements among participants

Ethereum
more decentralization than bitcoin (gpu based mining and also block faster so you can solo mine easily)
threat of PoW obsolosence stopped asic developing (and this is external to code, it's just an intention -> coordination)
opcode gas fork (cheap in the eth network, expensive in resource), coordination (most people wanted) -> no problem

prevent coordination?
Maybe is good! (DAO hacker prevented to "steal")
BIP9 needs coordination even on the bits meanings

Maybe is bad
want immutability
uncoordinationgives uniform access

impede coordination
remove coinbase input
force new output address
one-time using signatures
eliminate identities from UI, from coinbase
eliminate history (mible wimble)
obsucer interface points (btce)
eliminate... progress

summary
incoordination: external system changes (forks, governance)
uniform access

eliminate things -> eliminate complexity -> raise coordination

# How formals analysis and verification add security to the system

## Shin'ichiro matsuo

provable secure blockchain with proof of stake (sliding window where proof of stake could apply)
layers of security
- cryptography (ECDSA, sha2, ripemd-160, secure curve parameters) provable security
- backbone
- application protocol
- application logic
- implenentation
- operation

# Open Source Operational Risk

## Angela Walch

Risk outside the systems (people dynamics and problems)
FMI takes risks seriously and grassroots open source software
- No official responsability/accountability to keep software operational
- no one is the official "decider"
(cite heartbleed as problem of OS)
forks? old one, new one contentious coexistence of old and new
march 2013 hard fork coordination required human coordination and altruism to fix

# On the security of PoW blockchains

## Arthur Gervais

Comparing security of PoW blockchains
parameters: block-time, block-size
stale block
block generation faster or block size bigger bring to less security
following this studies 6 bitcoin conf = 37 eth conf. 60 minutes over 10
arthurgervais.github.io
simulation 0.5 sec to 25 min and 0.1-16 MB block
1 MB blocks at 1 minute block no stale block rate increase ???

# Bitcoin is unstable without the block reward

## Arvind Narayanan

tx fees arrive at a constant rate
today standard block reward >> fee reward
tomorrow (since block reward decreasing) fee reward >> block reward
change security strategy
suppose a miner mine a block with 15 fee and mempool now contains 5 of rewards, for another miner could be convenient to mine the previous block so he can have 20 fees
mining learning algo, miner apply weight on each strategy
even if 2/3 of miner are mining to preserve bitcoin network (not greedy) the undercutting strategy is profitable
without block reward selfish mining could be even more profitable (decision based on the value of the blocks)

# Blockchain Tech and Hardware

## Nicolas Bacca

Java Card, started 2000 frozen at 2002 (sim card, yubikey) not auditable, no attestation (Security Domain isolation)
TSM
if you want to put an application on a javacard you have to trust a third party doing it for you and you cannot audit it
ARM enclaves basics (secure bit)
3 implementation Apple, Google, GlobalPlatform
Long stack of technology to build upon

SGX higher level, rely "only" on Intel
Attestation of the running code is build in, intel trust required, attestation based on a secret public group signature
requires intel license, own signed code only in debug mode (not secure)
Why not use phone secure element? cryptography API inlcuded could not be enough (even also checking to sign transaction less than x bitcoin)

# Michelson: a Statically Typed Stack Based Language

## Benjamin Canou

Tezos:
- self-amendable via voting.
- purely proof of stake
- git like state
- highly functional, defensive coding style
- designed for formal certification
smart contract like Ethereum
Michelson language designed to be safe and formal-verified
data structures are immutable
based Ocaml pattern matching
static typecheck, no nulls, no casts
all possible runtime errors: div by zero, token exhaustion, gas exhaustion

# Light client for heavy chains

## Robert Habermeier

blockchain are heavier with state
merged in 3/6 months

random sampling of verification give high prob to verify
node ID 00 keeps the first shard of blocks 01 the second and so on.

# Privacy-preserving smart contracts

## Ranjit Kumaresan

claim-or-refund transaction are a pwoerful abstraction and could be used to decompose complex smart contract to many simpler ones

# Ethereum isn't turing complete

## Andrew Miller

blockchain a virtual trhusted third party.
smart contracts programs running on blockchain.
bitcoin and ethereum.
Ethereum.
turing complete are undecidable (could not build a program that can verify if another program terminates).
actually ethereum halts if finish gas (so not turing complete).
fomral verification could be applied to turing complete program.
bitcoin state is represented by utxo set.
commit and reveal scheme to define the winner, problem, what if a player aborts?
ADMM1414 secure multiparties on bitcoin solves probblem but with a huge amount of collateral.
MB16 lottery on ethereum (easy on ethereum, doable but complicated on bitcoin).
private var in etherum cannot be called from other contract (even if you can read it from the blockchain).
Covenants/ChegSigFromStack.
ethereum is pseudocode, more convenient to implement an idea in ethereum first than deploy in ethereum.
is possible lottery without collateral is an Open Question.
lottery game is like a gpu benchmark.

# Post's Theorem and Blockchain languages

## Russel o'connor

Blockchain programs
P(State, Transaction) -> Bool

the idea is that a client who want to create a smart contract create the program that runs it and the validation program that validates it.
The latter is used for validation (which is lightweight) by the blockchain validators and computed globally (while the smart contract is executed only on that specific node).

# Ivy: a declarative predicate language for smart contracts

## Dan Robinson

Chain script language.
Ethereum has high level language that compiles in bytecode, bitcoin no.
Ivy Predicate language, succed or fails, a limited dialect compiles to Bitcoin script.

# Structuring multi transaction contracts in bitcoin

## Jeremy Rubin

Is cool when contracts call each other.
Safe contract extension for Bitcoin Contracts.
transaction level covenants could allow this kind of smart contracts.
two type covenant.
invariant by execution.
invariant by construnction op_sig...
sum(outputs)<=sum(inputs) is already a covenant

# Future proofing

## Juan Benet

protocolo requires a lot of reasearch, less development, less deployment, only a fraction get used.
IPFS, address MUST be permanent (hash or public key)
if hash breaks must work
must work over any transport
aging problems, protocol ossification, total breaks (cryptography breaks), tiranny of past mistakes
multiaddr is like multihash for protocols

# Design and accountability of Byzantine fault tolerant protocols

## Ethan Buchman

holy grail:

- formal framework for reasoning and proving properties of conseunsu protocols
- abstraction over consensus protocol (plug-in levels of stack)
- "protocol picker" consensus problem as a solution of an optimization problem

simplified BFT is tendermint
consensus is impossible in deterministic problem and async network
but in the end:
consensus is feasible in the presence of partial syncrony
or with some amount of non-determinism (randomized byzantine protocols)

safety and liveness define a consensu protocol

- safety, any process decide on a value other do the same
- liveness, eventuallty a process decide in time

bitcoin drop safety with a probabilistic (strict deterministic safety)
no formal proof for liveness

primary and views
obama to trump syncronous event, in gambia Jammeh and Barrow, Jammeh decided not to step down, so wasnt' clear who the leader is. Consensus protocol requires leader to be defined
Quorum, not a single leader but n over m
problem require additional communication to detect a lie, 3 process are not enough to tolerate one liar across the network
(best you can tolerate is a third of process lying in a network)

strong completeness eventually evert process that chrashes i permanentlu suspected.
eventual ewak accuracy, eventually some correct process is never syspected by a correct process.

omission.
comission.
PeerReview.

tolerance and detection are different and the latter is more complex.
detection called accountability.
slasher a punitive proof of stake algo (not enough detect double signing).
alle safe bft protocol are accountable.

PBFT

cosmos.network (tendermint)

# Proofs of space and time

## Bram Cohem

using proof of disk space as proof of work.
no asic.
spacemint is the state of the art of this kind of mining.

proof of space and proof of time.

modular roots, calculate 2^k-1 and doing one other time go back to the original value (slow to calculate, fast to verify).

proof of time by repeated hashing (parallel-serial hashchain) with checkpoint makes faster to verify.

proof of space, find collision in the first n bits of an hash (faster if I am storing a big table of hashes).

# transparent computational integrity

##  Eli Ben-sasson

computaional integrity, how can we trust the output?
zkp, use randomness interaction and cruptography to solve computational integrity and privacy.

black-list non-mebership.
STARK prove to you element y does not appear in the black list without revealing the blacklist itself.
stark meglio di snark in transparency and scalability.
withs STARK you can avoid trusted setup.
ethereum meetup sunday 29 january institute for the future.

# Stellar

## Tiered quorum is decided by the market

5 seconds confirmation time.
yen, pesos and yuan supported

# Security analysus if the lightining network

## roasbeef

HashLock
lightning-rfc
