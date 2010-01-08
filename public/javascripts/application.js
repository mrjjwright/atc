// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



var day_format = "ddd, MMM d";
var monday, thisMonday, today, weekOf;
var MAX_REG_SPOTS = 8;
var MAX_CLIMBING_SPOTS = 3;
var LAST_FULL_NAME_COOKIE = "atc_last_full_name_cookie";
var PREV_NAMES_COOKIE = "atc_prev_names_cookie";

//enable js for jquery, needed for rails
jQuery.ajaxSetup({
        'beforeSend': function(xhr) {
            xhr.setRequestHeader("Accept", "text/javascript")
        }
    });


	//extend jquery with put
    function _ajax_request(url, data, callback, type, method) {
        if (jQuery.isFunction(data)) {
            callback = data;
            data = {};
        }
        return jQuery.ajax({
            type: method,
            url: url,
            data: data,
            success: callback,
            dataType: type
        });
    }

    jQuery.extend({
        put: function(url, data, callback, type) {
            return _ajax_request(url, data, callback, type, 'PUT');
        },

        delete_: function(url, data, callback, type) {
            return _ajax_request(url, data, callback, type, 'DELETE');
        }    });


$(document).ready(function() {

 //if we are on the calendar page load the calendar and set up the handlers
 if ($("#weekly_calendar").length != 0){
	//set monday to this week's monday
		
	 monday = Date.today().last().monday();
	var today = Date.today().toString("ddd");
	if (today == "Sun") {
		monday = Date.today().next().monday();
	} 
	if (today == "Mon") {
		monday = Date.today();
	}
	
	 thisMonday = monday.clone();
	 resetCal();
	 loadCalData();
	 
	
	//navigate back one week
	$("#prevWeek").click(function() {
		//set monday back one week
		monday = monday.addDays(-7).clone();
		resetCal();
		loadCalData();
	});
	
	//navigate back one week
	$("#nextWeek").click(function() {
		//set monday back one week
		monday = monday.addDays(7).clone();
		resetCal();
		loadCalData();
	});
	
	//add a user to a reg time slot
	$(".add_reg_spot").click(function() {
		addSpot($(this), false);
	});

	//add a user to a climbing time slot
	$(".add_climbing_spot").click(function() {
		addSpot($(this), true);
	});

	//delete a calendar event
	$(".delete").livequery("click", function () {
		var answer = confirm("Are you sure you want to remove yourself from this timeslot?");
		if (answer) {
			var timeSlotId = $(this).parent().attr("id");
			$.ajax({url:"time_slots/" + timeSlotId,
				type: "POST",
				data: "_method=delete",
				success: function () {
					loadCalData();
				}
			});
			
		}
	});	
	
	$(".delete").livequery("mouseover", function () {
		$(this).parent().toggleClass("selected");
	});
	
	$(".delete").livequery("mouseout", function () {
		$(this).parent().toggleClass("selected");
	});

 }
});


function addSpot(timeSlot, isClimbing) {
	
	if (!$.cookies.test()) {
		alert("This calendar requires the use of cookies.  Please enable them in your browser.");
		return;
	}
	
	var fullName = "";
	//see if the  full name can be retrieved from a cookie
	//this is so that the user doesn't have to reenter their name every time 
	//http://code.google.com/p/cookies/wiki/Documentation
	if ($.cookies.get(LAST_FULL_NAME_COOKIE) != null){
		fullName = $.cookies.get(LAST_FULL_NAME_COOKIE);
	}
	fullName = prompt("Please enter your full name.", fullName);
	if (fullName != null) {
		var timeSlotId = timeSlot.parent().parent().attr("id");
		//Search to see if the user is already in the time slot
		if ($("#" + timeSlotId + " .people:contains(" + fullName + ")").length > 0) {
			alert("You are already scheduled in that time spot");
			return;
		}
		var workoutType = isClimbing ? "climbing" : "regular";
		var params = {week_of:  weekOf, full_name: fullName, time_slot:  timeSlotId, workout_type: workoutType};
	
		$.post("time_slots", params, function() {
			loadCalData();
		});
	
		//set the full name in a cookie on the user's browser
		//so that the user doens't have to enter it in every time
		$.cookies.set(LAST_FULL_NAME_COOKIE, fullName, {path: '/', hoursToLive: 10000000});
		
		//also save the last full name in a comma separated list of names that have been used on this browser
		//we will display a delete link by these names
		//this is in case more than one user shares the browser, e.g. a husband and wife
		var prevNamesCookie = $.cookies.get(PREV_NAMES_COOKIE);
		if (prevNamesCookie == null) {
			prevNamesCookie = "";
		} 
		//split the string into an array
		var prevNamesList = prevNamesCookie.split(",");
		//search for the existence of this name
		if ($.inArray(fullName, prevNamesList) == -1) {			
			prevNamesCookie += fullName + ",";
			$.cookies.set(PREV_NAMES_COOKIE, prevNamesCookie, {path: '/', hoursToLive: 10000000});
		}
	}
}


