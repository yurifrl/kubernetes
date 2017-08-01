console.log("=================== PRODUCER ===================")

var Producer = require('Prozess').Producer;

var producer = new Producer('social', {host : 'localhost'});
producer.connect();
console.log("producing for ", producer.topic);
producer.on('error', function(err){
  console.log("some general error occurred: ", err);
});
producer.on('brokerReconnectError', function(err){
  console.log("could not reconnect: ", err);
  console.log("will retry on next send()");
});

setInterval(function(){
  var message = { "thisisa" :  "test " + new Date()};
  producer.send(JSON.stringify(message), function(err){
    if (err){
      console.log("send error: ", err);
    } else {
      console.log("message sent");
    }
  });
}, 1000);
