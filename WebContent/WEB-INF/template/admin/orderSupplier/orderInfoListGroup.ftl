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
<!-- /.modal -->
<!-- Modal -->
<div class="modal fade" id="confirm-upload" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	Upload File
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
				<form class="form-horizontal group-border-dashed" id="formId" method="POST" enctype="multipart/form-data"   action="upload.jhtml">
					<div class="form-group">
						<div class="col-sm-6">
							<input type="file"  name="file"  placeholder="Upload File" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary" style="margin-left:206px;">Upload</button>
						</div>
					</div>
				</form>
			</div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>Billing(GROUP)</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
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
							<div class="options" style="margin:10px; padding:5px 0;">
									<div  class="nav-panel">
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Complete Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="completeStateSpan" checked="false" onclick="change(this,0);">Uncompleted</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="completeStateSpan" checked="false" onclick="change(this,1);" >Completed</span> 
													</a> 
													<input type="hidden" id="completeStateSpan"/>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Auditing Status</span>:
											</div>
											<div  class="block-body default-4-line">
												<div  class="params-cont"> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item" > 
														<span  class="unchecked"  name="allCheckSpan" checked="false" onclick="change(this,0);">New</span> 
													</a>
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="allCheckSpan" checked="false" onclick="change(this,1);" >Auditing Approved</span> 
													</a> 
													<a style="cursor:pointer;"  target="_self"  class=" param-item " > 
														<span  class="unchecked" name="allCheckSpan" checked="false" onclick="change(this,2);" >DisApproved</span> 
													</a> 
													<input type="hidden" id="allCheckSpan"/>
												</div>
											</div>
										</div>
										<div class="nav-block">
											<div class="block-head">
												<span class="nav-title">Arrival Date</span>:
											</div>
											<div class="block-body default-4-line pull-cursor">
												<div class="params-cont">
													<input type="text" id="search_beginningDate" size="14"  placeholder="Beginning Date." />
													<input type="text" id="search_endingDate" size="14"  placeholder="Ending Date." />
													&nbsp;<i id="clearDate" class="fa fa-rotate-left" title="Clear Date"></i>
												</div>
											</div>
										</div>
										<div  class="nav-block">
											<div  class="block-head">
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_tourCode" placeholder="tourCode..." />
													<input type="text" size="14" id="search_lineName" placeholder="lineName..." />
													
												</div>
											</div>
										</div>
									</div>
									<div  class="nav-panel">
										<div class="btn-cont">
											<input class="submit-btn"  type="submit" id="subId" value="Search">
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
                                        <th width="15%">Tour Code</th>
                                        <th width="15%">Product Name</th>
                                        <th>Arrival Date</th>
                                        <th>Operator</th>
                                        <th>Hotel/Cruise</th>
                                        <th>Flight</th>
                                        <th>Insurance</th>
                                        <th>Upload</th>
                                        <th>Audit Status</th>
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

<!--修改弹出框-->
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary" style=" width: 50%; max-height: 550px;">
	<div class="md-content">
		<div class="modal-header">
			<h3>Edit</h3>
			<!--模拟点击弹出框按钮-->
			<a href="javascript:void(0);" class="md-trigger" data-modal="form-primary" id="triggerId"></a>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form action="${base}/admin/supplierPrice/updateGroup.jhtml" id="updateId" method="post">
		</form>
	</div>
