[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <title>${message("admin.main.title")}</title>
	<link href="http://fonts.googleapis.com/css?family=Roboto|PT Sans" rel="stylesheet" type="text/css" />
<link href="[@spring.url '/resources/peerUser/'/]css/public.css" rel="stylesheet" type="text/css" />
<link href="[@spring.url '/resources/peerUser/'/]css/style2.css" rel="stylesheet" type="text/css" />

<!-- Bootstrap core CSS -->

<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/bootstrap/dist/css/bootstrap.css'/]"/>
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/fonts/font-awesome-4/css/font-awesome.min.css'/]">
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/css/jquery-ui.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/css/jquery-ui.structure.min.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/css/jquery-ui.theme.min.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/fuelux/css/fuelux.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/fuelux/css/fuelux-responsive.min.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/bootstrap.switch/bootstrap-switch.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/bootstrap.datetimepicker/css/bootstrap-datetimepicker.min.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/jquery.niftymodals/css/component.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/css/component.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/jquery.datatables/bootstrap-adapter/css/datatables.css'/]"/>
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/jquery.icheck/skins/square/blue.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/css/pygments.css'/]" />
<link rel="stylesheet" type="text/css" href="[@spring.url '/resources/peerUser/js/jquery.select2/select2.css'/]" />
<!--多日期选择-->
<link href="[@spring.url '/resources/peerUser/css/date/kalendae.css'/]" rel="stylesheet" />

<link href="[@spring.url '/resources/peerUser/css/custom.css'/]" rel="stylesheet" />

<!--<link href='http://fonts.useso.com/css?family=Open+Sans:400,300,600,400italic,700,800' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=Raleway:100' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=Open+Sans+Condensed:300,700' rel='stylesheet' type='text/css'>-->
</head>
<body>
<!-- Fixed navbar -->
[#include "/admin/peerUser/include/navbar.ftl"]
<div class="w1">
	<div class="fl search_list">
        	<input id="search_orderNo" name="search_id" class="search_1" value="" placeholder="Booking NO.">
            <input id="search_tourCode" name="search_id" class="search_1" value="" placeholder="Tour Code">
            <input id="search_tourName" name="search_tourName" class="search_1" value="" placeholder="Tour Name">
            <input id="search_customerLast" name="search_customerLast" class="search_1" value="" placeholder="Last Name">
            <input id="search_customerFirst" name="search_customerFirst" class="search_1" value="" placeholder="First Name">
            <input id="search_refNo" name="search_refNo" class="search_1" value="" placeholder="REF NO">
            <input id="search_contact" name="search_contact" class="search_1" value="" placeholder="Consultant">
            <input id="search_beginningDate" name="search_id" class="search_1" value="" placeholder="From">
            <span>-</span>
            <input id="search_endingDate" name="search_id" class="search_1" value="" placeholder="To">
            <input type="submit" class="search_subX" id="subId" value="Search">
            <input  type="submit" onclick="booking()" class="search_subX" value="Book">
    </div>
    <div class="r1 print">
    	<a href="javascript:void(0)" id="exportOrder"><img src="[@spring.url '/resources/peerUser/'/]images/export.png" width="35" height="20">&nbsp;<span>Export</span></a>
    </div>
    <div class="clear"></div>
    <div class="search_line"></div>
    <div class="mybooking">
    	<div class="block-flat">
            <div class="content">
            	<form method="post" id="formId" action="[@spring.url '/admin/payCostRecords/agentSettlementAll.jhtml?menuId=303'/]">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="datatable2">
                            <thead>
                                <tr>
									<th>BOOKING NO. </th>
									<th>TOUR CODE</th>
									<th>TOUR NAME</th>
									<th>TOUR DATE</th>
									<th>REF NO</th>
									<th>CONSULTANT NAME</th>
									<th>AUDIT STATUS</th>
									<th>STATUS</th>
									<th style="width:10%">ACTION</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
               </form>
            </div>
        </div>
    </div>
</div>

[#include "/admin/peerUser/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	//清除废弃数据
    	$.ajax({
			url: "${base}/admin/peerUser/delTotalInfo.jhtml",
			type: "GET",
			success: function(message) {
			}
		});
        //initialize the javascript
        App.init();
        [@flash_message /]
	     $('input').iCheck({
	        checkboxClass: 'icheckbox_square-blue checkbox',
	        radioClass: 'iradio_square-blue'
	      });
        
        $("#datatable2").attr("width","100%");
        
        $("div.options").hide();//默认隐藏div，或者在样式表中添加.text{display:none}，推荐使用后者
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        $("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		
        /* Formating function for row details */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/peerUser/tourList.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.orderNo = $("#search_orderNo").val();
					data.lineName = $("#search_tourName").val();
					data.tax = $("#taxSpan").val();
					data.payState = $("#payStateSpan").val();
					data.warnState = $("#warnStateSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
					data.bookingBeginningDate = $("#booking_beginningDate").val();
					data.bookingEndingDate = $("#booking_endingDate").val();
					data.settlementDateBeg = $("#search_settlementDateBeg").val();
	                data.settlementDateEnd = $("#search_settlementDateEnd").val();
	                data.isSelfOrganize = $("#isSelfOrganizeSpan").val();
	                data.peerId = $("#search_peer").val();
	                data.lastName=$("#search_customerLast").val();
	                data.firstName=$("#search_customerFirst").val();
	                data.refNo=$("#search_refNo").val();
	                data.contact=$("#search_contact").val();
				}
            },
            "columns": [
                { "data": "orderNo",
                	"render" : function(data,type,row){
                		data = data+"";
                		if(row.peerUserRemark!=null){
                				html =""
                				html+= '<a href="tourOrderEdit.jhtml?id='+row.id+'">'+data.substring(0,data.indexOf("-"))+'</a><span id="span'+row.id+'">';
                				if(row.reviewState==6){
                					html+= '<a href="javascript:;" title="'+row.peerUserRemark+'"> <i class="fa fa-comment" style="color:red" onMouseOver="upflag(\''+row.id+'\',\''+row.peerUserRemark+'\')"></i></a>';
                				}else{
                					html+= '<a href="javascript:;" title="'+row.peerUserRemark+'"> <i class="fa fa-comment"></i></a>';
                				}
                				html+= '</span>';
                				return html;
                		}else{
                			return '<a href="tourOrderEdit.jhtml?id='+row.id+'">'+data.substring(0,data.indexOf("-"))+'</a>';
                		}
                	} 
                },
                { "data": "tourCode" },
                { "data": "lineName"},
                { "data": "scheduleOfArriveTime" },
                { "data": "refNo" },
                { "data": "contact" },
                { "data": "reviewState","visible":false,
					"render" : function(data, type, row) {
					  	switch(data){
					  		case 1 : return 'PENDING';
					  		case 2 : return 'CONFIRMED';
					  		case 3 : return 'DECLINE';
					  		case 5 : return 'PENDING';
					  		case 6 : return 'MODIFIED';
					  		default: return ''; 
					  	}
					}
                },
                { "data": "state",
					"render" : function(data, type, row) {
						if(row.itInfo==1 && data==2){
							return '<span class="color-danger">FINAL</span>';
						}else{
							if(data==0){
								return '<span class="color-danger">NEW</span>';
							}else if(data==2){
								return '<span class="color-success">COMPOSED</span>';
							}else if(data==3){
								return '<span class="color-primary">UPDATE</span>';
							}else if(data==4){
								return '<span class="color-danger">CACELLING</span>';
							}else if(data==5){
								return '<span class="color-warning">CANCELLED</span>';
							}else if(data==6){
								return '<span class="color-warning">CANCELLED</span>';
							}else if(data==7){
								return '<span class="color-danger">RECOVERING</span>';
							}else{
								return '';
							}
						}
					}
                },
                { "data": "id" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
						html='<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span>';
						html+='<span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right">';
						if(row.state!=6 && row.state!=5 && row.reviewState==0){
						html+='<li><a style="cursor:pointer;" href="tourEdit.jhtml?menuId=303&id='+data+'"><i class="fa fa-pencil"></i>Edit</a></li>';
						}
						html+='<li><a style="cursor:pointer;" href="tourOrderEdit.jhtml?id='+data+'"><i class="fa fa-eye"></i>View</a></li>';
						if(row.state!=6 && row.state!=5){
						html+='<li><a style="cursor:pointer;" href="paymentList.jhtml?orderId='+data+'"><i class="fa fa-pencil" title="Payment"></i>Payment</a></li>';
						
						if(row.reviewState!=1 && row.reviewState!=3){
							if(row.brand=="中国美"){
								html+='<li><a style="cursor:pointer;" target="_blank" href="createInvoiceToPdf.jhtml?totalId='+row.ordersTotalId+'&logo=resources/images/echinatours-logo.png"><i class="fa fa-eye" title="Invoice"></i>Invoice</a></li>';
								/*html+='<li><a style="cursor:pointer;" target="_blank" href="createInvoiceToBPdf.jhtml?totalId='+row.ordersTotalId+'&logo=resources/images/echinatours-logo.png"><i class="fa fa-eye" title="Invoice"></i>New Invoice</a></li>';*/
							}
							if(row.brand=="文景假期"){
								html+='<li><a style="cursor:pointer;" target="_blank" href="createInvoiceToPdf.jhtml?totalId='+row.ordersTotalId+'&logo=resources/images/nexus-logo.png"><i class="fa fa-eye" title="Invoice"></i>Invoice</a></li>';
								/*html+='<li><a style="cursor:pointer;" target="_blank" href="createInvoiceToBPdf.jhtml?totalId='+row.ordersTotalId+'&logo=resources/images/nexus-logo.png"><i class="fa fa-eye" title="Invoice"></i>New Invoice</a></li>';*/
							}
						}
						/*html+='<li><a style="cursor:pointer;" target="_blank" href="exportInvoice.jhtml?orderId='+data+'"><i class="fa fa-eye" title="Invoice"></i>Invoice</a></li>';*/
						if(row.postInfo==1){
							html+='<li><a style="color:#ee5037" title="Downloaded" id="'+data+'href" target="_blank" onclick="changeDowm(\''+data+'\')" href="exportVoucher.jhtml?id='+data+'"><i class="fa fa-eye" title="Invoice"></i>Tour Confirmation Page</a></li>';
						}else{
							html+='<li><a id="'+data+'href" title="Not Downloaded"  target="_blank" onclick="changeDowm(\''+data+'\')" href="exportVoucher.jhtml?id='+data+'"><i class="fa fa-eye" title="Invoice"></i>'+row.postInfo+'Tour Confirmation Page</a></li>';
						}
						}
						if(row.itInfo==1){
							html+='<li><a style="color:#ee5037" title="Downloaded" id="'+data+'href" target="_blank" onclick="changeDowm(\''+data+'\')" href="exportVoucherforOpconfirm.jhtml?id='+data+'"><i class="fa fa-eye" title="Invoice"></i>Final Tour Confirmation Page</a></li>';
						}
						if(row.reviewState==1){
							if(row.state==6 || row.state==5){
								html+='<li class="divider"></li><li><a id="'+data+'_button" style="cursor:pointer;"href="javascript:recoverOrder(\''+data+'_button\',\''+data+'\',\''+row.tourId+'\');"><i class="fa fa-mail-reply"></i>Recover</a></li></ul></div>';
							}else{
								html+='<li class="divider"></li><li><a id="'+data+'_button" style="cursor:pointer;"href="javascript:cancelOrder(\''+data+'_button\',\''+data+'\',\''+row.tourId+'\');"><i class="fa fa-times"></i>Cancel</a></li></ul></div>';
							}
						}
						html+='</ul></div>';
						return html;
                 },
				"targets" : 8
		   }],
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.id==null){
					$('td:eq(0)', nRow).html("");
					$('td:eq(9)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
				if(aData.state==6 && aData.state==5){
					$('td:eq(0)', nRow).html("");
					$('td:eq(9)', nRow).html("");
					$(nRow).attr("class","tfoot");
				}
			},
			"fnDrawCallback": function() {
				initAddHtml($("#datatable2"));
		    },
		   "order": [[ 1, 'asc' ]]
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $('#confirm-recover').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
        
        $('#confirm-order').on('show.bs.modal', function (e) {
        	var tax=$("input[name='tax']:checked").val();
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href')+"?tex="+tax);
        });
    });
    
		$("#subId").on( 'click', function () {
			$('#datatable2').DataTable().draw();
		} );
		
		var obj={
		 colorSpan:"",
		};
		function change(span,value)
		{
			//给所以span的属性初始化
		    $('span[name="'+$(span).attr('name')+'"]').each(function(){
		             if(this.checked&&this!=span)
		          {
		                this.className="unchecked";
		                this.checked=false;
		          }               
		    });
		    //判断是否有选中   是 初始化取消加粗   否加粗
		  	if(span.checked&&span.className=="checked"){
			    span.className="unchecked";
			    span.checked=false;
			    $("#"+$(span).attr('name')+"").val("");
		  	}else{
		  		obj[$(span).attr('name')]=span.innerHTML;
			    span.className="checked";
			    span.checked=true;
			    $("#"+$(span).attr('name')+"").val(value);
		  	}
		}
		$("#clearDate").click(function(){
			$("#search_beginningDate").val('');
 			$("#search_endingDate").val('');
		});
		
		$("#search_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#search_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		
		$("#clearDate2").click(function(){
			$("#booking_beginningDate").val('');
 			$("#booking_endingDate").val('');
		});
		
		$("#booking_beginningDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		$("#booking_endingDate").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true });
		
		$("#clearDate1").click(function(){
			$("#search_settlementDateBeg").val('');
 			$("#search_settlementDateEnd").val('');
		});
		$("#search_settlementDateBeg").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		$("#search_settlementDateEnd").datepicker({dateFormat: 'yy-mm-dd',changeYear: true,changeMonth: true,yearRange: '2000:2050'});
		
	 function isChanged(id){
    	$.post("${base}/admin/orders/isReview.jhtml",{'id':id},function(map){
    		if(map.ok=="ok"){
    			window.location.href="${base}/admin/orders/orderReview.jhtml?id="+id+"&menuId=303";
    		}else{
    			window.location.href="${base}/admin/orders/createOldPdf.jhtml?id="+id+"&menuId=303";
    		}
    	});
    }
    $("#subId").on( 'click', function () {
			$('#datatable2').DataTable().draw();
		} );
	/* 取消订单  */
	function cancelOrder(buttonId, orderId, tourId){
		$.post("${base}/admin/orders/asynchronousCancelOrder.jhtml",{"orderId" : orderId},function(result){
			if(result == 'success'){
				var $a = $("#" + buttonId);
				var $buttonLi = $a.parent();
				var $stateTd = $buttonLi.parent().parent().parent().prev();
				if(tourId == ''){
				//如果订单未组团
					$a.attr("href","javascript:recoverOrder('"+ buttonId +"','"+ orderId +"','" + tourId +"');");
					$a.html("<i class='fa fa-mail-reply'></i>Recover");
					$stateTd.html("<span class='color-danger'>CANCELLED</span>");
					alert('Cancel Booking completed!');
				}else{
				//如果订单已组团
					$buttonLi.prev().remove();					
					$buttonLi.remove();
					$stateTd.html("<span class='color-warning'>CANCELLING</span>");
					alert('Cancelling Booking!');
				}
			}
		}); 
	}
	
	/* 恢复订单  */
	function recoverOrder(buttonId, orderId, tourId){
		$.post("${base}/admin/orders/asynchronousRecoverOrder.jhtml",{"orderId" : orderId},function(result){
			if(result == 'success'){
				var $a = $("#" + buttonId);
				var $buttonLi = $a.parent();
				var $stateTd = $buttonLi.parent().parent().parent().prev();
				if(tourId == ''){
				//如果订单未组团
					$a.attr("href","javascript:cancelOrder('"+ buttonId +"','"+ orderId +"','" + tourId +"');");
					$a.html("<i class='fa fa-times'></i>Cancel");
					$stateTd.html("<span class='color-warning'>NEW</span>");
					alert('Recoverd Booking completed!');
				}else{
				//如果订单已组团
					$buttonLi.prev().remove();					
					$buttonLi.remove();
					$stateTd.html("<span class='color-warning'>RECOVERING</span>");
					alert('Recovering Booking!');						
				}
			}
		}); 
	}
	/*打印*/
	function printOrder(){
		var tourCode = $("#search_tourCode").val();
		var orderNo = $("#search_orderNo").val();
		var state = $("#stateSpan").val();
		var tax = $("#taxSpan").val();
		var payState = $("#payStateSpan").val();
		var warnState = $("#warnStateSpan").val();
		var beginningDate = $("#search_beginningDate").val();
		var endingDate = $("#search_endingDate").val();
		var bookingBeginningDate = $("#booking_beginningDate").val();
		var bookingEndingDate = $("#booking_endingDate").val();
		var settlementDateBeg = $("#search_settlementDateBeg").val();
	    var settlementDateEnd = $("#search_settlementDateEnd").val();
	    var isSelfOrganize = $("#isSelfOrganizeSpan").val();
	    var url="?tourCode="+tourCode+"&orderNo="+orderNo+"&tax="+tax+"&state="+state+"&beginningDate="+beginningDate;
	    url+="&endingDate="+endingDate+"&settlementDateBeg="+settlementDateBeg+"&settlementDateEnd="+settlementDateEnd+"&isSelfOrganize="+isSelfOrganize;
	    url+="&bookingBeginningDate="+bookingBeginningDate+"&bookingEndingDate="+bookingEndingDate+"&payState="+payState+"&warnState="+warnState;
		window.open("[@spring.url '/admin/orders/findTourOrderListVOPrint.jhtml'/]"+url);
	}
	
  	/* 初始化添加的元素  */
	function initAddHtml($addHtml){
		$addHtml.find('.icheck').iCheck({
			checkboxClass: 'icheckbox_square-blue checkbox',
			radioClass: 'iradio_square-blue'
		});
		return $addHtml;
	}
	
	//导出exportOrderExcle
	$("#exportOrder").click(function(){
		window.location.href="exportOrderExcle.jhtml";
	});
	function booking(){
		window.location.href="${base}/admin/peerUser/add.jhtml?area=中国&degree=超值特价&tourName=2015";
	}
	function upflag(id,remark){
		alert(remark);
    	$.post("${base}/admin/peerUser/changeReview.jhtml",{'id':id},function(map){
    		if(map.ok=="ok"){
    			/*var html='';
    			$("#span"+id).text(html);
    			html+='<a href="javascript:;" title="'+remark+'"> <i class="fa fa-comment"></i></a>';
    			$("#span"+id).append(html);*/
				$('#datatable2').DataTable().draw();
    		}
    	});
    }
     /*点击确认单下载状态更改为已下载*/
    function changeDowm(id){
    	$.post('updateOrderInfo.jhtml',{'id':id,'postInfo':1},function(){
    		$("#"+id+"href").attr("style","color:#ee5037");
    		$("#"+id+"href").attr("title","Downloaded");
    	});
    }
</script>
</body>
</html>
