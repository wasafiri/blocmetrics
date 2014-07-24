var clientIP;

var Blocmetrics_track = {}
Blocmetrics_track.postEvent = function() {
  if(!clientIP) {
    var script = document.createElement( "script" );
    script.type = "text/javascript";
    script.src = "http://ip-api.com/json/?callback=getIP";
    document.head.appendChild(script);
  }
else {
  getIP();
}
}

function getIP(data) {
  if(data) clientIP = data.query;

  var bm_event = {
    name: "Test",
    ip_address: clientIP,
    web_property_id: "INSERT YOUR ID HERE",
    action: "Page View"
  };

  var bm_request = new XMLHttpRequest();
  bm_request.open("POST", "http://localhost:3000/events.json", true);
  bm_request.setRequestHeader('Content-Type', 'application/json');
  bm_request.onreadystatechange = function() {};
  bm_request.send(JSON.stringify(bm_event));
};