var clientIP;
window.bm_request = new XMLHttpRequest();

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
    event: {
      app_id: 1,
      ip_address: clientIP,
      action: "Page View"
    }
  };

  var data = JSON.stringify(bm_event);
  console.log(data)

      bm_request.open("POST", "http://localhost:3000/events.json", true);
      bm_request.setRequestHeader('Content-Type', 'application/json');
      bm_request.onreadystatechange = function() {};
      bm_request.send(data);

};