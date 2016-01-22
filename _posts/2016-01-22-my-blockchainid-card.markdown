---
layout: post
title:  "My blockchain ID card"
project: /projects/eternity-wall/
---

I am considering to add the blockchain Id card to the [Eternity Wall](http://eternitywall.it) web site, in the profile page...

This is my card:

<div data-passname="rcasatta"></div>

<script type="text/javascript">
(function(doc){
    var js, id = 'onenamejs', ref = doc.getElementsByTagName('script')[0];
    if (doc.getElementById(id)) {return;}
    js = doc.createElement('script'); js.id = id;
    js.src = 'https://s3.amazonaws.com/onename/onename-cards.js';
    doc.head.appendChild(js);
    var link, cssId = 'onenamecss';
    if (doc.getElementById(cssId)) {return;}
    link = document.createElement('link');
    link.id = cssId; link.rel = 'stylesheet'; link.type = 'text/css';
    link.href = 'https://s3.amazonaws.com/onename/onename-cards.css';
    doc.head.appendChild(link);
}(document));
</script>

That would appear in my [profile](http://eternitywall.it/from/1Fk2QiTmL7k6fmE8x9MgZiYA2nj1m38GJv)
