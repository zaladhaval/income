/**
 * 
 */
$(document).ready(function(){
	
	$("#clearAllNotification").on('click',function(){
		$.ajax({
			type : "GET",
			url : 'common/clearall-notification',
			success : function(response) { 
				fetchAllUnreadNotification();
			}
		});	
	});
	
	fetchAllUnreadNotification();
	
	setInterval( function () {	  
		fetchAllUnreadNotification();
	},30000 );
	
});
    	   
function fetchAllUnreadNotification(){
	$.ajax({
		type : "GET",
		url : 'common/get-notification',
		dataType : "json",
		success : function(response) { 
			console.log("response : " + response.length);
			if(response.length == 0){
				$("#notification-count").css('display','none');
			}else{
				$("#notification-count").css('display','');
				$("#notification-count").html(response.length);
			}
			
			
			 var notificationItem = '';
			 response.forEach(function(entry) {
				 notificationItem += '<a href="javascript:void(0);" onClick="readNotification(' + entry.id +')" class="dropdown-item notify-item">' ;
				
				
				if (entry.type == 'Inventory') {
					notificationItem +=	'<div class="notify-icon bg-warning"> '
	    							  +	'	<i class="fas fa-dolly text-white"></i>'
	    							  +	'</div>';
				} else if(entry.type == 'Invoice') {
					notificationItem +=	'<div class="notify-icon bg-pink"> '
						  +	'	<i class="fas fa-file-invoice-dollar text-white"></i>'
						  +	'</div>';
				}
				notificationItem +=	'	<p class="notify-details">'+entry.description+''
								 +	'		<small class="text-muted">' + fetchDateString(entry.createdAt) + '</small>'
								 +	'	</p>'
								 +  '</a>';
			 	});
			
			 $("#notification-items").empty()
									.html(notificationItem);
			
		}
	});	
}

function readNotification(notificationId) {
	$.ajax({
		type : "GET",
		url : 'common/clear-notification/'+notificationId,
		success : function(response) { 
			console.log(response);
			window.location.href = response;
		}
	});	
	
}

function readNotificationByPage(notificationId) {
	$.ajax({
		type : "GET",
		url : 'common/clear-notification/'+notificationId,
		success : function(response) { 
			getAllNotification();
		}
	});	
	
}

function fetchDateString(notificationDate){
    date_future = new Date(notificationDate);
    date_now = new Date();

    seconds = Math.floor((date_now - (date_future))/1000);
    minutes = Math.floor(seconds/60);
    hours = Math.floor(minutes/60);
    days = Math.floor(hours/24);
    
    hours = hours-(days*24);
    minutes = minutes-(days*24*60)-(hours*60);
    seconds = seconds-(days*24*60*60)-(hours*60*60)-(minutes*60);
    
    var strDate = '';
    
    if(days > 0){
    	strDate = days + " Day(s) ago";
    }else if(hours > 0){
    	strDate = hours + " Hours(s) ago";
    }else if(minutes > 0){
    	strDate = minutes + " minute(s) ago";
    }else if(seconds > 0){
    	strDate = seconds + " second(s) ago";
    }
    
    return strDate;
}

