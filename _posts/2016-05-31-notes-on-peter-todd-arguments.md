---
layout: post
title:  "Notes on Peter Todd's arguments"

---

The following are just some notes I am taking before Peter Todd is coming to blokchainlab explaining some of his works

## DEX

[Peter's Document](https://github.com/WebOfTrustInfo/ID2020DesignWorkshop/blob/master/topics-and-advance-readings/DexPredicatesForSmarterSigs.md)

DEX is a Lisp like language for formal specification of signature & co. stuff (different from bitcoin scripting cause the latter is an implementation)


## TXO Commitments

[Peter's Document](https://petertodd.org/2016/delayed-txo-commitments#fn:pettycoin-utxo)

- Growing UTXO (now 1.3GB on disk, more in memory)
- Using UTXO for non-bitcoin-related tx like:
  - timestamping (doing non prunable has advantage of being secure node will mantaining data)
  - Anti replay in key rotation piggyback ???
- use Merkle Mountain Range MMR to store all TXO
- tx accompanied by TXO commitment proof (proof could be created by full node not necessarily the signer)
- no change or mininimal to wallet
- Commitment merkle db is difficult to mantain ant this is a problem because it is in the latency critical timespace. Using TXO commitment set state of n blocks ago and the live recent UTXO solve this problem. Specifically we have:
 - UTXO set: low latency K:V map of latest txouts
 - STXO set: low latency set created before TXO commitment and spent after
 - TXO journal: FIFO of outputs that need to be marked as spent in the TXO MMR
 - TXO MMR list - prunable ordere list of TXO MMR (cryptographically hashed object store indexed by digest like git ???)


Question for Todd:
- MMR vs Patricia Tree?
- Why TXO instead of UTXO only (maybe because you can't delete on MMR) in the example nodes are updated if spent but in Merkle Mountain Range is stated that the structure is append only


### Merkle Mountain Range

[Document](https://github.com/opentimestamps/opentimestamps-server/blob/master/doc/merkle-mountain-range.md)

- Deterministic
- Indexable
- Insertion ordered

## Committed transaction

Can't find any document written by Peter

[Adam's talk on Fungibility and privacy](http://diyhpl.us/wiki/transcripts/bitcoin-adam3us-fungibility-privacy/)

Giving to the miner a transaction encrypted but the miner can see that is not a double spend, but can't see origin and destination. (???)
After 6 blocks or something the sender reveal the transaction and the miner cannot undone the previous one  without undoing all the work.
