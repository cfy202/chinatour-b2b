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
            <h2>Region</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
             <form class="form-horizontal group-border-dashed" id="formId" action="save.jhtml" method="post" parsley-validate novalidate>            
               <div class="form-group">
                <label class="col-sm-3 control-label">Region Name</label>
                <div class="col-sm-6">
                  <input type="text" name="regionName" class="form-control" />
                </div>
              </div>
              
              <div class="form-group">
                 <label class="col-sm-3 control-label">Department:</label>
				 <div class="col-sm-6">
                    [#list dept as dept]
                        <div class="radio">
                           <label><input type="checkbox" name="deptId" value="${dept.deptId}"/>${dept.deptName}</label>
                         </div>
                     [/#list]
                  </div>
              </div>
              
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
              	  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
                </div>
              </div>
            </form>
          </div>
        </div>
        
      </div>
    </div>

</div>

[#include "/admin/include/foot.ftl"]
<script type="text/javascript">
    $(document).ready(function () {
    	App.init();
    });
</script>
</body>
</html>