function resetCal() {
	var tuesday, wednesday, thursday, friday, today, week;
	var monday_ordinal, tuesday_ordinal, wednesday_ordinal, thursday_ordinal, friday_ordinal;

	//reset the calendar 
	$(" .people").empty();
	$(".add_reg_spot").html(MAX_REG_SPOTS + " regular left");
	$(".add_climbing_spot").html(MAX_CLIMBING_SPOTS + " climbing left");
    $(".day").removeClass("today");

    //load the days
	var monday_clone = monday.clone();
	weekOf = monday.toString("MMM d yyyy")
	tuesday = monday.addDays(1).clone();
	wednesday = monday.addDays(1).clone();
	thursday = monday.addDays(1).clone();
	friday = monday.addDays(1).clone();
	monday = monday_clone;
	
	$("#monday").html(monday.toString(day_format)+monday.getOrdinal());
	$("#tuesday").html(tuesday.toString(day_format)+tuesday.getOrdinal());
	$("#wednesday").html(wednesday.toString(day_format)+wednesday.getOrdinal());
	$("#thursday").html(thursday.toString(day_format)+thursday.getOrdinal());
	$("#friday").html(friday.toString(day_format)+friday.getOrdinal());
	 
	 
	 //highlight today if on the right week
	if (thisMonday.toString() == monday.toString()) {
		 //we are on the right week
		 //now see if we are in mon-friday
		 var today = Date.today().toString("ddd");
		 if (today == "Mon" || today == "Tue" || today == "Wed" || today == "Thu" || today == "Fri") {
			 $("." + today).addClass("today");
		 }
	 }
	
	//disable all links before today
	if (thisMonday.compareTo(monday) == 1)  {
		$(".add_reg_spot").hide();
		$(".add_climbing_spot").hide();		
	} else {
		$(".add_reg_spot").show();
		$(".add_climbing_spot").show();				
	}
}

function loadCalData() {
	$(" .people").empty();
	
	 //add "X" delete hrefs next to all entries with full names used on this computer
	 var prevNamesCookie = $.cookies.get(PREV_NAMES_COOKIE);
	 if (prevNamesCookie == null) {
		 prevNamesCookie = "";
	 }
	var prevNamesList = prevNamesCookie.split(",");

	//load the data
	 $.getJSON("time_slots?week_of=" + weekOf, function(timeSlots) {
		 //empty all the people to start with
		 for (var i=0; i < timeSlots.length; i++) {
			 var people =  $("#" + timeSlots[i].time_slot.time_slot + " .people");
			 var fullName = timeSlots[i].time_slot.full_name;
			 var timeSlot = timeSlots[i].time_slot.time_slot;
			 var workoutType = timeSlots[i].time_slot.workout_type;
			 var timeSlotId = timeSlots[i].time_slot.id;
			
			 var personDiv;
			 if (workoutType == "regular") {
				 personDiv = "<div id='" + timeSlotId + "' class='regular'><span class='fullName'>" + fullName + "</span>";
			 } else {
				 personDiv = "<div id='" + timeSlotId + "' class='climbing'><span class='fullName'>" + fullName + "</span>(C)";				 
			 }
			 
			 //if this name has been seen before in this browser, display a delete icon
			 if ($.inArray(fullName, prevNamesList) != -1) {
				 personDiv += "<a class='delete' href='javascript:void(0)'>X</a>";
			 }
			 personDiv += "</div>";
			 people.append(personDiv);
	
			//update the regular spots link
			var numOfRegSpotsLeft = MAX_REG_SPOTS - $("#" + timeSlot + " .people div.regular").length;
			 if (numOfRegSpotsLeft <= 0) {
				 //remove the add links
				 $("#" + timeSlot + " .add_reg_spot").hide();
			 } else {
				 //update the number of spots left in the link
				 $("#" + timeSlot + " .add_reg_spot").html(numOfRegSpotsLeft + " regular left");
			 }

			//update the climbing spots link
			var numOfClimbingSpotsLeft = MAX_CLIMBING_SPOTS - $("#" + timeSlot + " .people div.climbing").length;
			 if (numOfClimbingSpotsLeft <= 0) {
				 //remove the link to add a new buttons
				 $("#" + timeSlot + " .add_climbing_spot").hide();
			 } else {
				 //update the number of spots left in the link
				 $("#" + timeSlot + " .add_climbing_spot").html(numOfClimbingSpotsLeft + " climbing left");
			 }
		 
		 }
		 
	 });
	 
	 
	 
	 
}