function historyOrder(phone,storeId){
        	modelName = 'orderHistory';
        	console.log($.isNumeric(phone));
        	if(phone == null || !$.isNumeric(phone) || phone == '')
     			return false;
        	$("#orderHistoryItems").DataTable({
				language:{
					paginate:{
						previous:"<i class='mdi mdi-chevron-left'>",
						next:"<i class='mdi mdi-chevron-right'>"
					},
					 "infoFiltered": ""
			 	},
			 	drawCallback:function(){
			 		$(".dataTables_paginate > .pagination").addClass("pagination-rounded")
			 	},
			 	responsive: true,
    	        bServerSide: true,
    	        bDestroy: true,
    	        bPaginate: true,
    	        bProcessing: true,
			 	columns:[
			 		{"data":"orderNumber","render":function(data,type,row){return "<b>" + row.storePrefix + '-' + data + "</b>"}},
			 		{"data":"createdAt","render":function(data,type,row){
			 			var date = new Date(data);
		        		return date.toLocaleDateString() + '<small class="text-muted"> ' + date.toLocaleTimeString(navigator.language, {hour: '2-digit', minute:'2-digit'}) + '</small>';
			 		}},
			 		{"data":"agentFirstName","render":function(data,type,row){
			 			return data + ' ' + row.agentLastName;
			 		}},
			 		{"data":"totalPrice","className": "text-right","render":function(data,type,row){return '<i class="mdi mdi-currency-php"></i> ' + data.toFixed(2)}},
			 		{"data":"newOrderStatus", "render": function(data,type,row) {
		 				if(data == 'New'){
   	  	  					return '<span class="badge badge-info badge-pill ml-2" style="font-size:90%">'+ data + '</span>';	
   	  	  				}else if(data == 'Confirm' || data == 'Auto Confirmed' || data == 'Upsell'){
   	  	  					return '<span class="badge badge-blue badge-pill ml-2" style="font-size:90%">'+ data + '</span>';
   	  	  				}else if(data == 'Processing' || data == 'Printed'){
   	  	  					return '<span class="badge badge-warning badge-pill ml-2"  style="font-size:90%">'+ data + '</span>';
   	  	  				}else if(data == 'Fulfilled' || data == 'Completed'){
   	  	  					return '<span class="badge badge-success badge-pill ml-2"  style="font-size:90%">'+ data + '</span>';
   	  	  				}else if(data == 'Cancelled' || data == 'Upsell Cancelled'){
   	  	  					return '<span class="badge badge-danger badge-pill ml-2"  style="font-size:90%">'+ data + '</span>';
   	  	  				}else{
   	  	  					return '<td><span class="text-muted" style="font-size:90%">NA</span>';
   	  	  				}
			 		}},
			 		{"data": "newShippingStatus","render": function ( data, type, row ) {
		 				if(!data) {
			 				return '<span class="text-muted" style="font-size:90%">NA</span>';	
			 			} else if (data == 'Returned') {
			 				return '<span class="badge badge-danger badge-pill ml-2" style="font-size:90%">Returned</span>';
			 			} else if(data == 'Delivered') {
			 				return '<span class="badge badge-success badge-pill ml-2"  style="font-size:90%">Delivered</span>';
			 			}else if(data == 'Void') {
			 				return '<span class="badge badge-secondary badge-pill ml-2"  style="font-size:90%">Void</span>';
			 			}else if(data == 'Shipped'){
			 				return '<span class="badge badge-info badge-pill ml-2"  style="font-size:90%">Shipped</span>';
			 			}else{
			 				return '<span class="badge badge-warning badge-pill ml-2" style="font-size:90%">' + data + '</span>';	
			 			}
	                }},
			 		{"data":"newRemittanceStatus" ,"render": function ( data, type, row ) {
			 			if(!data) {
			 				return '<span class="text-muted" style="font-size:90%">NA</span>';
			 			}
			 			if(data == 'Pending') {
			 				return '<span class="badge badge-info badge-pill ml-2" style="font-size:90%">Pending</span>';	
			 			} else if (data == 'UnPaid') {
			 				return '<span class="badge badge-danger badge-pill ml-2" style="font-size:90%">UnPaid</span>';
			 			} else if(data == 'Paid') {
			 				return '<span class="badge badge-success badge-pill ml-2"  style="font-size:90%">Paid</span>';
			 			}else if(data == 'Void') {
			 				return '<span class="badge badge-secondary badge-pill ml-2"  style="font-size:90%">Void</span>';
			 			} 
	                }},
			 		{"data":"orderNumber", "bSortable": false ,"render": function ( data, type, row ) {
			 			$('#lblCustomerName').text(row.customerName);
						$('#lblCustomerPhone').text(row.phone);
     	        		return '<a href="javascript:void(0);" onClick="historyViewOrder(' + row.id + ')" class="action-icon text-info" >  '  
	        		 		+'   	<i class="mdi mdi-24px mdi-eye"></i>  ' 
 	        		 		+'   </a>';
                    }}
			 	],
			 	"order": [[ 1, "desc" ]],
                ajax: {
                	"url":"customer/get-order-history-for-datatable/0" + phone + "/" + storeId,
                	"type":"POST", 
                	"contentType":"application/json",
                	"data": function(d) {
        	            return JSON.stringify(d);
        	    	}
			 	}
			});
        	$('#orderHistoryModal').modal('toggle');
        }