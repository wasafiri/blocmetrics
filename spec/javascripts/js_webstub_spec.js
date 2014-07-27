//= require spec_helper
//= require js_webstub

describe("Blocmetrics_track#postEvent", function() {
  it("posts to events.json", function() {
    var sent = false;
    XMLHttpRequest.prototype.send = function() {
      sent = true;
    }
    Blocmetrics_track.postEvent();

    setTimeout(function() {
      sent.should.equal(true);
    }, 500);
  });

  it(“posts proper payload to events.json”, function() { })

});

// $.ajax({url:"http://localhost:3000/events.json",Content-Type: 'application/json',type:"POST",
//         data:"{'event':{'app_id':1, 'ip_address':'98.125.170.140', 'action':'Page View'}}"}
//        , success(result){
//        var data=result.d;
//        };