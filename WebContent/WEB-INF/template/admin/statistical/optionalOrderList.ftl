[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="[@spring.url '/resources/images/favicon.png'/]">
    <title>${message("admin.main.title")}</title>
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
            	 <div class="text-center">
                    <h4><i class="fa fa-warning"></i> Warning !</h4>
                    <p>Booking will be Cancel ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="modal fade" id="confirm-recover" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning !</h4>
                    <p>Booking will be Recover ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- Modal -->
<div class="modal fade" id="confirm-order" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Cancell Booking!</h4>
					<div class="col-sm-6">
	                  <label class="radio-inline"> <input type="radio" checked="" name="tax" class="icheck" value="1">Unsettled</label> 
	                  <label class="radio-inline"> <input type="radio" name="tax" class="icheck" value="2">Settled</label> 
	                </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a style="cursor:pointer;" href="#" class="btn btn-danger" >Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<div class="md-overlay"></div>
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h3>Booking Info</h3>
            <div class="new">
	            <a class="btn pull-right" href="javascript:history.go(-1)"><i class="fa fa-reply" title="Back"></i></a>
	            <a id="btnPrint" href='javascript:printOrder();' class="btn btn-primary" ><i class="fa fa-print"></i> Print</a>
	            <a class="btn pull-right " href="javascript:explorBill();" title="Export Bill"><i class="fa fa-share-square-o" ></i></a>
	        </div>
            <ol class="breadcrumb">
                <li><a style="cursor:pointer;" href="../../">Home</a></li>
                <li><a style="cursor:pointer;" href="">Booking</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header" style="font-family:'Arial';font-size:16px;font-weight:bold;">
                        	[#if (order.peerId)??]
                        	<b>Agency</b>:
                        	<label style="margin-right:20px;">
								<input name="companyId" type="hidden" id="userSelect" style="width:100%" doName="4808" value="${order.peerId}"required="" onChange="sear()"/>
							</label>
							[/#if]
							[#if (order.brand)??]
                        	<b>Brand</b>:
                        	<label style="margin-right:20px;">
                        		${order.brand}
							</label>
							[/#if]
							<!--[#if (order.deptId)??]
                        	<b>Office</b>:
                        	<label style="margin-right:20px;">
                        		${deptName}
							</label>
							[/#if]-->
							[#if (order.optionalId)??]
                        	<b>Product Name</b>:
                        	<label style="margin-right:20px;">
                        		${lineName}
							</label>
							[/#if]
							[#if (order.userId)??]
                        	<b>Agent</b>:
                        	<label style="margin-right:20px;">
                        		${userName}
                        		<input type="hidden" size="14" id="userName"  value=""/>
							</label>
							[#else]
							<label style="margin-right:20px;">
                        		<input type="text" size="14" id="userName" style="height:35px;vertical-align:sub;" value="${order.userName}" onChange="search()" placeholder="Agent"/>
							</label>
							[/#if]
	                    	<input type="hidden" id="ticketType" value="${order.ticketType}"/>
	                    	<input type="hidden" id="time" value="${order.time}"/>
	                    	<input type="hidden" id="year" value="${order.year}"/>
							<input type="hidden" id="orderType" value="${order.orderType}"/>
							<input type="hidden" id="deptId" value="${order.deptId}"/>
							<input type="hidden" id="isSelfOrganize" value="${order.isSelfOrganize}"/>
							<input type="hidden" id="userId" value="${order.userId}"/>
							<input type="hidden" id="peerId" value="${order.peerId}"/>
							<input type="hidden" id="optionalId" value="${order.optionalId}"/>
							<input type="hidden" id="brand" value="${order.brand}"/>
							<input type="hidden" id="wr" value="${order.wr}"/>
							<input type="hidden" id="role" value="${role}"/>
						</div>
                        <div class="content">
                        	<form method="post" id="formId" action="[@spring.url '/admin/payCostRecords/agentSettlementAll.jhtml?menuId=303'/]">
	                            <div class="table-responsive">
	                                <table class="table table-bordered" id="datatable2">
	                                    <thead>
		                                    <tr>
												<th></th>
												<th>Booking No. </th>
												<th>Agent</th>
												<th>Tour Code</th>
												<th>Total Passenger</th>
												<th>Arrival Date</th>
												<th>Invoice Amount</th>
												<th>Income</th>
												<th>Cost</th>
												<th>Profit</th>
												<th>Open Balance</th>
		                                    </tr>
	                                    </thead>
	                                </table>
	                            </div>
	                       </form>
                        </div>
                        <div class="th-box">
							<div class="th-box-t">
								<span style="font-family:'Arial';color:#001144;font-size:20px;font-weight:bold;">Summary</span>
							</div>
							<div class="th-box-b">
								<table style="font-family:'Arial';width:95%;margin:0 auto 0;">
									<tbody>
										<tr>
											<td style="height:16px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Passenger：${orders.totalPeople}</td>
											<td style="height:16px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Amount：${orders.commonTourFee}</td>
											<td style="height:16px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Income：${orders.pay}</td>
											<td style="height:16px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Cost：${orders.cost}</td>
											<td style="height:16px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Profit：${((orders.pay)!0)-((orders.cost)!0)}</td>
											<td style="height:16px;font-size:15px;font-weight:bold;padding:0 0 0 8px;">Open Balance：${((orders.commonTourFee)!0)-((orders.pay)!0)}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
       [@flash_message /]
        App.init();
         $("#userSelect").select2({
			placeholder:"Search Agency",//文本框的提示信息
			minimumInputLength:1,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				//url:'[@spring.url '/admin/vender/listSelect.jhtml'/]',	//地址
				url:'${base}/admin/vender/listSelect.jhtml?type=2&role='+$("#role").val(),	//地址(type=2供应商，查找type!=2)
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term); 
                    return {  
                         name: term   //联动查询的字符  
                     }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.venderList.length;i++){
						var vender = dataStr.venderList[i];
						 dataA.push({id: vender.venderId, text: vender.name});
					}
					
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		   
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/vender/listSelect.jhtml?venderId='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		//alert(JSON.stringify(data));
				    		//alert(JSON.stringify(data.venderList[0].venderId));
				    		if(data.venderList[0]==undefined){
				    			callback({id:"",text:"Search Vender"});
				    		}else{
				    			callback({id:data.venderList[0].venderId,text:data.venderList[0].name});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) { return m; }
		});
    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
    var orderType=$("#orderType").val();
	function formatAsText(item){
	     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>"
	     return itemFmt;
	}
        //$("#checked").attr("aria-checked","true");
        $("#datatable2").attr("width","100%");
        
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
         
         /* Formating function for row details */
         function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            if(orderType!=5){
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
			sOut +=aData.priceExpression*100;
			sOut += '%Profit: </td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
			sOut +=((aData.pay-aData.cost)*aData.priceExpression).toFixed(2);
			sOut += '</td></tr>';
			 	
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Balance: ';
			sOut += '</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
			sOut +=((aData.pay-aData.cost)-(aData.pay-aData.cost)*aData.priceExpression).toFixed(2);
			sOut += '</td></tr>';
			}
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Booking Date:</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">'+aData.arriveDate+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Settlement Date : ';
	        	
			sOut += '</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
				if(aData.checkTime!=null){
					sOut +=aData.checkTime;
				}else{
					sOut += '';
				} 
			sOut += '</td></tr>';
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Status : ';
			sOut += '</td><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
				if(aData.state==0){
					sOut += 'NEW';
				}else if(aData.state==2){
					sOut += 'COMPOSED';
				}else if(aData.state==3){
					sOut += 'UPDATE';
				}else if(aData.state==4){
					sOut += 'CACELLING';
				}else if(aData.state==5){
					sOut += 'CANCELLED';
				}else if(aData.state==6){
					sOut += 'CANCELLED';
				}else if(aData.state==7){
					sOut += 'RECOVERING';
				}else{
					sOut += '';
				}
			sOut += '</td></tr>';
			sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Settlement Status: </td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">';
            if(aData.tax==0){
					sOut +='Unsettled';
				}else if(aData.tax==2){
					sOut += 'Settled';
				}else if(aData.tax==3){
					sOut += 'Settling';
				}else if(aData.tax==4){
					sOut += 'Settled';
				}else{
					sOut += '';
				} 
            sOut += '</td></tr></table>';
            return sOut;
        }
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "autoWidth":true,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/statistical/orderDetailsByOptional.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
	                data.time = $("#time").val();
	                data.year = $("#year").val();
	                data.orderType = $("#orderType").val();
	                data.deptId = $("#deptId").val();
	                data.optionalId = $("#optionalId").val();
	                data.isSelfOrganize = $("#isSelfOrganize").val();
	                data.userId = $("#userId").val();
	                data.peerId = $("#peerId").val();
	                data.brand = $("#brand").val();
	                data.wr = $("#wr").val();
	                data.ticketType = $("#ticketType").val();
	                data.role = $("#role").val();
	                data.userName = $("#userName").val();
            	}
            },
            "columns": [
                { "data": "id" },
                { "data": "orderNo" },
                { "data": "userName" },
                { "data": "tourCode" },
                { "data": "totalPeople"},
                { "data": "arriveDateTime" },
                { "data": "commonTourFee" },
                { "data": "pay" },
                { "data": "cost" },
                { "data": "pay",
                	"render" : function(data, type, row) {
                		if(data!=null){
							return (data-row.cost).toFixed(2);
						}else{
							return '0';
						}
                	}
                },
                { "data": "commonTourFee",
                	"render" : function(data, type, row) {
                		if(data!=null){
							return (data-row.pay).toFixed(2);
						}else{
							return '0';
						}
                	}
                }
            ],
             "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
           },
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				if(aData.id==null){
					$('td:eq(0)', nRow).html("Total");
					$('td:eq(7)', nRow).html("Total");
					$(nRow).attr("class","tfoot");
				}
			},
		   "order": [[ 1, 'asc' ]]
        });
        
         $('#datatable2').delegate('tbody td img','click', function () {
            var nTr = $(this).parents('tr')[0];
            
            if ( oTable.fnIsOpen(nTr) )
            {
                /* This row is already open - close it */
                this.src = "[@spring.url '/resources/images/plus.png'/]";
                oTable.fnClose( nTr );
            }
            else
            {
                /* Open this row */
                this.src = "[@spring.url '/resources/images/minus.png'/]";
                oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
            }
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
    function search(){
    	var time = $("#time").val();
        var year = $("#year").val();
        var orderType = $("#orderType").val();
        var deptId = $("#deptId").val();
        var optionalId = $("#optionalId").val();
        var isSelfOrganize = $("#isSelfOrganize").val();
        var userId = $("#userId").val();
        var userName = $("#userName").val();
        var peerId = $("#peerId").val();
        var brand = $("#brand").val();
        var wr = $("#wr").val();
        var ticketType = $("#ticketType").val();
        var role = $("#role").val();
        if(time.indexOf("-")<0){
        	location.href="${base}/admin/statistical/orderDetailsOptional.jhtml?role="+role+"&orderType="+orderType+"&year="+year+"&deptId="+deptId+"&optionalId="+optionalId+"&isSelfOrganize="+isSelfOrganize+"&userId="+userId+"&userName="+userName+"&peerId="+peerId+"&brand="+brand+"&wr="+wr+"&ticketType="+ticketType;
        }else{
        	location.href="${base}/admin/statistical/orderDetailsOptional.jhtml?role="+role+"&orderType="+orderType+"&time="+time+"&deptId="+deptId+"&optionalId="+optionalId+"&isSelfOrganize="+isSelfOrganize+"&userId="+userId+"&userName="+userName+"&peerId="+peerId+"&brand="+brand+"&wr="+wr+"&ticketType="+ticketType;
        }
    }
    function printOrder(){
		var time = $("#time").val();
        var year = $("#year").val();
        var orderType = $("#orderType").val();
        var deptId = $("#deptId").val();
        var optionalId = $("#optionalId").val();
        var isSelfOrganize = $("#isSelfOrganize").val();
        var userId = $("#userId").val();
        var userName = $("#userName").val();
        var peerId = $("#peerId").val();
        var brand = $("#brand").val();
        var wr = $("#wr").val();
        var ticketType = $("#ticketType").val();
        var role = $("#role").val();
        if(time.indexOf("-")<0){
        	location.href="${base}/admin/statistical/orderDetailsPrintForOptional.jhtml?role="+role+"&orderType="+orderType+"&year="+year+"&deptId="+deptId+"&optionalId="+optionalId+"&isSelfOrganize="+isSelfOrganize+"&userId="+userId+"&userName="+userName+"&peerId="+peerId+"&brand="+brand+"&wr="+wr+"&ticketType="+ticketType;
        }else{
        	location.href="${base}/admin/statistical/orderDetailsPrintForOptional.jhtml?role="+role+"&orderType="+orderType+"&time="+time+"&deptId="+deptId+"&optionalId="+optionalId+"&isSelfOrganize="+isSelfOrganize+"&userId="+userId+"&userName="+userName+"&peerId="+peerId+"&brand="+brand+"&wr="+wr+"&ticketType="+ticketType;
        }
    }
	function explorBill(){
		var time = $("#time").val();
        var year = $("#year").val();
        var orderType = $("#orderType").val();
        var deptId = $("#deptId").val();
        var optionalId = $("#optionalId").val();
        var isSelfOrganize = $("#isSelfOrganize").val();
        var userId = $("#userId").val();
        var userName = $("#userName").val();
        var peerId = $("#peerId").val();
        var brand = $("#brand").val();
        var wr = $("#wr").val();
        var ticketType = $("#ticketType").val();
        var role = $("#role").val();
        if(time.indexOf("-")<0){
        	location.href="${base}/admin/statistical/ExcelForStatisticsForOptional.jhtml?role="+role+"&orderType="+orderType+"&year="+year+"&deptId="+deptId+"&optionalId="+optionalId+"&isSelfOrganize="+isSelfOrganize+"&userId="+userId+"&userName="+userName+"&peerId="+peerId+"&brand="+brand+"&wr="+wr+"&ticketType="+ticketType;
        }else{
        	location.href="${base}/admin/statistical/ExcelForStatisticsForOptional.jhtml?role="+role+"&orderType="+orderType+"&time="+time+"&deptId="+deptId+"&optionalId="+optionalId+"&isSelfOrganize="+isSelfOrganize+"&userId="+userId+"&userName="+userName+"&peerId="+peerId+"&brand="+brand+"&wr="+wr+"&ticketType="+ticketType;
        }
	}
</script>
</body>
</html>