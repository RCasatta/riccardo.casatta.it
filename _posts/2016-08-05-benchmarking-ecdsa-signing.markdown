---
layout: post
title:  "Benchmarking ECDSA signing"
---

## Using [secp256k1-node](https://github.com/cryptocoinjs/secp256k1-node)

{% highlight shell %}
Benchmarking: sign
--------------------------------------------------
bindings x 16,793 ops/sec ±1.14% (87 runs sampled)
secp256k1js x 1,518 ops/sec ±1.37% (89 runs sampled)
elliptic x 1,236 ops/sec ±1.52% (88 runs sampled)
ecdsa x 47.98 ops/sec ±1.28% (61 runs sampled)
{% endhighlight %}

## Using [bitcoinj](https://github.com/bitcoinj/bitcoinj)

{% highlight shell %}
Elapsed 10.633 s
Per signature 1.0633 ms
Ops/sec 940.4683532399135
{% endhighlight %}

## Using [python-bitcoinlib](https://github.com/petertodd/python-bitcoinlib)

{% highlight shell %}
Elapsed 3.98730206489563 s
Per signature 3.9873020648956294 ms
Ops/sec 250.7961483038972
{% endhighlight %}
