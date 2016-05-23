---
layout: post
title:  "Weather condition correlated to solar production"

---

This is a data collecting test to correlate data from yahoo weather API and my solar production

<p><strong>location: </strong><span id="location"></span></p>
<p><strong>units: </strong><span id="units"></span></p>
<p><strong>atmosphere: </strong><span id="atmosphere"></span></p>
<p><strong>astronomy: </strong><span id="astronomy"></span></p>
<p><strong>item: </strong><span id="item"></span></p>

<script>
  var callbackFunction = function(data) {

    var channel = data.query.results.channel;
    var item = channel.item;
    item.forecast = undefined;
    item.description = undefined;

    document.getElementById('location').appendChild(  document.createTextNode(JSON.stringify(channel.location) ) );
    document.getElementById('units').appendChild(  document.createTextNode(JSON.stringify(channel.units) ) );
    document.getElementById('atmosphere').appendChild(  document.createTextNode(JSON.stringify(channel.atmosphere) ) );
    document.getElementById('astronomy').appendChild(  document.createTextNode(JSON.stringify(channel.astronomy) ) );
    document.getElementById('item').appendChild(  document.createTextNode(JSON.stringify(item) ) );

  };
</script>

<script src="https://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid = 20131444 and u='c'&format=json&callback=callbackFunction"></script>
