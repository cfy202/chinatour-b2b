[#assign shiro=JspTaglibs["/WEB-INF/tld/shiro.tld"] /]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
<div class="md-modal colored-header custom-width md-effect-9" id="form-primary">
	<div class="md-content">
		<div class="modal-header">
			<h3>Add</h3>
			<button type="button" class="close md-close" data-dismiss="modal" aria-hidden="true">&times;</button>
		</div>
		<form method="post" action="[@spring.url '/admin/roomSharing/addRoom.jhtml'/]">
			<div class="modal-body form">
				<div class="text-center">
					<h4>Are you sure to confirm?</h4>
					<p>please type verify remarks below.</p>
					<div class="text-center"id="centerId">
						<textarea name="description" style="width:95%;height:60px"></textarea>
						<input type="hidden" value="${roomSharing.roomSharingId}" name="roomSharingId" id="roomSharingId"/>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-flat md-close" data-dismiss="modal">Cancel</button>
				<button type="submit" class="btn btn-primary" data-dismiss="modal"  data-toggle="modal">OK</button>
			</div>
		</form>
	</div>
</div>
<div class="md-overlay"></div>
<!-- /.modal -->
    <div class="container-fluid" id="pcont">
        <div class="page-head">
            <h2>View</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Tour</a></li>
                <li class="active">Room/Tour Sharing</li>
                <a href="javascript:void(0);" onclick="history.go(-1);" class="btn pull-right"><i class="fa fa-mail-reply" title="back"></i></a>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" method="POST"   action="${base}/admin/roomSharing/update.jhtml">
               <input type="hidden" name="roomSharingId" value="${roomSharing.roomSharingId}" />
				  <table style="padding:10px;border: 0px none" width="100%">
					<tbody>
						<tr>
							<td width="13%">
								<span>
									Product Code:
								</span>
							</td>
							<td width="37%">
								${roomSharing.productCode}
							</td>
							<td width="13%">
								<span>
									Product Name:
								</span>
							</td>
							<td width="37%">
								${roomSharing.productName}
							</td>
						</tr>
						<tr>
						[#if (roomSharing.roomOrTour)==1]	
							<td width="13%">
								<span>
									Gender:
								</span>
							</td>
							<td width="37%">
								[#if roomSharing.sex ==1] Female [/#if]
     							[#if roomSharing.sex ==2] Male [/#if]
							</td>
						[#else]
								<td width="13%">
									<span>
										Total Passengers:
									</span>
								</td>
								<td width="37%">
								${roomSharing.totalPeople}
								</td>
							[/#if]
							<td width="13%">
								<span>
									Arrival Date:
								</span>
							</td>
							<td width="37%">
							  [#if roomSharing.arrivalDate??] ${roomSharing.arrivalDate?string("yyyy-MM-dd")} [/#if]
							</td>
						</tr>
						<tr>
							<td width="13%">
								<span>
									Tour Type:
								</span>
							</td>
							<td width="37%">
								[#list tourTypeList as tourType]
									[#if roomSharing.tourType==(tourType.tourTypeId)]
										${tourType.typeName}
									[/#if]
								[/#list]
							</td>
							[#if (roomSharing.roomOrTour)==1]	
							<td width="13%">
								<span>
									Room Type:
								</span>
							</td>
							<td width="37%">
								[#list constant.GUEST_ROOM_TYPES as room]
									[#if roomSharing.roomType==room]
										${room}
									[/#if]
								[/#list]
							</td>
							[#else]
								<td width="13%">
								</td>
								<td width="37%">
								</td>
							[/#if]
						</tr>
						<tr>
							<td width="13%">
								<span>
									Status:
								</span>
							</td>
							<td width="37%">
				                  [#if roomSharing.status ==0] Pending [/#if]
				                  [#if roomSharing.status ==1] Closed [/#if]
							</td>
							<td width="13%">
							   <span>
							      Remark:
							   </span>
							</td>
							<td width="37%">
							     ${roomSharing.remark}
							</td>
						</tr>
					</tbody>
				</table>
			<h4 style="background:#2BBCA0;height:30px;line-height:30px;padding:0 5px;color:#ffffff;cursor:pointer;margin-top：20px;">
				<i class="fa fa-bars"></i>
				<span class="customerNumber">Massage</span>
				<div class="pull-right">
	               <i class="fa fa-angle-up"></i>&nbsp;&nbsp;
	           </div>
	        </h4>
				<div class="panel-body block-flat">
				[#if roomSharing.status ==0]
				<div class="header">
					<button type="button" id="btn" class="btn btn-primary btn-flat md-trigger pull-right" data-toggle="modal" data-modal="form-primary">Add</button>
				</div>
				[/#if]
					<table class="no-border">
						<thead class="no-border">
							<tr>
								<th style="font-weight:bold;font-size:14px;">Agent</th>
								<th style="font-weight:bold;width:60%;font-size:14px;">Description</th>
							</tr>
						</thead>
						<tbody class="no-border-x"  id="addContent">
							[#if (roomSharing.description)??]
								[#assign json=roomSharing.description?eval/]
								[#list json as item]
									<tr>
										<td>
											${item.userName}
										</td>
										<td>
											${item.description}
										</td>
									</tr>
								[/#list]
							[/#if]
						</tbody>
					</table>
				</div>
          </div>
        </div>
        
      </div>
    </div>

</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
$(document).ready(function () {
	App.init();
	$("form select.select2").select2({
		width: '60%'
	});
});   
</script>
</body>
</html>
