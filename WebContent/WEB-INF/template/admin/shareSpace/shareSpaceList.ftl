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
            <h2>Training</h2>
            <div class="new"><button class="btn btn-success" type="button" id="New" data-toggle="modal" data-target="#confirm-delete"><i class="fa fa-upload"></i>上传</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Training</a></li>
            </ol>
        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">
                        <div class="header">
                            <h3>Row Details</h3>
                        </div>
                        <div class="content">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="datatable2">
                                    <thead>
		                                <tr>
			                                <th>File Name</th>
											<th width="40%">Action</th>
										</tr>
                                    </thead>
                                    <tbody>
                                    [#list shareSpaceList as shareSpace]
                                    	<tr>
		                                  	<th>${shareSpace.shareName} </th>
											<th>
												<div class="col-md-5 col-sm-5">
												[#if (shareSpace.shareUrl)??]
													<a href="${shareSpace.serverIp}${base}/admin/shareSpace/download?shareSpaceId=${shareSpace.shareSpaceId}"><i class="fa fa-download"></i>Download</a>
												[#else]
													<i class="fa fa-download"></i>Download
												[/#if]
												</div>
											</th>
									  	</tr>
									 [/#list]
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
<!-- Modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
             <div class="modal-body">
				<form class="form-horizontal group-border-dashed" id="formId" method="POST" enctype="multipart/form-data"   action="${base}/admin/shareSpace/upload.jhtml">
					<div class="form-group">
						<div class="col-sm-6">
							<input type="file"  name="file"  placeholder="Upload File" />
							<input type="hidden"  name="shareTypeId" value="${shareTypeId}" />
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
[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
     $(document).ready(function () {
        //initialize the javascript
        App.init();
        [@flash_message /]
        /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
       
        
       $('#confirm-delete').on('show.bs.modal', function (e) {
            $(this).find('#formId').attr('action', $('#upload').attr('href'));
        }); 
        
      $('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
      $('.dataTables_length select').addClass('form-control');    
        
    });
</script>
</body>
</html>
