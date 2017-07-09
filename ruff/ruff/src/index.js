'use strict';
var AV = require('avoscloud-sdk')

var timer;

function sleep(n)
 {
    var start=new Date().getTime();
    while(true) if(new Date().getTime()-start>n) break;
 }

$.ready(function (error) {
    if (error) {
        console.log(error);
        return;
    }

    $('#led-r').turnOn();
    console.log("about to initialize av apis");
    //AV.initialize("Dvkub2eLIXlbDelynl7X6MGH", "LBSzvrBgTeErPiG5gXv1wcre", "gRAL5pQMmpAgx16qn0GSK0T1");
    AV.initialize("BlccrHVYjLsLu50zK3z7MIYq-gzGzoHsz", "8ITxvIc8YjkQC8sTIBe1mPbO");
    
	var LED = $('#KY-016');
	var FY = $('#FC-49');
	
	timer = setInterval(function(){
		
	var table = new AV.Query('message');
	console.log("av apis initialized");
	table.greaterThan('flag2', 0);
	table.descending('createdAt');
	
	table.first().then(function(record){
		var flag = record.get('flag2');
		console.log("Flag:"+flag);
		if(flag == 1)
		{
			LED.turnOn();
			console.log("statu: On");
		}
		else
		{
			LED.turnOff();
			console.log("statu: Off");
		}
	},function(error){
		
	});
	
	
	var table2 = new AV.Query('message');
    table2.greaterThan('flag3',0);
    table2.descending('createAt');

    table2.first().then(function(result){
		var flag3 = result.get('flag3');
		console.log("Flag3:"+flag3);
		if(flag3 == 1)
		{
			FY.isOn(function (error, on) {
            if (error) {
            console.error(error);
            return;
            }
		    FY.turnOn();
			sleep(2000);
			FY.turnOff();
            });
		}
		
	})    
	
    console.log("data saved");
    
	},2000);
	
	$('#led-r').turnOn();
});

$.end(function () {
    $('#led-r').turnOff();
	$('#FC-49').turnOff();
});
