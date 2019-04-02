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
            <h2>Edit</h2>
            <ol class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">States</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit</h3>
          </div>
          <div class="content">
            <form class="form-horizontal group-border-dashed" action="update.jhtml" method="post">
              <input type="hidden" name="id" value="${state.id}" class="form-control" required placeholder="Min 6 chars." />
              <div class="form-group">
                <label class="col-sm-3 control-label">State Name</label>
                <div class="col-sm-6">
                  <input type="text" name="stateName" value="${state.stateName}" class="form-control" required parsley-minlength="6" placeholder="Min 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Country</label>
                <div class="col-sm-6">
                  <select type="text" name="country.id" class="select2">
                    [#list countrys as country]
                      <option value="${country.id}"
                      [#if "${country.id==state.country.id}"]
                       selected="selected"
                      [/#if ]  >${country.countryName}</option>
                    [/#list]
                   </select>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="submit" style="margin-left:336px;" class="btn btn-primary">Save</button>
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
