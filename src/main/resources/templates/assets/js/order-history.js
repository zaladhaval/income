function historyOrder(phone,storeId){
        	modelName = 'orderHistory';
        	console.log($.isNumeric(phone));
        	console.log(phone);
        	console.log(storeId);
      	  	console.log($.isNumeric(phone));
        	if(phone != null && $.isNumeric(phone)){
        		$.ajax({
       	  	      type: 'GET',
       	  	      url: "common/get-order-history/"+phone+"?storeId="+storeId,
       	  	      dataType: "json",
       	  	  	  success: function(resultData) {
       	  	  		  console.log("resultData");
       	  	  		  console.log(resultData);
       	  	  	
       	  		console.log(resultData.length);
       	  	   	var html='';
       			var orderValue = 0;
       					for(var i = 0; i < resultData.length; i++){
       						//var data = resultData[i];
       						lblCustomerName
       						$('#lblCustomerName').text(resultData[0].customerName);
       						$('#lblCustomerPhone').text(resultData[0].phone);
       						var date = new Date(resultData[i].createdAt),
       						yr      = date.getFullYear(),
       					    //month   = (date.getMonth()+1) < 10 ? '0' + (date.getMonth()+1) : (date.getMonth()+1),
       					    //day     = date.getDate()  < 10 ? '0' + date.getDate()  : date.getDate(),
       					   	h 		= date.getHours() < 10 ? '0' + date.getHours() : date.getHours(),
       					   	m 		= date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes(),
       					   	s 		= date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds(),
       					   ampm = date.getHours() >= 12 ? 'PM' : 'AM',
       						h = h % 12,	
       						h = h < 10 ? '0' + h : h,
       					    newDate =  (date.getMonth()+1) + '/' + date.getDate() + '/' + yr + ' '+ h +':'+ m +' '+ ampm;
       					 
       					     html += '<tr>' 
         	  	  				 + '    <td>'+resultData[i].storePrefix+ '  -  ' + resultData[i].orderNumber + '</td>'
         	  	  				 + '    <td>'+ newDate + '</td>'
         	  	  				 + '	<td><i class="mdi mdi-currency-php"></i>'+ resultData[i].totalPrice +'</td>'
         	  	  				 
         	  	  			if(resultData[i].newOrderStatus != null) {
         	  	  				if(resultData[i].newOrderStatus == 'New'){
         	  	  					html += '	<td><span class="badge badge-info badge-pill ml-2" style="font-size:90%">'+ resultData[i].newOrderStatus + '</span></td>';	
         	  	  				}else if(resultData[i].newOrderStatus == 'Confirm' || resultData[i].newOrderStatus == 'Auto Confirmed' || resultData[i].newOrderStatus == 'Upsell'){
         	  	  					html += '	<td><span class="badge badge-blue badge-pill ml-2" style="font-size:90%">'+ resultData[i].newOrderStatus + '</span></td>';
         	  	  				}else if(resultData[i].newOrderStatus == 'Processing' || resultData[i].newOrderStatus == 'Printed'){
         	  	  					html += '	<td><span class="badge badge-warning badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newOrderStatus + '</span></td>';
         	  	  				}else if(resultData[i].newOrderStatus == 'Fulfilled' || resultData[i].newOrderStatus == 'Completed'){
         	  	  					html += '	<td><span class="badge badge-success badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newOrderStatus + '</span></td>';
         	  	  				}else if(resultData[i].newOrderStatus == 'Cancelled' || resultData[i].newOrderStatus == 'Upsell Cancelled'){
         	  	  					html += '	<td><span class="badge badge-danger badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newOrderStatus + '</span></td>';
         	  	  				}
         	  	  			 } else {
          	  					html +=  '	<td><span class="text-muted" style="font-size:90%">NA</span></td>';
          	  				 }
         	  	  				 
         	  	  			if(resultData[i].newShippingStatus != null) {
	         	  	  			if(resultData[i].newShippingStatus == 'Bagged' || resultData[i].newShippingStatus == 'Loaded' || 
	         	  	  				resultData[i].newShippingStatus == 'Picked Up' || resultData[i].newShippingStatus == 'Departed' || 
	         	  	  				resultData[i].newShippingStatus == 'Arrived' || resultData[i].newShippingStatus == 'On Delivery' ||
	         	  	  				resultData[i].newShippingStatus == 'Shipping' || resultData[i].newShippingStatus == 'On Hold' || resultData[i].newShippingStatus == 'On Return' ) {
	         	  	  				html += '	<td><span class="badge badge-warning badge-pill ml-2" style="font-size:90%">'+ resultData[i].newShippingStatus + '</span></td>';	
					 			}else if (resultData[i].newShippingStatus == 'Returned'){
					 				html += '	<td><span class="badge badge-danger badge-pill ml-2" style="font-size:90%">'+ resultData[i].newShippingStatus + '</span></td>';
					 			}else if(resultData[i].newShippingStatus == 'Delivered'){
					 				html += '	<td><span class="badge badge-success badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newShippingStatus + '</span></td>';
					 			}else if(resultData[i].newShippingStatus == 'Void'){
					 				html += '	<td><span class="badge badge-secondary badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newShippingStatus + '</span></td>';
					 			}else if(resultData[i].newShippingStatus == 'Shipped'){
					 				html += '	<td><span class="badge badge-info badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newShippingStatus + '</span></td>';
					 			}
	         	  	  		 } else {
          	  					html +=  '	<td><span class="text-muted" style="font-size:90%">NA</span></td>';
          	  				 }
	         	  	  		if(resultData[i].newRemittanceStatus != null) {
	         	  	  				if(resultData[i].newRemittanceStatus == 'Pending') {
	         	  	  					html += '	<td><span class="badge badge-info badge-pill ml-2" style="font-size:90%">'+ resultData[i].newRemittanceStatus + '</span></td>';	 
	         	  	  				}else if(resultData[i].newRemittanceStatus == 'UnPaid') {
	         	  	  					html += '	<td><span class="badge badge-danger badge-pill ml-2" style="font-size:90%">'+ resultData[i].newRemittanceStatus + '</span></td>';	 
	         	  	  				}else if(resultData[i].newRemittanceStatus == 'Paid') {
         	  	  						html += '	<td><span class="badge badge-success badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newRemittanceStatus + '</span></td>';	 
         	  	  					}else if(resultData[i].newRemittanceStatus == 'Void') {
         	  	  						html += '	<td><span class="badge badge-secondary badge-pill ml-2"  style="font-size:90%">'+ resultData[i].newRemittanceStatus + '</span></td>';	 
         	  	  					}
	      	  				 } else {
	      	  					html +=  '	<td><span class="text-muted" style="font-size:90%">NA</span></td>';
	      	  				 }
	         	  	  		html +=  '	<td><a href="javascript:void(0);" onClick="historyViewOrder(' + resultData[i].id + ')" class="action-icon text-info" >  '  
	    	        		 		+'   	<i class="mdi mdi-24px mdi-eye"></i>  ' 
	    	        		 		+'   </a></td>'
         	  	  		  		 + '</tr>'; 
       						 
       					} 
       					$('#orderHistoryModal').modal('toggle');
       	  	  			$('#orderHistoryItems tbody').html('');
       	  	  			$('#orderHistoryItems tbody').html(html);
       	  	  			$('#orderHistoryItems').DataTable();
       	  	  			//$('#textordervalue').val(orderValue);
       	  	  			
       	  	  		}
     			});
        	}else{
        		alert("No Recode Found.!!!");
        	}
        }

$('#orderHistoryItems').DataTable({
	"info":false,
	"bPaginate": false,
	 "ordering": false,
	 "lengthChange":false,
	 "searching":false,
	columnDefs: [
        { width: 100, targets: 0 }
    ],
  fixedColumns: true
});