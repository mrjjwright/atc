var year = new Date().getFullYear();
	var month = new Date().getMonth();
	var day = new Date().getDate();

	var eventData1 = {
			options: {
				timeslotsPerHour: 4,
				timeslotHeight: 20
			},
			events : [
			   {"id":1, "start": new Date(year, month, day, 12), "end": new Date(year, month, day, 13, 30),"title":"Lunch with Mike"},
			   {"id":2, "start": new Date(year, month, day, 14), "end": new Date(year, month, day, 14, 45),"title":"Dev Meeting"},
			   {"id":3, "start": new Date(year, month, day + 1, 18), "end": new Date(year, month, day + 1, 18, 45),"title":"Hair cut"},
			   {"id":4, "start": new Date(year, month, day - 1, 8), "end": new Date(year, month, day - 1, 9, 30),"title":"Team breakfast"},
			   {"id":5, "start": new Date(year, month, day + 1, 14), "end": new Date(year, month, day + 1, 15),"title":"Product showcase"}
			]
		};

	var eventData2 = {
			options: {
				timeslotsPerHour: 3,
				timeslotHeight: 30
			},
			events : [
			   {"id":1, "start": new Date(year, month, day, 12), "end": new Date(year, month, day, 13, 00),"title":"Lunch with Sarah"},
			   {"id":2, "start": new Date(year, month, day, 14), "end": new Date(year, month, day, 14, 40),"title":"Team Meeting"},
			   {"id":3, "start": new Date(year, month, day + 1, 18), "end": new Date(year, month, day + 1, 18, 40),"title":"Meet with Joe"},
			   {"id":4, "start": new Date(year, month, day - 1, 8), "end": new Date(year, month, day - 1, 9, 20),"title":"Coffee with Alison"},
			   {"id":5, "start": new Date(year, month, day + 1, 14), "end": new Date(year, month, day + 1, 15),"title":"Product showcase"}
			]
		};

$(document).ready(function() {
  $('#calendar').weekCalendar(eventData1);
});
