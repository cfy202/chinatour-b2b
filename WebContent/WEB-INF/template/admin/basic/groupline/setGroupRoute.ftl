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
            <h2>Product</h2>
            <div class="new"><button class="btn btn-success btn-flat md-trigger" type="button" id="New" onclick="location.href='addGroupRoute.jhtml?groupLineId=${groupLine.id}'">&nbsp;&nbsp;New &nbsp;&nbsp;</button></div>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Product-Itinerary</li>
            </ol>
        </div>
    <div class="cl-mcont">    
		<div class="row">
	      <div class="col-md-12">
	        <div class="block-flat">
	          <div class="header">
	          	<h3>${groupLine.tourName}</h3>							
	            <input name="id" value="${groupLine.id}" type="hidden">
	          </div>
	          <div class="content">
	            
	            <table id="datatable2" class="table table-bordered">
			        <thead>
			            <tr>
			                <th style="width:0.5%;"></th>
			                <th>Name</th>
			                <th>Date</th>
			                <th style="display:none;"></th>
			                <th style="display:none;"></th>
			                <th>Action</th>
			            </tr>
			        </thead>
			        <tbody>
			        [#list groupRouteList as groupRoutes]
				        	<tr>
				        		<td style="width:0.5%;" onclick=""><img class="toggle-details" src="[@spring.url '/resources/images/plus.png'/]" /></td>
				                <td width="10%">${groupRoutes.routeName}</td>
				                <td width="10%">第 ${groupRoutes.dayNum} 天</td>
				                <td width="10%" style="display:none">${groupRoutes.routeDescribeForEn}</td>
				                <td width="10%" style="display:none">${groupRoutes.routeDescribeForUs}</td>
				                <td width="10%">
				                	<i class="fa fa-pencil"></i><a href="editGroupRoute.jhtml?id=${groupRoutes.id}">Edit</a>
				                </td>
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
[#include "/admin/include/foot.ftl"]
</body>
<script type="text/javascript">
    $(document).ready(function () {
        //initialize the javascript
        App.init();
        $("#datatables").attr("width","100%");
    });
      /*
         * Initialse DataTables, with no sorting on the 'details' column
         */
        var oTable = $('#datatable2').dataTable( {
        	"bSort":false,
            "aoColumnDefs": [
                { "bSortable": false, "aTargets": [ 0 ] }
            ],
            "aaSorting": [[1, 'asc']]
        });
   function fnFormatDetails ( oTable, nTr )
        {	
            var aData = oTable.fnGetData(nTr);
            //groupRouteForEn = nTr.children().eq(2).html();
            //alert(groupRouteForEn);
            //groupRouteForUs = aData.routeDescribeForUs;
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
            sOut += '<tr><td style="width:10%">Description(Chinese):</td><td>'+aData[3]+'</td></tr>';
            sOut += '<tr style="border-top:solid 1px #ccc""><td style="width:10%;">Description(English):</td><td>'+aData[4]+'</td></tr>';
            sOut += '</td></tr>';
            sOut += '</table>';
            return sOut;
        } 
        
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
		$('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
		$('.dataTables_length select').addClass('form-control');   
        
</script>
</html>
