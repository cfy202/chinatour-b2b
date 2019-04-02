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
    <div class="mail-inbox">
      
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
												<span  class="nav-title">Others</span>:
											</div>
											<div  class="block-body default-2-line">
												<div  class="params-cont"> 
													<input type="text" size="14" id="search_title" placeholder="title..." />
												</div>
											</div>
										</div>
									</div>
									<div  class="nav-panel">
										<div class="btn-cont">
											<input class="submit-btn"  type="submit" id="subId" value="OK">
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
								        	<th></th>
								        	<th></th>
								        	<th></th>
								        	<th></th>
								            <th>
								            	<div class="filters">
											        <input id="check-all" type="checkbox" name="checkall" />
										        </div>
								            </th>
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
                    <h4><i class="fa fa-warning"></i>Warning !</h4>

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
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
    [@flash_message /]
    	
    	var oTable = $('#datatable2').dataTable({
            "processing": true,
            "serverSide": true,
            "bFilter":false,
          	"bSort":false,
            "ajax": {
                url: "[@spring.url '/admin/notice/listIn.jhtml'/]",
                type: "POST",
                "data": function ( data ) {
					data.title = $("#search_title").val();
				}
            },
            
            "columns": [
                { "data": "noticeContactId","visible":false},
                { "data": "state","visible":false},
                { "data": "admin.username","visible":false},
                { "data": "notice.createDate","visible":false},
                { "data": "notice.content","visible":false},
                { "data": "notice.title" }
            ],
		  "fnCreatedRow": function( nRow, aData, iDataIndex ) {
		      var str='<div id="open_mail" class="mails">'+
				        '<div class="item">'+
				          '<div><input type="checkbox" name="noticeContactId" value="'+aData.noticeContactId+'" class="iCheck"/> </div>'+
				          '<div>';
				            if(aData.state==0){
				            	str +='<span class="date pull-right inbox_font" title="Unread"><i class="fa fa-envelope"></i>';
				            }else if(aData.state==1){
				            	str +='<span class="date pull-right" title="Read"><i class="fa fa-inbox"></i>';
				            }
				            
				            str += '<i class="fa fa-paperclip "></i>'+aData.notice.createDate+'</span>';
				            if(aData.state==0){
				            	str +='<p class="inbox_font"  title="Unread">'+aData.admin.username+'</p>'+
				            		'<p class="from"  title="Unread">'+aData.notice.title+'</p>';
				            }else if(aData.state==1){
				            	str +='<h4 class="from"  title="Read">'+aData.admin.username+'</h4>'+
				            		'<p class="msg"  title="Read">'+aData.notice.title+'</p>';
				            }
				          str +='</div>'+
				        '</div>'+
				      '</div>';
		        $('td:eq(0)', nRow).html(str);
		    } 
        });
    
        $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue checkbox',
        radioClass: 'icheckbox_square-blue'
      });
      
      $("#check-all").on('ifChanged',function(){
        var checkboxes = $(".mails").find(':checkbox');
        if($(this).is(':checked')) {
            checkboxes.iCheck('check');
        } else {
            checkboxes.iCheck('uncheck');
        }
      });
        
      $('#datatable2').delegate('tbody tr','click', function () {
      		var aData = oTable.fnGetData(this);
            location.href="details.jhtml?id="+aData.noticeContactId;
        } );
        
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
</script>
</body>
</html>
