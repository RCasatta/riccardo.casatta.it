---
layout: post
title:  "Notes on Peter Todd's arguments"

---

The following are just some notes I am taking before Peter Todd is coming to blokchainlab explaining some of his works

## DEX

[Peter's Document](https://github.com/WebOfTrustInfo/ID2020DesignWorkshop/blob/master/topics-and-advance-readings/DexPredicatesForSmarterSigs.md)

DEX is a Lisp like language for formal specification of signature & co. stuff (different from bitcoin scripting cause the latter is an implementation)

s expression is superior for very branchy script

checksig <pubkey> <sig> <msg>
is to prove the conditions you are not using

is_block_hash_valid

for example telling DNS provider to update your record only if this signatures are provided

transaction tree without blockchain just state transition

My conclusion is: **the signer provide not just the signature but they way to verify it**


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

## Publishing text

[Python example](https://github.com/petertodd/python-bitcoinlib/blob/master/examples/publish-text.py)

## OpenTimestamps

[server](https://github.com/opentimestamps/opentimestamps-server)
[client](https://github.com/opentimestamps/opentimestamps-client)
[python-opentimestamps](https://github.com/petertodd/python-opentimestamps)

### OpenTimestamps server Example

Start an otsd server first:

    ./otsd

The directory ~/.otsserver will be created to store the submitted timestamps.

Now submit a timestamp to the server:

    ./client/ots submit README.md

This creates a README.md.ots file.

Sign the digests on the server with GPG:

    ./client/ots sign <fingerprint>

where fingerprint is the fingerprint of a key that you can sign with. This need
to be the full fingerprint, not the short 8-character long key id.

Now complete the timestamp:

    ./client/ots complete README.md.ots

Verify it:

    ./client/ots verify README.md

You can see what is actually stored in the timestamp in human readable format too:

    ./client/ots jsondump README.md.ots

### Python OpenTimestamps example

[ots](https://github.com/petertodd/python-opentimestamps/blob/master/ots)


#### Stamp

* get `filenametohash` as paramter
* Hash a file, optionally adding a nonce with sha256
* create a file `F1` with name `<filenametohash> + 'ots.pending'`
* create a bitcoin address from the created hash  (unspendable UTXO spam why not opret? because it is prunable?)
* send dust to it from bitcoin core and get txid
* write to `F1` -> `nonce`, `txid` and `addr` (Why not hash?)


#### Complete

* get `filenamepreviouslystamped` as parameter and read `nonce`, `txid` and `addr`
* get raw tx of txid, if not confirmed exit
* calc `path` = Path(path0,path1,path2) (prefix tree? what for???)
 * path0 is ???
 * path1 is from msg to txid
 * path2 is from txid to merkleroot (eventually extractable from block, but faster cause if storing this you only need block header)
* create `sig` from BlockHeaderSig from block header (why ???)
* `stamp` = Stamp(`path`,`sig`) write to `.ots`


#### Verify

* get `filenamepreviouslycompleted` as parameter and read `timestamp` and `path`
* `hash`=sha256(`filenamepreviouslycompleted`)
* verify stamp is in the block (check stamp.verify) why did not check transaction
*
