---
layout: post
title:  "Trusted Address"

---

After reading [Thinking About Smart Contract Security](https://blog.ethereum.org/2016/06/19/thinking-smart-contract-security/) I was upset...

* Programming and checking smart contracts is like managing nuclear reactors
* All the bad smart contracts are getting the highlights.

I would like to give my two cents for trying to build a better ecosystem, the idea is pretty simple, a smart contract tracking trust between ethereum addresses.

It's just a big sparse matrix where rows and columns are ethereum addresses.

The following is the smart contract deployed at `0x4d186c43198b3505a41d924a6e2aa6e69d41e978` on morden (testnet) ([github](https://github.com/trustedaddress/trustedaddress/blob/master/trustedaddress.sol), [interface](https://github.com/trustedaddress/trustedaddress/blob/master/trustedaddress.sol.interface)):

{% highlight shell %}
contract TrustedAddress {

    address[] votersArray;
    mapping(address => address[]) votesOf;
    mapping(address => mapping(address => int8)) votesMapOf;

    //The function takes as an argument the address we want to vote for and
    //a vote.

    function vote(address voteFor, int vote) {
        address currentVoter   = msg.sender;

        //If the currentVoter address hasn't voted before, add it to the votersArray
        if (votesOf[currentVoter].length == 0) {
            votersArray.push(currentVoter);
        }
        //If no vote was casted toward this address, add vote in the voter's votes array
        if (votesMapOf[currentVoter][voteFor] == 0) {
            votesOf[currentVoter].push(voteFor);
        }
        // Add vote to the mapping
        if(vote == 0) {
            votesMapOf[currentVoter][voteFor] = 0;
        } else if (vote > 0) {
            votesMapOf[currentVoter][voteFor] = 1;
        } else {
            votesMapOf[currentVoter][voteFor] = -1;
        }
    }

    function totalVoters() constant returns (uint) {
        return votersArray.length;
    }

    function voterOfIndex(uint index) constant returns (address) {
        return votersArray[index];
    }

    function totalVotesOf(address currentVoter) constant returns (uint) {
        return votesOf[currentVoter].length;
    }
    
    // Given an address and an index, it will return the i-th casted vote by that address
    function votesMap(address currentVoter, uint index) constant returns (address, int8) {
        address votedAddr = votesOf[currentVoter][index];
        return (votedAddr, votesMapOf[currentVoter][votedAddr]);
    }

    /* If an address has casted multiple votes toward the same address,
    they will remain in its vote array. This method can help clean the matrix
    */
    function deleteEquals(address currentVoter, uint index1, uint index2) {
        address[] myVotes = votesOf[currentVoter];
        address add1 = myVotes[index1];
        address add2 = myVotes[index2];
        if(add1 == add2 && add1 != 0 && index1 != index2) {
            myVotes[index1] = myVotes[myVotes.length-1];
            myVotes.length--;
        }
    }

}
{% endhighlight %}
Solidity version: 0.3.5-5917c8e7/Release-Emscripten/clang/Interpreter

Alice's address is `0xA`, Alice checked the smart contract at address `0xB` and she think it's good and without bugs.
She express her trust in the contract by invoking the contract function:

```
trustedaddress.vote('0xB',1,{from:eth.accounts[0]});
```

The trust matrix could be iterated by the utility constant function `totalVoters(), votersOfIndex(uint index), totalVotesOf(address voter) and votesOf(address voter, uint index)`.

An external script could build the recommendation matrix for easily querying the most trusted contracts.

### Questions for the recommendation matrix

* If I trust only some of the address giving votes the recommendation matrix could also give quick answer question like, since I trust Bob, Charlie and Franco, is contract `0xC` trustable?
* Other interesting question are, who trusted contracts that turns out to be buggy?

### Possible improvements

* Should we consider using signed integer (int8) for votes instead of boolean? This way we are not anymore a binary matrix and negative judgements can also be expressed. The recommendation matrix could be build in a binary form just by considering `M(i,j)>0`
  * *UPDATE*, this improvement is been accepted and already implemented in the code.
* Should we consider adding a comment/hash of comments on judgements?
  * Writer personal opinion think to keep it simple, maybe could be addressed elsewhere, even out of the blockchain
* What about a more catchy name? Is *"Trusted Address"* good?
