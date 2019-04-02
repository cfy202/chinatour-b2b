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
                <li class="active">Currency</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>Edit</h3>
          </div>
          <div class="content">
            <form class="form-horizontal group-border-dashed" action="update.jhtml" method="post" >
              <input type="hidden" name="id" value="${currencyType.id}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
              <div class="form-group">
                <label class="col-sm-3 control-label">Chinese</label>
                <div class="col-sm-6">
                  <input type="text" name="currencyChs" value="${currencyType.currencyChs}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">English</label>
                <div class="col-sm-6">
                  <input type="text" name="currencyEng" value="${currencyType.currencyEng}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Symbol</label>
                <div class="col-sm-6">
                  <input type="text" name="symbol" value="${currencyType.symbol}" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
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
</body>
</html>
