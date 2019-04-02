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
            <h2>New</h2>
            <ol class="breadcrumb">
               <li><a href="#">Home</a></li>
                <li><a href="#">Information</a></li>
                <li class="active">Passengers</li>
            </ol>
        </div>
        
	<div class="row">
      <div class="col-md-12">
      
        <div class="block-flat">
          <div class="header">							
            <h3>New</h3>
          </div>
          <div class="content">
              <form class="form-horizontal group-border-dashed" id="formId" action="save.jhtml" method="post">            
              <div class="form-group">
                <label class="col-sm-3 control-label">lastName</label>
                <div class="col-sm-6">
                  <input type="text" name="lastName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">middleName</label>
                <div class="col-sm-6">
                  <input type="text" name="middleName" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">firstName</label>
                <div class="col-sm-6">
                  <input type="text" name="firstName" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
       		  <div class="form-group">
                <label class="col-sm-3 control-label">Date of Birth</label>
                <div class="col-sm-6">
                   <div class="input-group date datetime col-md-5 col-xs-7" data-min-view="2" data-date-format="yyyy-mm-dd">
                    <input  name="dateOfBirth" class="form-control" size="16" type="text" value="" readonly>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>
                </div>
              </div>
              <div class="form-group">
               <label class="col-sm-3 control-label">Gender</label>
                <div class="col-sm-6">
                  <label class="radio-inline"> <input type="radio" checked="" name="sex" class="icheck" value="1"> Female</label> 
                  <label class="radio-inline"> <input type="radio" name="sex" class="icheck" value="2"> Male</label> 
                </div>
              </div>
   			 <div class="form-group">
                <label class="col-sm-3 control-label">Remark</label>
                <div class="col-sm-6">
                  <input type="text" name="memoOfCustomer" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Nationality</label>
                <div class="col-sm-6">
                  <input type="text" name="nationalityOfPassport" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Passport No.</label>
                <div class="col-sm-6">
                  <input type="text" name="passportNo" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Expiry Date</label>
          	   <div class="col-sm-6">
            	 <div class="input-group date datetime col-md-5 col-xs-7" data-min-view="2" data-date-format="yyyy-mm-dd">
                    <input  name="expireDateOfPassport" class="form-control" size="16" type="text" value="" readonly>
                    <span class="input-group-addon btn btn-primary"><span class="glyphicon glyphicon-th"></span></span>
                  </div>
                 </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Address</label>
                <div class="col-sm-6">
                  <input type="text" name="streetAddress" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Tel</label>
                <div class="col-sm-6">
                  <input type="text" name="tel" class="form-control" required parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
   			  <div class="form-group">
                <label class="col-sm-3 control-label">Mobile</label>
                <div class="col-sm-6">
                  <input type="text" name="mobile" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
               <div class="form-group">
                <label class="col-sm-3 control-label">Email</label>
                <div class="col-sm-6">
                  <input type="email" name="email" required parsley-type="email" class="form-control" placeholder="Max 6 chars." />
                </div>
              </div>
          	  <div class="form-group">
                <label class="col-sm-3 control-label">Notification Status</label>
                <div class="col-sm-6">
                 <select type="text" name="advertised" class="form-control">
                        <option value="1">Yes</option>
                        <option value="2">No</option>
               		</select>
                </div>
              </div>
           	  <div class="form-group">
                <label class="col-sm-3 control-label">Booking Remark</label>
                <div class="col-sm-6">
                  <input type="text" name="otherInfo" class="form-control"  parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Language</label>
                <div class="col-sm-6">
                  <select id="sellanguage" name="languageId" class="select2" >
					<option value="">Select</option>
					[#list languageList as language]
						<option value="${language.languageId}">${language.language}</option>
					[/#list]
				</select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Related Booking</label>
                <div class="col-sm-6">
                 <select type="text" name="customerSource" class="form-control">
                        <option value="1">Join-in Tour</option>
                        <option value="2">Hotel Booking</option>
                        <option value="3">Flight Booking</option>
               		</select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Flight Booking Type</label>
                <div class="col-sm-6">
               		<select type="text" name="Planticket" class="form-control">
                        <option value="1">Booked by Agent</option>
                        <option value="2">Booked by OP</option>
                        <option value="3">Booked by Agent & OP</option>
               		</select>
                </div>
              </div>
         	  <div class="form-group">
                <label class="col-sm-3 control-label">Remarks</label>
                <div class="col-sm-6">
                  <input type="text" name="payHistoryInfo" class="form-control" parsley-maxlength="6" placeholder="Max 6 chars." />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">ZipCode</label>
                <div class="col-sm-6">
				<input type="hidden" id="zipId" name="zip" style="width:100%;"/>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">Country</label>
                <div class="col-sm-6">
				<select id="selCountry" name="countryId" class="select2" >
					<option value="">Select</option>
					[#list countryList as country]
						<option value="${country.id}">${country.countryName}</option>
					[/#list]
				</select>               
                </div>
              </div>
          	   <div class="form-group">
                <label class="col-sm-3 control-label">State</label>
                <div class="col-sm-6">
				<select id="selState" name="stateId" class="select2" >
					<option value="">Select</option>
					[#list stateList as state]
						<option value="${state.id}">${state.stateName}</option>
					[/#list]
				</select>               
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-3 control-label">City</label>
                <div class="col-sm-6">
				<select id="selCity" name="cityId" class="select2" >
					<option value="">Select</option>
					[#list cityList as city]
						<option value="${city.id}">${city.cityName}</option>
					[/#list]
				</select>               
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                  <button type="button" onclick="redirect(1)" class="btn btn-default">Cancel</button>
                  <button type="reset" class="btn btn-default">Reset</button>
                  <button type="submit" class="btn btn-primary" style="margin-left:206px;">Save</button>
                  <button type="button" onclick="redirect(2)" class="btn btn-default">Save and New</button>
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
    	$("#zipId").select2({
			placeholder:"Search Zip Code",//文本框的提示信息
			minimumInputLength:3,	//至少输入n个字符，才去加载数据
			allowClear: false,	//是否允许用户清除文本信息
			ajax:{
				url:'[@spring.url '/admin/customer/listSelect.jhtml'/]',	//地址
				dataType:'text',	//接收的数据类型
				type: "POST",
				//contentType:'application/json',
				data: function (term, pageNo) {		//在查询时向服务器端传输的数据
					term = $.trim(term);  
	                return {  
	                     code: term   //联动查询的字符  
	                 }  
				},
				results:function(data,pageNo){
					var dataA = [];
					var dataStr=$.parseJSON(data);
					for(var i=0;i<dataStr.zipList.length;i++){
						var zip = dataStr.zipList[i];
						 dataA.push({id: zip.code, text: zip.code+'<br/>'+zip.country+'  '+zip.state+'  '+zip.city});
					}
					return {results:dataA};
				}
			},
			initSelection: function(element, callback) {
		    	var id = $(element).val();
			    if (id !== "") {
				    $.ajax("[@spring.url '/admin/customer/listSelect.jhtml?id='/]" + id, {
				    	dataType: "json",
				    	type: "POST"
				    	}).done(function(data) { 
				    		if(data.zipList[0]==undefined){
				    			callback({id:"",text:"Search Zip Code"});
				    		}else{
				    			callback({id: zip.code, text: zip.code+'-'+zip.country+'-'+zip.state+'-'+zip.city});
				    		}
				    	});
			    }
		    },
			formatResult: formatAsText,	//渲染查询结果项
			escapeMarkup: function (m) {
				return m; 
			}
		});
	    
	    //格式化查询结果,将查询回来的id跟name放在两个div里并同行显示，后一个div靠右浮动		
		function formatAsText(item){
		     var itemFmt ="<div style='display:inline;'>"+item.text+"</div>";
		     return itemFmt;
		}
    });
</script>
</body>
</html>
