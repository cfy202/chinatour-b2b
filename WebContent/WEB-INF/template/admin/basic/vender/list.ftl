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
[#include "/admin/include/head.ftl"]
</head>
<body>

<!-- Fixed navbar -->
[#include "/admin/include/navbar.ftl"]
<div id="cl-wrapper" class="fixed-menu">
[#include "/admin/include/sidebar.ftl"]

    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Supplier/Agencies</h2>
            <div class="pull-right option-left">
            <div class="btn-group">
					  <button type="button" onclick="location.href='add.jhtml'" class="btn btn-success md-trigger"  style="height:33px;">&nbsp;&nbsp;&nbsp;&nbsp; New &nbsp;&nbsp;&nbsp;&nbsp;</button>
					  <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown"  style="height:33px;">
						<span class="caret"></span>
						<span class="sr-only">Toggle Dropdown</span>
					  </button>
					  <ul class="dropdown-menu" role="menu">
						<li><a href="javascript:void(0)" id="exportButton">Export</a></li>
					  </ul>	
				</div>
				</div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Supplier/Agencies</li>
            </ol>
           	
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
							<h4 class="filter-bar"><i class="fa fa-filter"></i> Filter</h4>
							<div class="pull-right pull-cursor" title="Filter">
								<i id="filter" class="fa fa-angle-down"></i>&nbsp;&nbsp;
							</div>
							<div class="options" style="padding:10px;">
								<div  class="nav-panel">
									<div  class="nav-block">
										<div  class="block-head">
											<span  class="nav-title">Type</span>:
										</div>
										<div  class="block-body default-4-line">
											<div  class="params-cont"> 
												<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
													<span  class="unchecked"  name="typeSpan" checked="false" onclick="change(this,1);">Agency</span> 
												</a>
												<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
													<span  class="unchecked" name="typeSpan" checked="false" onclick="change(this,2);" >Supplier</span> 
												</a> 
												<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
													<span  class="unchecked" name="typeSpan" checked="false" onclick="change(this,3);" >Supplier/Agency</span> 
												</a> 
												<input type="hidden" id="typeSpan"/>
											</div>
										</div>
									</div>
									<div  class="nav-block">
										<div  class="block-head">
											<span  class="nav-title">Search</span>:
										</div>
										<form id="editform" method="post" action="[@spring.url '/admin/vender/edit.jhtml'/]">
											<div  class="block-body default-2-line">
												<div  class="params-cont">
													<input type="hidden" name="id" id="id" value="" />
													<input type="text" size="14" name="code" id="search_code" value="${vender.code}" placeholder="Search code..." />
													<input type="text" size="14" name="name" id="search_name" value="${vender.name}" placeholder="Search name..." />
													<input type="text" size="14" name="tel" id="search_tel" value="${vender.tel}" placeholder="Search tel..." />
													<input type="text" size="14" name="contactor" id="search_contactor" value="${vender.contactor}" placeholder="Search Contacts" />
													<input type="text" size="14" name="cityId" id="search_cityId" value="${vender.cityId}" placeholder="Suburb/City" />
													<input type="text" size="14" name="stateId" id="search_stateId" value="${vender.stateId}" placeholder="State/Province/Region" />
													<input type="text" size="14" name="countryName" id="search_countryName" value="${vender.countryName}" placeholder="Country" />
													<input type="text" size="14" name="zipcode" id="search_zipcode" value="${vender.zipcode}" placeholder="Post Code/ZipCode" /><br/>
												</div>
											</div>
										</form>
									</div>
									<div  class="nav-block">
										<div  class="block-head">
											<span  class="nav-title">Other</span>:
										</div>
										<div  class="block-body default-2-line">
											<div  class="params-cont">
												<input type="text" size="14" id="search_userName"  placeholder="UserName..." />
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
                        
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
                                  <tr>
                                  	<th></th>
                                  	<!-- <th>No.</th> -->
									<th>Trading Name</th>
									<th>Suburb/City</th>
									<th>State/Province/Region</th>
									<th>Post Code/ZipCode</th>
									<th>Country</th>
									<th>Type</th>
									<th>Status</th>
									<th>Action</th>
								  </tr>
                                    </thead>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4><i class="fa fa-warning"></i>Warning!</h4>

                    <p>Data will be permanently deleted ?</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <a href="#" class="btn btn-danger">Yes</a>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<form action="export.jhtml" id="excelForVendor" method="post">
		<input id="name" type="hidden" name="Name"/>
    	<input id="contactor" type="hidden" name="contactor"/>
    	<input id="address" type="hidden" name="address"/>
    	<input id="zipCode" type="hidden" name="zipCode"/>
    	<input id="UserName" type="hidden" name="UserName"/>
    	<input id="tel" type="hidden" name="tel"/>
    	<input id="fax" type="hidden" name="fax"/>
    	<input id="email" type="hidden" name="email"/>
    	<input id="remarks" type="hidden" name="remarks"/>
    	<input id="countryName" type="hidden" name="countryName"/>
    	<input id="stateId" type="hidden" name="stateId"/>
    	<input id="cityId" type="hidden" name="cityId"/>
    	<input id="code" type="hidden" name="code"/>
    	<input id="type" type="hidden" name="type"/>
    	<input id="userName" type="hidden" name="userName"/>
</form>
<!-- /.modal -->
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
     $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
       
        $("#datatable2").attr("width","100%");
        
         /* Formating function for row details */
        function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
    		sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Business Registration Number:   '+aData.registrationNo+'</td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Tel:   '+aData.tel+'</td></tr>';
 		    sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Email:   '+aData.email+'</td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Billing Email:   '+aData.billEmail+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Fax:   '+aData.fax+'</td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Contacts:   '+aData.contactor+'</td></tr>';
        	sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Address:   '+aData.address+'</td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Bank Name:   '+aData.bankName+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">SWIFT Code:   '+aData.businessCode+'</td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Branch Number:   '+aData.branchNo+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Bank Account Name:   '+aData.accountName+'</td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">Bank Account Number:   '+aData.accountNumber+'</td></tr>';
            sOut += '<tr><td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;">UserName:   '+aData.userName+'</td>';
            sOut += '<td style="border-left: 1px solid #DADADA;border-bottom: 1px solid #dadada;"></td></tr>';
            sOut += '</table>';
            return sOut;
        }
         
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bautoWidth":true,
            "bSort":false,
            "bFilter":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/vender/list.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.code = $("#search_code").val();
					data.name = $("#search_name").val();
					data.tel = $("#search_tel").val();
					data.contactor = $("#search_contactor").val();
					data.type=$("#typeSpan").val();
					data.cityId=$("#search_cityId").val();
					data.stateId=$("#search_stateId").val();
					data.countryName=$("#search_countryName").val();
					data.zipCode=$("#search_zipcode").val();
					data.userName=$("#search_userName").val();
				}
            },
           "columns": [
                { "data": null},
                // { "data": "code" },
                { "data": "name" },
                { "data": "cityId" },
                { "data": "stateId" },
                { "data": "zipCode" },
                { "data": "countryName" },
                { "data": "type",
                  "render":function(data, type, row) {
              			if(data == 1){
              				return 'Agency';
              			}else if(data == 2){
              				return 'Supplier';
              			}else{
              				return 'Supplier/Agency';
              			}
                 	}
                },
                { "data": "status",
                  "render":function(data, type, row) {
              			if(data == 1){
              				return 'Approved';
              			}else{	
              				return 'Disapproved';
              			}
                 	}
                },
                { "data": "venderId" }
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					html='<div class="btn-group">'
						+'<button class="btn btn-default btn-xs" type="button">Action</button>'
						+'<button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span><span class="sr-only">Toggle Dropdown</span></button>'
						+'<ul role="menu" class="dropdown-menu pull-right">'
							+'<li><a href="#" onclick="doTrade(\''+data+'\')"><i class="fa fa-pencil"></i>Edit</a></li><li class="divider"></li>'
							+'<li><a href="${base}/admin/vender/peerUserList?peerId='+data+'"><i class="fa fa-pencil"></i>New Agency User</a></li><li class="divider"></li>'
							+'<li><a data-href="${base}/admin/vender/del?id='+data+'"data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-times"></i>Delete</a></li>'
							[#list ["admin:admin","admin:account"] as permission]
								[@shiro.hasPermission name = permission]
									+'<li><a href="${base}/admin/vender/verify?id='+data+'"><i class="fa fa-pencil"></i></i>Approve</a></li>'
									[#break /]
								[/@shiro.hasPermission]
							[/#list]
						+'</ul>'
						+'</div>';
					return html;
                 },
				"targets" : 8
		    }],
		    "fnCreatedRow": function( nRow, aData, iDataIndex ) { 
         		$('td:eq(0)', nRow).html( '<img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" />' );
            }
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
        } );
        
       $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });  
        
      $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
      $('.dataTables_length select').addClass('form-control');    
        
		$("div.options").hide();//默认隐藏 筛选 div
		
		$("#filter").click(function(){
			$("div.options").slideToggle("slow");
			var _slide=$("#filter");
			if(_slide.attr('class')=="fa fa-angle-up"){
				_slide.removeClass("fa fa-angle-up").addClass("fa fa-angle-down");
			}else{
				_slide.removeClass("fa fa-angle-down").addClass("fa fa-angle-up");
			}
		});
		
		$("input[id^='search_']").on( 'keyup blur change', function () {
		    $("input[id^='search_']").each(function(){
		    if($(this).val().indexOf('"')>=0){
		        $(this).val($(this).val().replace('"',"'"));
		    }
		    });
			$('#datatable2').DataTable().draw();
		} );
});
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
			    $('#datatable2').DataTable().draw();
		  	}else{
		  		obj[$(span).attr('name')]=span.innerHTML;
			    span.className="checked";
			    span.checked=true;
			    $("#"+$(span).attr('name')+"").val(value);
			    $('#datatable2').DataTable().draw();
		  		}
    }
		 
	$("#exportButton").on( 'click', function () {
			$("#name").attr("value",$("#search_name").val());
			$("#code").attr("value",$("#search_code").val());
			$("#tel").attr("value",$("#search_tel").val());
			$("#contactor").attr("value",$("#search_contactor").val());
			$("#stateId").attr("value",$("#search_stateId").val());
			$("#countryName").attr("value",$("#search_countryName").val());
			$("#zipCode").attr("value",$("#search_zipcode").val());
			$("#cityId").attr("value",$("#search_cityId").val());
			$("#type").attr("value",$("#typeSpan").val());
			$("#userName").attr("value",$("#search_userName").val());
			$("#excelForVendor").submit();
		});
	function doTrade(venderId){
		$("#id").val(venderId);
		$("#editform").submit();
	}	 
</script>
</body>
</html>
