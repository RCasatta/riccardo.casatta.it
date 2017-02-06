---
layout: post
title:  "Changing my OpenPGP master key"
---

After some thoughts I decided to change my OpenPGP master key.

I created my current keypair without thinking too much about it but now I realize the importance of proper key management, and I expect to use OpenPGP signing and encryption extensively in the future.

The main reasons for the change are:

* The key was created on a device connected to the Internet. The private key remained on such device for a long period of time and even if I haven't evidence of compromise, I could not be sure.
* The key was created with a uid using an email with a DNS that I don't own: gmail.com. I could rely on revoking uid but I prefer to have a single uid.

If I had my key signed by many others with all probability I didn't change my master, but since my old master key isn't widespread I decided to take this step.

Here follows the public statement signed with my old key, my new key, and opentimestamped:

## Public statement

{% highlight shell %}

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I, Riccardo Casatta, am changing my OpenPGP master key.

My old key is identified by the fingerprint:
0C6D AF98 8CD2 CE02 390D  4D6E EFDB B6FD 8C35 0E75

My new key is identified by the fingerprint:
4FE1 A54A 224D 3F6B 6596  BBF8 0002 3405 9CB5 0715

My contact address is riccardo@casatta.it

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfKSXAAoJEFLVRMMXfkU55JMP/0KVq+lje+9YGlXkra543A5K
K/GdKmVvUCO8Eax0DyNs1ZfHoGMg+QY0gpmrlQ/TJHSXI7U4ORhlXMUhXCRko7iz
DZBnMW87yg0DFLsKkjTy0OpwzPw4S/7ST19PutnXY+fuSjgAgwXQzOLlZ73grIQ2
ISCJs3oe4qkPgAQCNuYbmYyMpJaSd0ezKEqY5J2Q5/TeExJZa+zfXJsXNWTBBJU5
BXEObUk5+BZRKKKiN0MpI2ojl2S8IXIOhT0XbB1Jg1ZOyPLkhMMdqXooKauBvuv+
tWNtEomADRag1Yc3/lyslQL7PLiMAs0l8xDPDojGS6o6rG4grLtjJm7UZgW+AzDV
jU9odakSlhLP+ffyvWiRBBwQZ6pt8YLdqQcEWD/O0jrZCo7mziHgVuYEqOoXrj6j
aiU6+SD45dWqm6jqsFQuAwsLj1ZXy+0BJXCKgPSh5NcVE4X1dpYxmbz8/CPZ9zPI
GfeQ/+iLdEBRtHc9g5XB2sLGlWIqmB2QaAUMobqJJk4W5zbj1wZ/ROHJsqY/gVtX
YSs7MhyE+oRA7Vm3K4PDQkaqEdBmIIuZy4HF9AUBwJ4tuhIXveOf2AzjENXmJse4
CLZhLGPGVefm2/4lUlW5w2J8VUgp/CU6S1jxkpJvHzS5PqfDBnNJIF/LUkjRFd5K
MOXJIvsVLvsPDor6qM9O
=Q5SF
-----END PGP SIGNATURE-----
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJYfKbXAAoJEP2YapaeRQOXauIH/0rJ2CCQkmuxUwgdB/CqeNUg
BEEYABj9G49tO0AmhjfEsqh/d5fG90Tmxgn3Q/kl6oDu8AkpY8ObIsZWjr0vxYG8
pZGllAaB8RzmeRrQEVZaP+pSA53zphvE8HsZ1UvjzTpjSacHWKuH3KfuLCmGpWFh
QP5mbNY9dcxMpMsZQ88HRqTeTjwMh01nNxbk2Isp6mrVX0VJRdzEMbbLIX+UH98Q
Ya2myZ2JfEyShkzXpFhlheLs7AeuAE8G1WzAPn3Liu6OlATOmWE9p43b39jmCkbE
MkX9/jJYbnnrEP8VqXyaj+Ub53d2NVu6wAiDZNnQ/wOK6ra4GcmLGPFul4N38qY=
=ehvj
-----END PGP SIGNATURE-----
-----BEGIN OPENTIMESTAMPS PROOF-----

AQEAT3BlblRpbWVzdGFtcHMAAFByb29mAL+J4uiE6JKUAQgUIQqR5SUfMunhBFoi
8zZG3igIPyAWpG8U6m3XxmkYy/AQk5d015QyWw07auOPevWMewj/8BALnF+PJ8Ry
lmoubNEkDdrqCPEEWHyVz/AIX5rEW0eBAmMAg9/jDS75DI4sK2h0dHBzOi8vYm9i
LmJ0Yy5jYWxlbmRhci5vcGVudGltZXN0YW1wcy5vcmfwEClaxm0rZgHxfCb12mLb
2woI8QRYfJXP8AjuYZYo9ajoTP8Ag9/jDS75DI4uLWh0dHBzOi8vYWxpY2UuYnRj
LmNhbGVuZGFyLm9wZW50aW1lc3RhbXBzLm9yZwjxrwEBAAAAAXDQdGX8HGuTsEr2
iQmo0NRZqvon2p8fybcpnkuSI+TSAAAAAElIMEUCIQDIpvqzoFZWaJ7C+WD8Asvq
ZOv+RUeDyjdiajz/k68L+wIgH5ogH7ironij6UNSkBpaiDF52znFnGg6n/Iw65Ka
a9EB/f///wJ72kUAAAAAACMhAgOV5s6VLw7SbsRCeBTJ7GIwtTCAPRlTLO+s6ws1
egLlrAAAAAAAAAAAImog8ATB1wYACAjxII9pK8wTdhCiCogGh7IItMx6MxGY6zCC
xGjPyM2Ncvy4CAjxINd8t54oWHA+jPwD2PI1ZxPbrOfH6jGT6o5y2Qh53y2JCAjx
ILylw3BTmXnhcWzHb0oFKs23CDPMqnMgQRJqGMXxUsb2CAjwIBiji2B1SgVedtYl
XBibyC7kgwOPRPa1RUjB5TfiDl4lCAjxIOVR2VgkWjL2eyllC0WKob9ohzsEnVA4
huAnknLuXDMnCAjxILovy7+IDCKZTLAshvyR9+AZg9iLZRCo7/5jihqAv+0xCAjw
IHELpad+WZe0Im+PAzWonND0TsW/AatgXwu7OE4SZUnvCAjxINY4gUq7C57hn2+X
hXZCmMjJdBTsnNnfXqbvxqRCHUjxCAjxIIajF687XIq81Xb/YkCPZhnVIW6kwYbo
UKOqKIpIqVKaCAjwIG2EpmWewFQPgsFJS+iG+c7j71zFuD3uWqdN5WIXejcyCAjx
IOWEa4dpm0jVAWq4DWiXktRnTkaIk7hvwpBHaFYat14CCAgABYiWDXPXGQEDwq8b
-----END OPENTIMESTAMPS PROOF-----

{% endhighlight %}



## My New Public Key

[Public key](/content/000234059CB50715.pub)
