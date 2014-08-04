window.Blocmetrics = function(engine){
  this.pageViewed = function() {
    engine.post("/events.json", {
      event: {
        app_id: 12736,
        ip_address: "200.1.1.1",
        web_property_id: 100,
        action: "Page View"
      }
    });
  };
};
