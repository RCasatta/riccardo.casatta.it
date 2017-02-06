---
layout: post
title:  "Random Notes on Construct 2017"
---


# Ethereum
## Hudson Jameson

Metropolis in 3-6 months
- contract can pay from themself
- other primitives added (lamport, aggregate)
- zk-snark

Serenity not scheduled yet but proof of stake
- UTXO based token management
- swap out consensus
- blockchain sharding

# Bitcoin
## Cory Fields

Value proposition: store of value (digital gold) and high-volume transaction netowork
no foundation, no road map, just whatever a devs want to be developed
bitcoin core most active repo during 2016: 47 code contributors, 517 contributores, 1032 PR, 1600 Commits and _15208 code comments_
segwit: malleability fix, quadratic hash fix, more security for hardware wallets, increase block size.
enabling time-locked transaction better than nLockTime
- checklocktimeverify: absolute time
- checksequenceverify: relative time
BIP9 defines how soft-forks are activated, adding grace-period after activation and allow multiple soft-forks deployments
speeding up validation with specific library
0.14 skip validation in some cases
tools for stuck transactions: BumpFee rpc command (RBF based) start low and ramp up if you are not interested in speed, child pays for parent
speeding up p2p: compact blocks do not resend all txs in the block (cause you probably already know!), relay before full validation, keep the connection busy.
0.14 slated for March 1
we don't know what features are going to activate, really decentralized system
fun things after segwit
encrypted p2p segwit bip 121 or 151  useful to discover trusted owned node
discussion on safe hard-forks

# Zcash
## Zooko Wilcox

it's possibile to put privacy transaction with a public ledger
privacy is needed for fungibity
Satoshi cannot encrypt transaction because there was no generalized zksnark at that time, so he cannot exclude bogus encrypted transaction to be mined
if someone know private key from the ceremony can forge fake zcash (but not affects privacy of other transactions)
are you rebasing zcash 0.11 bitcoin based with bitcoin newer features? Probably cherry picking

# Blockstack and IPFS
## Muneeb and Juan

### Muneeb

David Clark used end-to-end design for internet: not put anything intelligente in the middle of the network
over time much complexity moved inside the network, like talking to a friend through facebook I am trusting facebook, or https certificate or dns
trust-to-trust design principle, do not trust any party in the middle of the network
blockstack throw away DNS and PKI infrastrcture, new TLD named .id owned by public keys running on the bitcoin blockchain (bitcoin more secure by far)
uplink/downling aren't symmetric, open-source momentum like IPFS based addressing (didn't happen before)
Basic trust layer is there (bitcoin blockchain)
blockstack embed data in the blockchain (nodes doesn't care of this data) then process that data to creating data used for example for the DNS for .id
Most data kept outside of the blockchain, using drivers for using any storage provider (dropbox, and working on IPFS)
blockstack browser to navigate to warner.id taking care of the underlying tech. used to connect to a web which is not connected to Apple or Google.

### Juan

web3.0 connect end-to-end removing trust from the intermediary
IPFS, instead of location addressing at hearth of the internet, use content address with fingerprint of the content


# Hyperledger
Hyperledger is an unmbrella of projects like: Fabric Iroha, Sawtooth
One is Intel with "proof of elapsed time"

# SegWit
## Eric Lombrozo

signature host most of the transaction data
segwit allows tramission of effects and signature separated, allowing pruning signature from the stored blockchain
signatures are considered 1/4 of the weight of the transaction itself and block cost raised to 4M
script replacement, new signature scheme, like schnorr or quantum resistant
Merkelized Abstract Syntax Trese (MASTs)
fraud proof
new field in the transaction normally change transaction hash unless you add field in the witness part which is not part of the hashed data
signed values, also the value must be signed so hardware wallet can skip to verify the dependency
txid and segwithashit that hashes transaction data and witness, the latter is added to another merkle tree (using the same merkle root tree would require an hard fork)
P2SH-wrapped Witness Program grants backward compatibility of segwit tx with old wallet
segwit is activating on litecoin

# Privacy and Fungibility
## Andrew Poelstra

every coin is interchangable with anuy other
bitcoin is very bad at fungibility chain analysis tools are a proof of that
potential solution is confidential transactions proposed by gregory maxwell use homomorphic commitments
tumblebit, tumbler server doesn't know anything and it cares about networking between clients
MimbleWimble blabla.
Active Monitoring is still a problem in mimblewimble (you can rebuild the pre-pruned mimblewimble blockchain)

# Sidechain
## Greogory Sanders

Things on bitcoin are rolled out slowly, sidechain could be a playground of the blockchain

# Lightining networks
## Joseph Poon

in financial services trust is your margin
multiparty payments conditional one another
in the path alice -> bob -> dave -> carol, where alice wants to pay carol, you are not giving bob and dave money, you are giving them a smart contract
swift on steroids without third parties
The blockchain as a Court, lighting is the first system
for small value you don't go to court (just for an house which has big value)
debt is the monetization of trust
paypal min is 30 cents
LN million or billion of transaction like a thousand of a cent
new use case possible
if someone cheats you for a thousands of a penny, well not so bad, not much trust in the counterparty then. reputation less important
you cannot build an open network over a private one, the other way around is easy


## Gregory Maxwell

a lot of hype somehow justified cause bitcoin is incredible technology
it means different things to different people

- new kind of money
- other points

bitcoin is p2p electronic cash exostomg omdeèemdemt of any tristed third partu
no intrinsic value, just valuable because people use it
possible because entity force to use it
bitcoin is volutnary
bitcoin is also a novel cryptography protocol, maybe vulnerable if anything is slightly wrong
time is running is a prove that is pretty strong
central banks use monetary policy for the benefits of the society
what happens if people have different choices
can't we just blockchain?
Janet Yellen: "Blockchain is an improtant technology, it's a core technologyu embodied in Bitcoin"
What are bitcoin's core tech:

- digital signatures: show information was authored by someone. Underutilzed because key management is hard and still unsolved. Bitcoin doesn't solve key management.
- authenticated data structures: A cryptography hash takes an arbitrary amount of data and returns a short value. You can create hierarchy of data into an hash. for example I can prove an article is part of an encyclopedia
- smart contracts: usually the (boring) rule of "provides a digital signature for this key"
- proof of work: a signature of energy
- mechanical real-time audit: mechanical means automatic, pretty ineficcent but computer pretty fast.

Together, they fight crime.
Dispute resolution.
being trusted confers market pwoer that new entrants may lack and cretes systemic risks.
machine-to-machine transactions cannot use trusted. Bitcoin could dispute resolution.
Trust even within a company.

new technology, skepticism is jsutified
blockchain is not just a piece of tech, is ac collection of technology
most usefutl when where they can miticate trust. beware _trust laundering_.
must be open source
there is no way to achieve bitcoin in a way the defender have advantage over attacker (like you can usually with cryptography) so we must be aware of incentives that keep the system working.
