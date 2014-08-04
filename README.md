# Blocmetrics
## An API Tracking Service and Reporting Tool

Blocmetrics will let you track activities on websites.

- Add a website you want to track.
- Insert the js snippet provided below, with your AppID inserted, into the footer of your website.
- Sit back and watch Blocmetrics capture all of your pageviews and make pretty graphs out of them.

# Before using Blocmetrics you must sign up for an account.

## To track a website, use the following js snippet. Insert your AppID under var bm_event.

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
    event: {
      app_id: 1,
      ip_address: clientIP,
      action: "Page View"
    }
  };

  var data = JSON.stringify(bm_event);
  console.log(data)

  var bm_request = new XMLHttpRequest();
      bm_request.open("POST", "http://localhost:3000/events.json", true);
      bm_request.setRequestHeader('Content-Type', 'application/json');
      bm_request.onreadystatechange = function() {};
      bm_request.send(data);
};

## To create an event "by hand" using cURL, customize the following command:

curl -i -H "Accept: application/json" -X POST -d '{"event":{"ip_address":"192.168.1.1"}}' http://localhost:3000/events.json