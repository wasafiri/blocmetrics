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
 });