require("leaflet")
require("leaflet.markercluster")

var greenIcon = L.icon({
    iconUrl: coin_path,
    shadowUrl: 'coin-shadow.png',
    iconSize:     [15, 45],
    shadowSize:   [15, 45],
    iconAnchor:   [7, 45],
    shadowAnchor: [4, 62],
    popupAnchor:  [0, -45]
});

var mymap = L.map('mapid', {center: [51.505, -0.09], zoom: 3});

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1Ijoibm90dGhlcG9pbnQiLCJhIjoiY2tlbHI0NWszMG1jNTJzcHc2ZmNpaTh6YyJ9.ParjYMqc6DUwCEGo29nh_A'
}).addTo(mymap);


var markers = L.markerClusterGroup();

for (i=0; i < coins.length; i++) {
	var header = "<h3>" + coins[i]["title"] + "</h3>"
  var body = "<p>" + coins[i]["desc"] + "</p>"

  var marker = L.marker([coins[i]["y"], coins[i]["x"]], {icon: greenIcon})
  marker.bindPopup(header + body + coins[i]["link"])
  markers.addLayer(marker)
}

mymap.addLayer(markers);
