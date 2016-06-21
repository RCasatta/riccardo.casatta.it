---
layout: post
title:  "Trusted Address"

---

After reading [Thinking About Smart Contract Security](https://blog.ethereum.org/2016/06/19/thinking-smart-contract-security/) I was upset...

* Programming and checking smart contracts is like managing nuclear reactors
* All the bad smart contracts are getting the highlights.

I would like to give my two cents for trying to build a better ecosystem, the idea is pretty simple, a smart contract tracking trust between ethereum addresses.

It's just a big sparse matrix where rows and columns are ethereum addresses.

The following is the smart contract deployed at `0xd9877b432759354b896d0ce0caefec3dc2ff2dba` ([github](https://github.com/RCasatta/trusted-address/blob/master/trustedaddress.sol), [interface](https://github.com/RCasatta/trusted-address/blob/master/trustedaddress.sol.interface)):

{% highlight shell %}
contract TrustedAddress {

    address[] voters;
    mapping(address => address[]) votes;
    mapping(address => mapping(address => bool)) votesMap;

    function voteNo(address voteFor) {
        votesMap[msg.sender][voteFor] = false;
    }

    function voteYes(address voteFor) {
        var voter   = msg.sender;
        var myVotes = votes[voter];

        if (myVotes.length == 0) {
            voters.push(voter);
        }

        if (!votesMap[voter][voteFor]) {
            myVotes.push(voteFor);
        }

        votesMap[voter][voteFor] = true;
    }

    function totalVoters() constant returns (uint) {
        return voters.length;
    }

    function votersOfIndex(uint index) constant returns (address) {
        return voters[index];
    }

    function totalVotesOf(address voter) constant returns (uint) {
        return votes[voter].length;
    }

    function votesOf(address voter, uint index) constant returns (address, bool) {
        address voted = votes[voter][index];
        return (voted, votesMap[voter][voted]);
    }

}
{% endhighlight %}
Solidity version: 0.3.5-5917c8e7/Release-Emscripten/clang/Interpreter

Alice's address is `0xA`, Alice checked the smart contract at address `0xB` and she think it's good and without bugs.
She express her trust in the contract by invoking the contract function:

```
trustedaddress.voteYes('0xB',{from:eth.accounts[0]});
```

The trust matrix could be iterated by the utility constant function `totalVoters(), votersOfIndex(uint index), totalVotesOf(address voter) and votesOf(address voter, uint index)`.

An external script could build the recommendation matrix for easily querying the most trusted contracts.

### Questions for the recommendation matrix

* If I trust only some of the address giving votes the recommendation matrix could also give quick answer question like, since I trust Bob, Charlie and Franco, is contract `0xC` trustable?
* Other interesting question are, who trusted contracts that turns out to be buggy?

### Possible improvements

* Should we consider using signed integer (int8) for votes instead of boolean? This way we are not anymore a binary matrix and negative judgements can also be expressed. The recommendation matrix could be build in a binary form just by considering `M(i,j)>0`
* Should we consider adding a comment/hash of comments on judgements?
  * Writer personal opinion think to keep it simple, maybe could be addressed elsewhere, even out of the blockchain
* What about a more catchy name? Is *Trusted Address* good?
