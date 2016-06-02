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

create a pay to script hash address with a script containing a message long up to 500 chars

[Python example](https://github.com/petertodd/python-bitcoinlib/blob/master/examples/publish-text.py)


## OpenTimestamps

[server](https://github.com/opentimestamps/opentimestamps-server)

[client](https://github.com/opentimestamps/opentimestamps-client)




### Python OpenTimestamps example

[python-opentimestamps](https://github.com/petertodd/python-opentimestamps)

[ots](https://github.com/petertodd/python-opentimestamps/blob/master/ots)

## Example stamp

starting from [this file](https://raw.githubusercontent.com/opentimestamps/opentimestamps-client/879cec46c2ba34fa7422c993ef10c27cab1e9de7/ots)

{% highlight shell %}
./ots stamp ots # create a bitcoin tx and `ots.ots.pending`

# after some time

./ots complete ots.ots.pending # create the stamp `ots.ots`

./ots verify ots.ots
DEBUG:root:Hashed ots -> 78e4400495668c2984752aaafe06c28e64bf6b4182d9bd976aae48bb294121ea
INFO:root:Success! ots was created on or before 2016-06-02 12:34:06
{% endhighlight %}



#### Stamp

* get `filenametohash` as paramter
* Hash a file, optionally adding a nonce with sha256
* create a file `F1` with name `<filenametohash> + 'ots.pending'`
* create a bitcoin address from the created hash  (unspendable UTXO spam why not opret??? because it's prunable?)
* send dust to it from bitcoin core and get txid
* write to `F1` -> `nonce`, `txid` and `addr` (Why not hash?)


#### Complete

* get `filenamepreviouslystamped` as parameter and read `nonce`, `txid` and `addr`
* get raw tx of txid, if not confirmed exit
* calc `path` = Path(path0,path1,path2) (it's a list of operation) (a path operation is an hash with eventually a prefix or a suffix)
 * path0 is related to the start and the nonce
 * path1 is from msg to txid, the tree is
 * path2 is from txid to merkleroot (eventually extractable from block, but faster cause if storing this you only need block header)
* get `sig` from BlockHeaderSig from block header (hex of the header)
* `stamp` = Stamp(`path`,`sig`) write to `.ots`


#### Verify

* get `filenamepreviouslycompleted` as parameter and read `timestamp` and `path`
* `hash`=sha256(`filenamepreviouslycompleted`)
* verify stamp is in the block (check stamp.verify)



###### ots.ots.pending
{% highlight shell %}
{
  "txid": "8dc3978187d3002d296dfe6f0c81e7678064c53b8a0cf400805efc177fea6825",
  "nonce": "1a2599c68b10dc0e2429af84eb6d84d7608d6fe65783a0e708fe8f1a1aa6cb06",
  "addr": "1KY14B6GwB2stArhxMopNGw8qcYeiVkjbX"
}
{% endhighlight  %}

###### ots.ots
{% highlight shell %}
[
  [
    [
      "sha256",   # hash the input file `ots` getting -> 78e4400495668c2984752aaafe06c28e64bf6b4182d9bd976aae48bb294121ea
      "",
      ""
    ],
    [
      "sha256",  # hash the result of the previous (RPS) stamp prepended by the following (which is the nonce)
      "1a2599c68b10dc0e2429af84eb6d84d7608d6fe65783a0e708fe8f1a1aa6cb06",
      ""
    ],
    [
      "ripemd160",  # hash RPS with ripemd160 finding the address used in the bitcoin tx
      "",
      ""
    ],
    [
      "sha256",   # hash RPS prepended and suffixed by the following which are the missing part of the bitcoin tx
      "0100000001545998db8b1958d9f2851f2f60011726423a7b559b69b106368c936050e91eff010000006a47304402202e699adf61fbed11fd44d777f719b4bba7427d6168e53431d172ca527dc34a720220731a425efbde3778fc27e5c511cba87ae300694f5ef5b9b154e0d9b1a16cfa190121034985ce697016d2aea060dd142886c875bb834d1fbe919e62529f49e23ae0005ffeffffff0270170000000000001976a914",
      "88ac8bc80200000000001976a914d568233da83dd0c901982af78609a8c2af3f57af88acc0520600"
    ],
    [
      "sha256",  # hash RPS againg finding tx id (I suppose)
      "",
      ""
    ],
    [
      "sha256",  # the next step are for finding the bitcoin block merkle root
      "d4079bd871b948aac583624213a70ee2d13a0cd047c69826ede68f1e0f48f8e6",
      ""
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "517d1c48146bd9339e5976c040a4cc6538159dd0c7dde0e0dcd3744cfe786e27"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "1c19ecb00323dc30abcf164ae1ca9a3bec450a0d54480ab8c41bef4a895e7a76",
      ""
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "d701150b9b68e7c4f8313b9175b1b6d09d580baf169bc1ac5df56ba7b4457e20"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "42c8f3b497cb54f7c841eae8dd0635f54a9177c5568c52237f8eab2b30b235a0"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "600f4259d4a321a54d962bfff9a3fae3d41563fb58ed00ca815dc84c643b7fc8",
      ""
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "72f449e5cf1ec52af3323ee1ae2e6016e1f1a4f538250d73fdbf6feaed6f758e"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "ff67072d9c67c9bf9949766d1a89ee8ba91df85d8f367d9fda5cd4e916f089fa"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "e9c4cdecf23a3787f0062a79e599a851d0d0d03d6c0f4ec1a5ab74c58eb2b8c8"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "57276146c3621e9db77e20b2faf625e53d935436aee0391369cd81932093d9a6"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "",
      "aa9900285ae3dbb30024761c48ac1dda8cc04ef14b30341b342ad9f44cecdd43"
    ],
    [
      "sha256",
      "",
      ""
    ],
    [
      "sha256",
      "74079e5c0bc140e22ccc6a494dc6a402fd375cf198b099d0b0e9090e6646809e",
      ""
    ],
    [
      "sha256",   # After this last operation you have the merkle root ???
      "",
      ""
    ]
  ],
  [
    "block_header",
    "bitcoin-mainnet",
    "04000000fb312a4a8035922bb03a1d53a400f5aef6706eae843b7d040000000000000000",
    "9e0b50573684051839660b0d"
  ]
]
{% endhighlight %}


{% highlight python %}
import binascii
import hashlib

hash="000000000000000003fd7c8a69d24a3dde46159b5dd3ed705a06dfce61153b3f"
prefix="04000000fb312a4a8035922bb03a1d53a400f5aef6706eae843b7d040000000000000000"
suffix="9e0b50573684051839660b0d"
root="c8dcb6e6fc4556501228a44b9bdd25463ca09a2f4174d20d0d079dcd79cad96a"  # from blockchain.info
rootrev=bytearray(binascii.unhexlify(root))
rootrev.reverse()
rootstringrev=binascii.hexlify(rootrev).decode()
B=prefix+rootstringrev+suffix
Bbin=binascii.unhexlify(B)
hBbin = hashlib.sha256(hashlib.sha256(Bbin).digest()).digest()
binascii.hexlify(hBbin) # "3f3b1561cedf065a70edd35d9b1546de3d4ad2698a7cfd030000000000000000"
{% endhighlight %}

04000000fb312a4a8035922bb03a1d53a400f5aef6706eae843b7d040000000000000000c8dcb6e6fc4556501228a44b9bdd25463ca09a2f4174d20d0d079dcd79cad96a9e0b50573684051839660b0d