</div>
<!--/修改弹出框-->
<div class="md-overlay"></div>
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
       
       $("#datatable2").attr("width","100%");
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
            "bSort":false,
            "aLengthMenu":[20,40,80,100],
            "ajax": {
                url: "[@spring.url '/admin/supplierPrice/billListForGroup.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.tourCode = $("#search_tourCode").val();
					data.lineName = $("#search_lineName").val();
					data.allCheck = $("#allCheckSpan").val();
					data.completeState = $("#completeStateSpan").val();
					data.beginningDate = $("#search_beginningDate").val();
					data.endingDate = $("#search_endingDate").val();
				}
            },
            "columns": [
                { "data": "tourId","visible":false },
                { "data": "tourCode" },
                { "data": "lineName" },
                { "data": "arriveDateTime" },
                { "data": "supplierPrice.supType" ,
                	"class": "text-center" ,
                	"render": function (data, type, row) {
	              		var html="<a href='searchSupplierGroup.jhtml?type=1&tourId="+row.tourId+"&tourCode="+row.tourCode+"' >";
                			if(data!=null&&data.indexOf("1")>=0){
                				html+='<img src="[@spring.url '/resources/images/supplierprice_icon_w.png'/]" title="Recorded"/>'
                			}else{
                				html+='<img src="[@spring.url '/resources/images/supplierprice_icon.png'/]" title="Recording" />'
                			}
                			html+="</a>";
	              		return html;
                    }
                },
                { "data": "supplierPrice.supType" ,
                	"class": "text-center" ,
                	"render": function (data, type, row) {
                			var str=data
                			var html="<a href='searchSupplierGroup.jhtml?type=2&tourId="+row.tourId+"&tourCode="+row.tourCode+"'>";
                			if(data!=null&&data.indexOf("2")>=0){
                				html+='<img src="[@spring.url '/resources/images/hotel_icon_w.png'/]" title="Recorded" />'
                			}else{
                				html+='<img src="[@spring.url '/resources/images/hotel_icon.png'/]" title="Recording" />'
                			}
                			html+="</a>";
	              		return html;
                    }
                },
                { "data": "supplierPrice.supType" ,
                	"class": "text-center" ,
                	"render": function (data, type, row) {
	              		var html="<a href='searchSupplierGroup.jhtml?type=3&tourId="+row.tourId+"&tourCode="+row.tourCode+"'>";
                			if(data!=null&&data.indexOf("3")>=0){
                				html+='<img src="[@spring.url '/resources/images/filght_icn_w.png'/]" title="Recorded" />'
                			}else{
                				html+='<img src="[@spring.url '/resources/images/filght_icn.png'/]" title="Recording" />'
                			}
                			html+="</a>";
	              		return html;
                    }
                },
                { "data": "supplierPrice.supType" ,
                	"class": "text-center" ,
                	"render": function (data, type, row) {
	              		var html="<a href='searchSupplierGroup.jhtml?type=4&tourId="+row.tourId+"&tourCode="+row.tourCode+"'>";
                			if(data!=null&&data.indexOf("4")>=0){
                				html+='<img src="[@spring.url '/resources/images/insurance_icon_w.png'/]" title="Recorded" />'
                			}else{
                				html+='<img src="[@spring.url '/resources/images/insurance_icon.png'/]" title="Recording" />'
                			}
                			html+="</a>";
	              		return html;
                    }
                },
                { "data": "supplierPrice.supplierPriceId" },
                 { "data": "supplierPrice.allCheck" ,
                	"render": function (data, type, row) {
                		var html="";
                		if(data==2){
                			html="DisApproved";
                		}else if(data==0){
                			html="New";
                		}else if(data==1){
                			html="Auditing Approved";
                		}
	              			return html;
                    }
                },
                { "data": "supplierPrice.completeState" ,
                	"render": function (data, type, row) {
						var html="Recording";
                		if(data==0){
                			html="Uncompleted";
                		}else if(data==1){
                			html="Completed";
                		}
	              			return html;
                    }
                },
              	{ "data": "supplierPrice.supType" },
            ],
            "columnDefs" : [ {
				"render" : function(data, type, row) {
					return '<div class="btn-group"><button class="btn btn-default btn-xs" type="button">Action</button><button data-toggle="dropdown" class="btn btn-xs btn-primary dropdown-toggle" type="button"><span class="caret"></span>'
					+'<span class="sr-only">Toggle Dropdown</span></button><ul role="menu" class="dropdown-menu pull-right">'
					+'<li><a style="cursor:pointer;" href="javascript:void(0);" onclick="addForm(\''+row.tourId+'\');"><i class="fa fa-pencil"></i>Edit</a></li>'
					+'<li class="divider"></li><li><li><a style="cursor:pointer;" href="opTotalCheckGroup.jhtml?tourId='+row.tourId+'&tourCode='+row.tourCode+'"><i class="fa fa-pencil"></i>Auditing Details</a></li>'
					+'<li><a style="cursor:pointer;" href="totalBillOfTourGroup.jhtml?tourId='+row.tourId+'&tourCode='+row.tourCode+'"><i class="fa fa-pencil"></i>Bill</a></li>';
                 },
				"targets" : 11
		   }]
		   ,
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		    	var str='<div>';
		    	if(aData.supplierPrice.supplierPriceId!=null&&aData.supplierPrice.supplierPriceId.length>0){
		    		str+='<a data-href="${base}/admin/supplierPrice/uploadTourFileGroup?supplierPriceId='+aData.supplierPrice.supplierPriceId+'" style="cursor: pointer;"  data-toggle="modal"  data-target="#confirm-upload"><i class="fa fa-upload"></i></a>';
		    	}else{
		    		str+='<a href="javascript:getInfo();" style="cursor: pointer;"><i class="fa fa-upload"></i></a>';
		    	}
		    	if(aData.supplierPrice.fileUrl!=null&&aData.supplierPrice.fileUrl.length>0){
		    		str+='<a href="${base}/admin/supplierPrice/downloadTourFile?id='+aData.supplierPrice.supplierPriceId+'" ><i class="fa fa-download"></i></a>';
		    	}else{
		    		str+='<i class="fa fa-download"></i>';
	    		}
		    	  str+='</div>';
		        $('td:eq(7)', nRow).html(str);
		    }
            /**"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) { 
            	//样式居中
         		$('td:eq(3)', nRow).css("text-align","center");
         		$('td:eq(4)', nRow).css("text-align","center");
         		$('td:eq(5)', nRow).css("text-align","center");
         		$('td:eq(6)', nRow).css("text-align","center");
            }**/
            
        });
        $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('.btn-danger').attr('href', $(e.relatedTarget).data('href'));
        });
          $('#confirm-upload').on('show.bs.modal', function (e) {
            $(this).find('#formId').attr('action', $(e.relatedTarget).data('href'));
        });
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
		
		$("#subId").on( 'click', function () {
			$('#datatable2').DataTable().draw();
		} );
    });
    
    /*
		异步查询账单信息
	*/
	function addForm(tourId){
		$.ajax({
			type: "POST",
			url: "edit.jhtml",
			data:"tourId="+tourId,
			success: function(msg){
				if(msg.supplierPrice==null){
					alert("No Bill Unable to edit");
				}else{
					var html='<div class="modal-body form">'
									+'<div class="form-group">'
									+'	<div class="row no-margin-y">'
									+'		<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">'
									+'			Office：<input type="name" class="form-control" value="'+msg.supplierPrice.tourDept+'" name="tourDept" placeholder="DD">'
									+'		</div>'
									+'		<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">'
									+'			National Guide：<input type="name" class="form-control" value="'+msg.supplierPrice.accompany+'" name="accompany" placeholder="MM">'
									+'		</div>'
									+'		<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">'
									+'			Days：<input type="name" class="form-control" value="'+msg.supplierPrice.dayNum+'" name="dayNum" id="dayNumId"  placeholder="YYYY">'
									+'		</div>'
									+'		<div class="form-group col-md-3 col-sm-3  col-xs-3 no-margin">'
									+'			Nationality：'
									+'			<select type="text" name="nationality" id="nationality" class="select2">'
									+'				<option value="美国">美国</option>'
									+'				<option value="加拿大">加拿大</option>'
									+'				<option value="澳大利亚">澳大利亚</option>'
									+'				<option value="新西兰">新西兰</option>'
									+'				<option value="英国">英国</option>'
									+'				<option value="法国">法国</option>'
									+'				<option value="德国">德国</option>'
									+'				<option value="意大利">意大利</option>'
									+'				<option value="瑞士">瑞士</option>'
									+'				<option value="瑞典">瑞</option>'
									+'				<option value="俄罗斯">俄罗斯</option>'
									+'				<option value="西班牙">西班牙</option>'
									+'				<option value="日本">日本</option>'
									+'				<option value="韩国">韩国</option>'
									+'				<option value="蒙古">蒙古</option>'
									+'				<option value="印度尼西亚">印度尼西亚</option>'
									+'				<option value="马来西亚">马来西亚</option>'
									+'				<option value="菲律宾">菲律宾</option>'
									+'				<option value="新加坡">新加坡</option>'
									+'				<option value="泰国">泰国</option>'
									+'				<option value="印度">印度</option>'
									+'				<option value="越南">越南</option>'
									+'				<option value="缅甸">缅甸</option>'
									+'				<option value="朝鲜">朝鲜</option>'
									+'				<option value="巴基斯坦">巴基斯坦</option>'
									+'				<option value="其他">其他</option>'
									+'			</select>'
									+'		</div>'
									+'	</div>'
									+'</div>'
									+'<div class="form-group">'
									+'	<label>Remarks</label>'
									+'		<textarea class="form-control" name="remark">'+msg.supplierPrice.remark+'</textarea>'
									+'</div>'
									+'<div class="form-group">'
									+'	<label>Operation Bill Remark</label>'
									+'		<textarea class="form-control" name="subRemark">'+msg.supplierPrice.subRemark+'</textarea>'
									+'</div>'
									+'<input type="hidden" value="'+tourId+'" name="tourId" id="tourId" />'
									+'<div class="form-group">'
									+'<label>Completed Status：</label>';
									if(msg.supplierPrice.completeState==0){
										html+='<label class="radio-inline"> <input type="radio"  name="completeState" checked=""class="icheck" value="0">No</label> '
											+'<label class="radio-inline"> <input type="radio" name="completeState" class="icheck" value="1">Yes</label> ';
									}else{
										html+='<label class="radio-inline"> <input type="radio"  name="completeState" class="icheck" value="0">No</label> '
										+'<label class="radio-inline"> <input type="radio" name="completeState" checked="" class="icheck" value="1">Yes</label> ';
									}
									
									html+='</div>'
								+'</div>'
								+'<div class="modal-footer">'
									+'<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>'
									+'<button type="submit" class="btn btn-primary btn-flat" >Proceed</button>'
								+'</div>';
							$("#updateId").empty();
							$("#updateId").append(html);
							$("#updateId").find('.icheck').iCheck({
								checkboxClass: 'icheckbox_square-blue checkbox',
								radioClass: 'iradio_square-blue'
							});
							$("#updateId").find("select.select2").select2({
								width: '100%'
							}); 
					$("#triggerId").trigger("click");
				}
			}
		});
	}
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
	function getInfo(){
		alert("请先录入账单!");
	}
</script>
</body>
</html>
