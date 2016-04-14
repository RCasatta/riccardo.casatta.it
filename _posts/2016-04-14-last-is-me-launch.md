---
layout: post
title:  "“Last is me” launch!"
project: /projects/last-is-me/
---

**We are excited to announce the launch of the ["Last is me"](http://lastis.me) lottery!**

<a href="http://lastis.me">
  <img src="{{site.baseurl}}content/images/turtle-clip-art-turtle6.png" width="320">
</a>


### How the lottery works?

<img src="{{site.baseurl}}content/images/last-is-me-example-letters.png" height="326">

The lottery has a price ticket and a duration `A`, when you buy a ticket you become the last player `D` and the countdown `C` is resetted.
When the countdown `D` expire, meaning none bought a ticket during the lottery duration, you get the jackpot `B`!

For more details you could read the [FAQ](http://lastis.me/faq/) on the web site.


### Is this a scam? Are you running away with the jackpot?

The lottery is based on a smart contract written in the [Ethereum](http://ethereum.org) platform, so it is trustless.
Moreover, I developed the [site](http://lastis.me) and the [contract](https://github.com/lastisme/lastisme.github.io/blob/master/contracts/lastisme.sol) then I sold the project and transferred the lottery ownership to a DAO running In [another](https://github.com/lastisme/lastisme.github.io/blob/master/contracts/association.sol) Ethereum smart contract.


### Rational

When building a lottery on a smart contract there are two important properties to keep in mind:

* It's impossible to have a source of randomness inside a deterministic virtual machine.
* Any lottery should address the [front running](https://en.wikipedia.org/wiki/Front_running) problem.

One possible solution to overcome this problem is to use a commit/reveal scheme.
Lottery partecipants bet on numbers which are hided from anyone but them.
The lottery expires, partecipants reveal the number they are committed to. All this numbers are used together to define a randomness.
One of the number is the nearest of the randomness and the lottery winner. As you can see the randomness is outside the virtual machine and miners could not do front running cause when the lottery expires they don't know who is the winner.
This solution is doable but require many interaction with the contract.

Another solution, the one upon which “Last is me” is based is to use willingness of players to buy ticket as a source of randomness.
Miners and other players don't know if someone is going to buy another ticket and resetting the countdown. When the lottery is expiring, a miner could front run refusing to mine a block but it isn't a worthful attack because some other miner is expected to mine anyway.
This solution is simple and elegant so I decided to build it!

## Are you gonna win the jackpot ?

<a href="http://lastis.me">Try</a> to be the last!

> The **last** is the winner!
