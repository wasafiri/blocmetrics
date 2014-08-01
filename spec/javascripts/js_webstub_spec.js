//= require spec_helper
//= require js_webstub

describe("Blocmetrics#pushEvent", function(){
  it("should register the event", function(){
    var httpMock = jasmine.createSpyObj("httpMock", ["post"]);
    var tracker = new Blocmetrics(httpMock);

    tracker.pageViewed();

    expect(httpMock.post.calls.argsFor(0)).toEqual([
      "/events.json",
      {
        event: {
          app_id: 12736,
          ip_address: "200.1.1.1",
          web_property_id: 100,
          action: "Page View"
        }
      }]
    );
  });
});

// describe("Blocmetrics#getClientIP", function(){
//   it("should fetch the client IP", function(){
//     var ipProvider = jasmine.createSpy('ipProvider').andReturn({ip: '192.168.1.1'});
//     var track = new Blocmetrics.ClientTrack(ipProvider);

//     // call it twice to verify that we're just triggering the IP API just once
//     track.getClientIP();
//     track.getClientIP();

//     // test that we cached the value
//     expect(ipProvider.calls.length).toEqual(1);
//   });
// });

