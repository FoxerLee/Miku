'use strict';
var AV = require('avoscloud-sdk')

//function sleep(d){
//	for(var t = Date.now();Date.now() - t <=d;);
//}

var timer;


$.ready(function (error) {
    if (error) {
        console.log(error);
        return;
    }

    $('#led-r').turnOn();
    console.log("about to initialize av apis");
//    AV.initialize("BpldTJLegnrNVnYagMagJhzp-gzGzoHsz", "bC0cJzbPT2lzKclj2gqYYIUD");  the leancloud of Sixaps's demo
    AV.initialize("Axt4dgt9e75IXmYip6UkEM1S-gzGzoHsz", "C0IDutCBftqrMsV3C2zA44fD");
	console.log("av apis initialized");
	var LeafObject = AV.Object.extend('LeafObject');

    var dht = $('#dht');
	var lightSensor = $('#light-sensor');
	console.log("Identify complete");
	
	timer = setInterval(function(){
	
    var Leaf = new LeafObject();
	
	Leaf.set('name','Sixaps');
	dht.getTemperature(function (error, temperature) {
		if(error){
			console.error(error);
			return;
		}
		
		Leaf.set('Temperature',temperature);
		console.log('Temperature:',temperature);
	});
		
	dht.getRelativeHumidity(function (error, humidity){
		if(error){
			console.error(error);
			return;
	 	}
		
		Leaf.set('Humidity',humidity);
	 	console.log('Humidity:',humidity);
	    Leaf.save().then(function(record) {console.log('save start record with objectId: ' + record.id);
        }, function(err) {
	    console.log('failed to create start record. bcz: ' + err.message)
        });
        console.log("data saved");	
	});
	
	lightSensor.getIlluminance(function(error,value){
		if(error){
			console.error(error);
			return;
		}
		Leaf.set('Illuminance',value);
		console.log('Illuminance:',value);
		
	})
    },5000);
	
		
	
	
	
});

$.end(function () {
    $('#led-r').turnOff();
});
