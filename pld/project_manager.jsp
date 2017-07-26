<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>1</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style3.css">
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" type="text/css" href="css/normalize.css" />
<link rel="stylesheet" type="text/css" href="css/default.css">
<link href="css/dist/pagination.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery.min.js"></script>

<script src="3dgis/js/class/PMO/Project.js"></script>
<script src="3dgis/js/class/PMO/Option.js"></script>

<script>
// This is how to call the dom on parent with jquery
console.log($(parent.document).find('#spanProjectName').html());

function createDemo(name){
	var container = $('#pagination-' + name);
	var sources = function(){
		var result = [];

		for(var i = 1; i < 50; i++){
			result.push(i);
			console.log('result');
		}

		return result;
	}();

	var options = {
	dataSource: sources,
	className: 'paginationjs-theme-blue',
	 callback: function(response, pagination){
	                    window.console && console.log(response, pagination);

	                   var dataHtml = '<table class="listtable">';
							dataHtml += '<tr><td style="width:20px;padding-left:3px;padding-top:3px;"><input type="checkbox" name="selectedAll" id="selectedAll" onclick="check(this);"/></td><td style="width:100px;">Project Name</td><td>Description</td><td>Create By User</td><td>Create By Post</td><td>Create Date</td><td style="width:80px;">Option</td></tr>'
	                    $.each(response, function(index, item){
							dataHtml += '<tr><td style="padding-left:3px;padding-top:3px;"><input type="checkbox" name="selected_id[]"  id="selected_id_'+item+'" value="'+ item +'"/></td>';
	                        dataHtml += '<td><span style="padding-left:5px;">'+ item +'</span></td>';
	                        dataHtml += '<td><span style="padding-left:5px;">'+ item +'</span></td>';							
	                        dataHtml += '<td><span style="padding-left:5px;">'+ item +'</span></td>';							
	                        dataHtml += '<td><span style="padding-left:5px;">'+ item +'</span></td>';							
							dataHtml += '<td><span style="padding-left:5px;">'+ item +'</span></td>';		
							dataHtml += '<td><button class="viewbutton" style="padding:0 3px;" onclick=\"view('+item+');\">view</button>';
							dataHtml += '<button class="viewbutton" style="margin-left:5px;padding:0 3px;" onclick=\"open('+item+');\">open</button></td></tr>';
							
	                    });

	                    dataHtml += '</table>';

	                    container.prev().html(dataHtml);
	                }
	            };

	            //$.pagination(container, options);

	            container.addHook('beforeInit', function(){
	                window.console && console.log('beforeInit...');
	            });
	            container.pagination(options);

	            container.addHook('beforePageOnClick', function(){
	                window.console && console.log('beforePageOnClick...');
	                //return false
	            });

	            return container;
}

function projectUIControl() {
	var project = parent.threeDGIS.project;
	if(project!=undefined) {
		if(project.name!=undefined) {
			$('#project_name').html('Project Management ['+project.name+']');
			$('#edit').prop('disabled',false);
			$('#delete').prop('disabled',false);
			$('#copy').prop('disabled',false);
			$('#create2').prop('disabled',false);
			$('#open2').prop('disabled',false);
			
			$(parent.document).find('#spanProjectName').attr('title',project.name);
			if(project.name.length>20)
				$(parent.document).find('#spanProjectName').html(project.name.substring(0,16)+'...');
			else
				$(parent.document).find('#spanProjectName').html(project.name);
		}
		else {
			$(parent.document).find('#spanProjectName').html('No project opened');
			$(parent.document).find('#spanProjectName').attr('title','');
		}
		
		var option = project.options[0];
		if(option!=undefined) {
			if(option.name!=undefined) {
				$('#do_name').html(option.name);
				$('#edit2').prop('disabled',false);
				$('#delete2').prop('disabled',false);
				$('#copy2').prop('disabled',false);
				
				$(parent.document).find('#spanOptionName').attr('title',option.name);
				if(option.name.length>20)
					$(parent.document).find('#spanOptionName').html(option.name.substring(0,16)+'...');
				else
					$(parent.document).find('#spanOptionName').html(option.name);
			}
			else {
				$(parent.document).find('#spanOptionName').html('No option opened');
				$(parent.document).find('#spanOptionName').attr('title','');
			}
		}
		else {
			$(parent.document).find('#spanOptionName').html('No option opened');
			$(parent.document).find('#spanOptionName').attr('title','');
		}
	}
	else {
		$(parent.document).find('#spanProjectName').html('No project opened');
		$(parent.document).find('#spanProjectName').attr('title','');
	}
}

$(document).ready(function(){
	$("#create").click(function(){
		$("#div2").css("display","none");
		$("#div3").css("display","none");
		toggle('div1');
	});
	  
	projectUIControl();
});
 
 
$(document).ready(function(){
  $("#create2").click(function(){
	  $("#div23").css("display","none");
	  toggle('div22');
  });
});


$(document).ready(function(){
  $("#open").click(function(){
	$("#div3").css("display","none");
	$("#div1").css("display","none");
	toggle('div2');
  });
});

$(document).ready(function(){
  /*$("#open2").click(function(){
	toggle('table2');
   $('#edit2').attr("disabled",false); 
  });*/
});
 
function toggle(targetid){
    if (document.getElementById){
        target=document.getElementById(targetid);
            if (target.style.display=="block"){
                target.style.display="none";
            } else {
                target.style.display="block";
            }
    }
}

$(document).ready(function(){
  $("#save").click(function(){ 
	var userid=document.getElementById("username").value;  
	var post=document.getElementById("post").value;  
	var projectname=document.getElementById("name").value;  
	var description = document.getElementById('description').innerHTML;
	//var description=document.getElementById("description").value; 
	var mode="create";
	$("#projectname").val(projectname);
	$("#projecdescription").val(description);
	 $.ajax({  
                    type:"GET",  
                    url: "../../../springmvc/PMCreate?userid="+userid+"&post="+post+"&projectname="+projectname+"&description="+description,  
                    success:function(data){	
					$("#project_name").text('Project Management ['+projectname+']'); 
					alert("Create Project "+projectname+" successfully.");
					parent.threeDGIS.threeDView.removeProject();
					$("#projectid").val(data);
					$('#edit').attr("disabled",false); 
					$('#delete').attr("disabled",false); 
					$('#copy').attr("disabled",false); 
					$('#create2').attr("disabled",false); 
					$('#edit2').attr("disabled",true); 
					$('#delete2').attr("disabled",true); 
					$('#copy2').attr("disabled",true); 
					$('#open2').attr("disabled",false);
					 $("#div1").css("display","none");
						parent.threeDGIS.project = new Project([]);
						parent.threeDGIS.project.name = projectname;
						parent.threeDGIS.project.id = data;
						
						projectUIControl();
					 
                    //createShowingTable(data); 
                    }  ,
					error:function(data) {					
						 alert("error save");
						   },
                }); 
  });
});


$(document).ready(function(){
  $("#save2").click(function(){ 
	var projectid = parent.threeDGIS.project.id;  
	var userid=document.getElementById("username").value;  
	var post=document.getElementById("post").value;  
	var doname=document.getElementById("name2").value;  
	var dodescription=document.getElementById('description2').innerHTML;  
	
	var bldg=document.getElementById("bldg").value;  
	var gfa=document.getElementById("gfa").value;  
	var sitearea=document.getElementById("sitearea").value;  
	var sitecoverage=document.getElementById("sitecoverage").value;  
	var plotratio=document.getElementById("plot").value;  
	var mode="create";
	$("#doname").val(doname);
	$("#dodescription").val(dodescription);
	 $.ajax({  
                    type:"GET",  
                    url: "../../../springmvc/DOCreate?userid="+userid+"&post="+post+"&projectid="+projectid+"&doname="+doname+"&dodescription="+dodescription+"&bldg="+bldg+"&gfa="+gfa+"&sitearea="+sitearea+"&sitecoverage="+sitecoverage+"&plotratio="+plotratio,  
                    success:function(data){	
					$("#do_name").text(doname); 
					alert("Create Design Option "+doname+" successfully.");
					parent.threeDGIS.threeDView.removeProject();
					$("#doid").val(data);
					$('#edit2').attr("disabled",false); 
					$('#delete2').attr("disabled",false); 
					$('#copy2').attr("disabled",false); 					
					 $("#div22").css("display","none");
                    //createShowingTable(data); 
						parent.threeDGIS.project.options[0] = new Option({
							name: doname,
							id: data
						});
						projectUIControl();
                    }  ,
					error:function(data) {					
						 alert("error save");
						   },
                }); 
  });
});

$(document).ready(function(){
  $("#delete").click(function(){
	 var projectid = parent.threeDGIS.project.id;
	 var projectname = parent.threeDGIS.project.name;
	var userid=document.getElementById("username").value;  
	var post=document.getElementById("post").value;  
	
	// var selectItem = new Array();
        // $("input[name='selected_id[]']:checked").each(function() {
            // selectItem.push($(this).val());// 在数组中追加元素
        // });
	 // if (selectItem.length == 0) {
            // alert("请选择要批量删除的选项！");
        // }else {
	// alert(selectItem);
		// }
	 $.ajax({  
			type:"GET",  
			url: "../../../springmvc/PMDelete?projectid="+projectid+"&userid="+userid+"&post="+post,  
			success:function(data){
				alert("Delete Project "+projectname+" successfully.");
				parent.threeDGIS.threeDView.removeProject();
				$("#projectname").val("");
				$("#projecdescription").val("");
				$("#project_name").text("Project Management[no project]"); 
				$("#projectid2").val(data);
				$('#edit').attr("disabled",true); 
				$('#delete').attr("disabled",true); 
				$('#copy').attr("disabled",true); 
				$('#create2').attr("disabled",true); 
				$('#edit2').attr("disabled",true); 
				$('#delete2').attr("disabled",true); 
				$('#copy2').attr("disabled",true); 
				$('#open2').attr("disabled",true);
				$("#div1").css("display","none");
				 
				parent.threeDGIS.project = undefined;
				projectUIControl();
				$('#Search').click();
			} ,
			error:function(data) {						 
				 alert("delete error");
			}
		}); 
	});
});

$(document).ready(function(){
  $("#delete2").click(function(){
	var doid = parent.threeDGIS.project.options[0].id;
	var doname = parent.threeDGIS.project.options[0].name;  
	var userid=document.getElementById("username").value;  
	var post=document.getElementById("post").value;  
	 $.ajax({  
                    type:"GET",  
                    url: "../../../springmvc/DODelete?doid="+doid+"&userid="+userid+"&post="+post,  
                    success:function(data){
					alert("Delete Design Option "+doname+" successfully.");
					parent.threeDGIS.threeDView.removeProject();
					$("#doname").val("");
					$("#dodescription").val("");
					$("#do_name").text(""); 
					$("#doid").val(data); 
					$('#edit2').attr("disabled",true); 
					$('#delete2').attr("disabled",true); 
					$('#copy2').attr("disabled",true); 
					 $("#div1").css("display","none");
					 
					 parent.threeDGIS.project.options[0] = undefined;
					projectUIControl();
					$('#open2').click();
                    }  ,
					error:function(data) {						 
						 alert("delete error");
						   },
                }); 
  });
});


$(document).ready(function(){
  $("#copy").click(function(){
	 var projectid = parent.threeDGIS.project.id;
	var userid=document.getElementById("username").value;  
	var post=document.getElementById("post").value;  
	
	// var selectItem = new Array();
        // $("input[name='selected_id']:checked").each(function() {
            // selectItem.push($(this).val());// 在数组中追加元素
        // });
	 // if (selectItem.length == 0) {
            // alert("请选择要批量删除的选项！");
        // }else {
	// alert(selectItem);
		// }
	
	 $.ajax({  
                    type:"GET",  
                    url: "../../../springmvc/PMCopy?projectid="+projectid+"&userid="+userid+"&post="+post,  
                    success:function(data){
					alert("Copy Project "+parent.threeDGIS.project.name+" successfully.");
                    }  ,
					error:function(data) {
						 
						 alert("copy error");
						   },
                }); 
  });
});


$(document).ready(function(){
  $("#copy2").click(function(){
	 var projectid = parent.threeDGIS.project.id;
	var userid=document.getElementById("username").value;  
	var post=document.getElementById("post").value;  
	 var doid = parent.threeDGIS.project.options[0].id;
	var doname=parent.threeDGIS.project.options[0].name;  
	 $.ajax({  
			type:"GET",  
			url: "../../../springmvc/DOCopy?projectid="+projectid+"&doid="+doid+"&userid="+userid+"&post="+post,  
			success:function(data){
				alert("Copy Design Option "+doname+" successfully.");
				$('#open2').click();
			}  ,
			error:function(data) {
				 
				 alert("delete error");
			},
		}); 
  });
});


$(document).ready(function(){
  $("#Search").click(function(){
	var projectname=$('#txtSearchName').val();  
	var userid=$('#txtSearchUserid').val();
	var post=$('#txtSearchUserpost').val();
	var description=$('#txtSearchDescription').val();  
	var datefrom=$('#txtSearchFromDate').val();  
	var dateto=$('#txtSearchToDate').val();
	
	var container = $('#pagination-demo1');
	var sources = function(){
	var result = [];

	for(var i = 1; i < 50; i++){
	    result.push(i);
	}

	return result;
	}();

	

		// return container;
	
	
		var url = '../../../springmvc/PMSearch?';
		if(projectname.trim()!='')
			url += 'projectname='+projectname+'&';
		if(description.trim()!='')
			url += 'description='+description+'&';
		if(userid.trim()!='')
			url += 'userid='+userid+'&';
		if(post.trim()!='')
			url += 'post='+post+'&';
		if(datefrom.trim()!='')
			url += 'datefrom='+datefrom+'&';
		if(dateto.trim()!='')
			url += 'dateto='+dateto+'&';
			  
		$.ajax({  
            type:"GET",  
            url: url,//+"&datefrom="+datefrom+"&dateto="+dateto,  
             success:function(data){	
				// alert(data);
				// alert('successfully');
				
				console.log('PMSearch');
				
				if(data=='' || data.length==0)
					return;	// Should be a 'not found' nontification
				
				data = JSON.parse(data);
				console.log(data);
				
				var options = {
					dataSource: data,
					className: 'paginationjs-theme-blue',
					callback: function(response, pagination){
						window.console && console.log(response, pagination);
							
						var dataHtml = '<table class="listtable">';
							dataHtml += '<tr><td style="width:20px;padding-left:3px;padding-top:3px;"><input type="checkbox" name="selectedAll" id="selectedAll" onclick="check(this);"/></td><td style="width:100px;">Project Name</td><td>Description</td><td>Create By User</td><td>Create By Post</td><td>Create Date</td><td style="width:80px;">Option</td></tr>'
						$.each(response, function(index, item){
							var projectNameDisplay = item.PROJECTNAME;
							if(item.PROJECTNAME.length>20)
								projectNameDisplay = projectNameDisplay.substring(0,16)+'...';
							
							dataHtml += '<tr><td style="padding-left:3px;padding-top:3px;"><input type="checkbox" name="selected_id[]"  id="selected_id_'+item+'" value="'+ item +'"/></td>';
							dataHtml += '<td><span style="padding-left:5px;">'+ projectNameDisplay +'</span></td>';
							dataHtml += '<td><span style="padding-left:5px;">'+ item.P_DESCRIPTION +'</span></td>';							
							dataHtml += '<td><span style="padding-left:5px;">'+ item.CREATED_BY_USERID +'</span></td>';							
							dataHtml += '<td><span style="padding-left:5px;">'+ item.CREATED_BY_POST +'</span></td>';							
							dataHtml += '<td><span style="padding-left:5px;">'+ item.CREATED_DATE +'</span></td>';		
							dataHtml += '<td><button class="viewbutton" style="padding:0 3px;" onclick=\"view(\''+item.PROJECTNAME+'\',\''+item.PMRID+'\');\">open</button></td></tr>';
							// dataHtml += '<button class="viewbutton" style="margin-left:5px;padding:0 3px;" onclick=\"open(\''+item.PROJECTNAME+'\');\">open</button></td></tr>';
						});

						dataHtml += '</table>';

						container.prev().html(dataHtml);
					}
				};

					//$.pagination(container, options);

					container.addHook('beforeInit', function(){
						window.console && console.log('beforeInit...');
					});
					container.pagination(options);

					container.addHook('beforePageOnClick', function(){
						window.console && console.log('beforePageOnClick...');
						//return false
					});
            },
			error:function(data) {					
				console.log(data);
			}
        }); 
	});
	
$("#open2").click(function(){
		$("#div22").css("display","none");
		$("#div23").css("display","block");
		
		var pid = parent.threeDGIS.project.id;
		var container = $('#pagination-demo2');
	
		$('#delete').attr("disabled",false);  	  
		$.ajax({  
            type:"GET",  
            url: '../../../springmvc/DOSearch?projectid='+pid,  
             success:function(data){	
				// alert(data);
				// alert('successfully');
				
				console.log('DOSearch');
				parent.threeDGIS.threeDView.removeProject();
				
				if(data=='' || data.length==0)
					return;	// Should be a 'not found' nontification
				
				data = JSON.parse(data);
				console.log(data);
				
				var options = {
					dataSource: data,
					className: 'paginationjs-theme-blue',
					callback: function(response, pagination){
						window.console && console.log(response, pagination);

						var dataHtml = '<table class="listtable">';
							dataHtml += '<tr><td style="width:20px;padding-left:3px;padding-top:3px;"><input type="checkbox" name="selectedAll" id="selectedAll" onclick="check(this);"/></td><td style="width:100px;">Option Name</td><td>Create Time</td><td>Last Modify Time</td><td style="width:80px;">Option</td></tr>'
						$.each(response, function(index, item){
							dataHtml += '<tr><td style="padding-left:3px;padding-top:3px;"><input type="checkbox" name="selected_id[]"  id="selected_id_'+item+'" value="'+ item +'"/></td>';
							dataHtml += '<td><span style="padding-left:5px;">'+ item.OptionName +'</span></td>';
							dataHtml += '<td><span style="padding-left:5px;">'+ item.CreateTime +'</span></td>';							
							dataHtml += '<td><span style="padding-left:5px;">'+ item.LstModiTime +'</span></td>';								
							dataHtml += '<td><button class="viewbutton" style="padding:0 3px;" onclick=\"viewOption(\''+item.OptionName+'\',\''+item.OptionID+'\');\">open</button></td></tr>';
							// dataHtml += '<button class="viewbutton" style="margin-left:5px;padding:0 3px;" onclick=\"open(\''+item.PROJECTNAME+'\');\">open</button></td></tr>';
						});

						dataHtml += '</table>';

						container.prev().html(dataHtml);
						console.log('');
					}
				};

					//$.pagination(container, options);

					container.addHook('beforeInit', function(){
						window.console && console.log('beforeInit...');
					});
					container.pagination(options);

					container.addHook('beforePageOnClick', function(){
						window.console && console.log('beforePageOnClick...');
						//return false
					});
            },
			error:function(data) {					
				console.log(data);
			}
        }); 
	});
});	  

</script>
</head>
<style>
.inputinfo{
	font-family: 'Lato', Calibri, Arial, sans-serif;
    font-size: 13px;
    font-weight: 400;
    width: 200px;
    padding: 5px;
    margin-bottom: 5px;
    border: 3px solid #ebe6e2;
    border-radius: 5px;
    -webkit-transition: all 0.3s ease-out;
    -moz-transition: all 0.3s ease-out;
    -ms-transition: all 0.3s ease-out;
    -o-transition: all 0.3s ease-out;
    transition: all 0.3s ease-out;
}
input[type="button" i]:disabled, input[type="submit" i]:disabled, input[type="reset" i]:disabled, input[type="file" i]:disabled::-webkit-file-upload-button, button:disabled, select:disabled, keygen:disabled, optgroup:disabled, option:disabled, select[disabled] > 

        ul, li{
            list-style: none;
			
        }
        .data-container{
            margin-top: 0px;
        }
        .data-container ul{
            padding: 0;
            margin: 0;
        }
        .data-container li{
            margin-bottom: 1px;
			margin-right:10px;
            background: #6c6e74;
            color: #fff;
			font-size:16px;
			padding-left:10px;
			line-height:24px;
        }
</style>
<body>						
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
String username = request.getParameter("username");//用request得到 
String post = request.getParameter("post");//用request得到
%>	
	<div style="margin:10px; auto; text-align:left;" >
	<span style="font-size:18px;font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, sans-serif;color:#333;margin-left:10px;" id="project_name" >Project Management [no project]
	</span>
	</div>
	<div class="toolbar"> 
	<input type="submit" class="button" style="background-image:url(images/create.jpg);padding-left:22px;background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;" id="create"  value="Create" >
	<input type="submit" class="button" style="background-image:url(images/edit.jpg);padding-left:22px;background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:60px;" id="edit"  value="Edit" disabled="disabled" >
	<input type="submit" class="button" style="background-image:url(images/delete.jpg);padding-left:22px;background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:70px;" id="delete"  value="delete" disabled="disabled">
	<input type="submit" class="button" style="background-image:url(images/copy.jpg);padding-left:22px;background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:60px;" id="copy"  value="Copy" disabled="disabled">
	<input type="submit" class="button" style="background-image:url(images/open.jpg);padding-left:22px;background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:60px;" id="open"  value="Open">
	<span style="color:#ffffff;float:right;font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, sans-serif;line-height:38px;margin-right:10px;" id="project_name"></span>
	<input type="hidden" id="projectid" value="">
	<input type="hidden" id="projectname" value="">
	<input type="hidden" id="projecdescription" value="">
	<input type="hidden" id="doid" value="">
	<input type="hidden" id="doname" value="">
	<input type="hidden" id="dodescription" value="">
	</div>
	<div class="content" style="height:290px;">
	<div id="div1" style="display:none;margin-left:120px;margin-top:40px;font:bold 12px/32px Arial, sans-serif;color:#000;">
	<table>
	<tr><td align="right"><span >Name</span></td><td><input type="text" name="name" id="name" class="inputinfo" value=""/></td></tr>
	<tr><td align="right"><span >Description</span></td><td><textarea rows="4" cols="20" name="description" id="description" class="inputinfo" style="margin-top:20px;"></textarea></td></tr>
	<tr><td><input type="hidden" id="username" value="<%=username%>"></td></tr>
	<tr><td><input type="hidden" id="post" value="<%=post%>"></td></tr>
	<tr><td colSpan="2" align="right"><input type="submit" class="button"  style="padding:0px 20px; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;" id="save"  value="save" ></td></tr>
	</table>
	</div>
	<div id="div2" style="margin-left:10px;margin-top:5px; display:none;">
	<table class="searchtable" style="max-height:100px;">
	<tr>
	<td >Name</td>
	<td><input type="text" name="name" id="txtSearchName" /></td>
	<td align="right">Created Date</td>
	<td><input type="checkbox" onclick="check(this);"/>Any Date</td>
	</tr>
	<tr>
	<td>Created By UserName</td>
	<td><input type="text" name="userid" id="txtSearchUserid" value=""/></td>
	<td align="right">From</td>
	<td><input type="date" id="txtSearchFromDate" /></td>
	</tr>
	<tr>
	<td>Created By Post</td>
	<td><input type="text" name="userpost" id="txtSearchUserpost" value=""/></td>
	<td align="right">To</td>
	<td><input type="date" id="txtSearchToDate"  /></td>
	</tr>
	<tr>
	<td><!--Description--></td>
	<td><input type="text" name="description" id="txtSearchDescription" value="" style="display:none;"/></td>
	<td colSpan="2"><a href="#" class="button save" id="Search" style="width:100px;display:inline-block;margin:0px;float:right;padding-left:30px;height:18px;line-height:18px;margin-right:16px;">Search</a></td>
	</tr>
	</table>
	
	<div class="data-container" style="max-height:140px;"></div>
	<div id="pagination-demo1" style="margin-top:2px;"></div>
	</div>
	<div id="div3" style="margin-left:10px;margin-top:5px; display:none;">
	<span style="color:#000">从view来的值：</span><input type="text" name="viewname" id="viewname" class="inputinfo" value=""/>
	<input type="submit" class="button"  style="position:absolute;width:50px;top:340px;right:150px;" id="edit"  value="edit">
	<input type="submit" class="button"  style="position:absolute;width:50px;top:340px;right:90px;" id="save"  value="save">
	<input type="submit" class="button"  style="position:absolute;width:50px;top:340px;right:30px;" id="undo"  value="undo">
	</div>
	</div>
  
	<div style="margin:10px 20px;font-size:18px;font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, sans-serif;color:#333;"><span >Design option</span></div>
	<div class="toolbar" style="margin-top:10px;"> 
	<input type="submit" class="button" style="background-image:url(images/create.jpg);padding-left:22px; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;" id="create2"  value="Create" disabled="disabled">
	<input type="submit" class="button" style="background-image:url(images/edit.jpg);padding-left:22px; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:60px;" id="edit2"  value="Edit" disabled="disabled">
	<input type="submit" class="button" style="background-image:url(images/delete.jpg);padding-left:22px; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:70px;" id="delete2"  value="Delete" disabled="disabled">
	<input type="submit" class="button" style="background-image:url(images/copy.jpg);padding-left:22px; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:60px;" id="copy2"  value="Copy" disabled="disabled">
	<input type="submit" class="button" style="background-image:url(images/open.jpg);padding-left:22px;background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;width:60px;" id="open2"  value="Open" disabled="disabled">
	
	<span style="color:#ffffff;float:right;font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, sans-serif;line-height:38px;margin-right:10px;" id="do_name"></span>
	</div>
	<div class="content">
	<!-- <div style="width:100px;height:265px;overflow-y:scroll; overflow-x:hidden;float:left;display:none;margin-left:10px;" id="table2" >
	
	</div> -->
	<div id="div23">
		<div class="data-container" style="max-height:140px;"></div>
		<div id="pagination-demo2" style="margin-top:2px;"></div>
	</div>
	<div id="div22" style="display:none;margin-left:5px;margin-top:30px; font:bold 12px/32px Arial, sans-serif;color:#000; text-align:center;">
	<table>
		<tr>
		<td align="right"><span >Name</span></td><td><input type="text" name="name2" id="name2" class="inputinfo" value="" style="width: 160px"/></td>
		<td align="right"><span >Site Area (sq.m)</span></td><td><input type="text" name="sitearea" id="sitearea" class="inputinfo" value="" style="width: 160px"/></td>
		</tr>
		<tr><td align="right"><span >Description</span></td><td colSpan="3"><textarea rows="4" cols="20" name="description2" id="description2" class="inputinfo" style="width:484px;"></textarea></td></tr>
		<tr>
		<td align="right"><span >Plot Ratio</span></td><td><input type="text" name="plot" id="plot" class="inputinfo" value="" style="width: 160px"/></td>
		<td align="right"><span >GFA (sq.m)</span></td><td><input type="text" name="gfa" id="gfa" class="inputinfo" value="" style="width: 160px"/></td>
		</tr>
		<tr>
		<td align="right"><span >Height Restriction</span></td><td><input type="text" name="bldg" id="bldg" class="inputinfo" value="" style="width: 160px"/></td>
		<td align="right"><span >Site Coverage(%)</span></td><td><input type="text" name="sitecoverage" id="sitecoverage" class="inputinfo" value="" style="width: 160px"/></td>
		</tr>
		<tr><td colSpan="4" align="middle"><input type="submit" class="button"  style="padding:0px 20px; background-repeat:no-repeat; background-size:100% 100%;-moz-background-size:100% 100%;" id="save2"  value="save" ></td></tr>
	</table>
	</div>
	
	</div>

	<script src="css/dist/pagination.js"></script>
	<script>

	var host = document.location.host;
		var protocol = document.location.protocol;
		var handler;
		var threeDGIS;		// This should be the core part of all the system views
		var map;
		var dopLayer;
		
		if(host == "")
		{
			host = protocol+"//localhost";
		}
		else
		{
			host = protocol+"//" + host;
		}
		
	    $(function(){

	    });
		
function view(id, rid){
	
	$('#project_name').html('Project Management ['+id+']');
	$('#create2').prop('disabled',false);
	
	parent.threeDGIS.project = new Project([]);
	parent.threeDGIS.project.name = id;
	parent.threeDGIS.project.id = rid;
	
	projectUIControl();
	$('#div23').css('display','none');
}		

function viewOption(id, rid){	
	parent.threeDGIS.project.options = [];
	$('#do_name').html(id);
	
	// First, delete all current project entities
	parent.threeDGIS.threeDView.removeProject();
	
	// Get all the 3D data by the optionid
	$.ajax({
		url: host+'/springmvc/GetOption',
		data: {
			json: '{"OptionID":'+rid+'}'
		},
		dataType: "json",
		type: 'GET',		// Need more advanced jquery version, later than 1.9.0
		success: function (data) {                                  
			if(data.site==undefined) {
				var option = new Option({
					name: id,
					id: rid
				});
				parent.threeDGIS.project.options[0] = option;
				
				parent.$('#btnDefineSite').click();
				parent.threeDGIS.flatRegion = undefined;
			}
			else {
				var option = new Option({
					name: data.OptionName,
					id: rid
				});
				parent.threeDGIS.project.options[0] = option;
				option.siteHeight = data.siteHeight;
				option.name = data.OptionName;
				
				var siteCoordinates = data.site.coordinates[0];
				for(var i=0; i<siteCoordinates.length; i++) {
					option.siteFlatRegion.push(siteCoordinates[i][0]);
					option.siteFlatRegion.push(siteCoordinates[i][1]);
					option.siteFlatRegion.push(option.siteHeight);
				}
				
				var dataBlocks = data.blockTypes;
				var apartCount = 0;
				var houseCount = 0;
				var nonDomesticCount = 0;
				
				var apartGFA = {};
				var houseGFA = {};
				var nonDomesticGFA = {};
				
				var apartHeight=0, houseHeight=0, nonDomesticHeight=0;
				
				for(var i=0; i<dataBlocks.length; i++) {
					option.blocks.push(dataBlocks[i]);
					if(dataBlocks[i].towerType=="Apartment") {
						if (apartGFA.flatSize==undefined) {
							apartGFA.flatSize = dataBlocks[i].AVG_FLAT_SIZE;
							apartGFA.domHeight = dataBlocks[i].DOM_FLOOR_HEIGHT;
							apartGFA.flatNo = dataBlocks[i].FLAT_PER_FLOOR;
							apartGFA.lobbyHeight = dataBlocks[i].LOBBY_FLOOR_HEIGHT;
							apartGFA.domFloorNo = dataBlocks[i].NO_OF_DOMFLOOR;
							apartGFA.lobbyFloorNo = dataBlocks[i].NO_OF_LOBBYFLOOR;
							apartGFA.refugeHeight = dataBlocks[i].REFUGE_FLOOR_HEIGHT;
						}
						apartCount++;
					}
					else if(dataBlocks[i].towerType=="House") {
						if (houseGFA.flatSize==undefined) {
							houseGFA.flatSize = dataBlocks[i].AVG_FLAT_SIZE;
							houseGFA.domHeight = dataBlocks[i].DOM_FLOOR_HEIGHT;
							houseGFA.flatNo = dataBlocks[i].FLAT_PER_FLOOR;
							houseGFA.lobbyHeight = dataBlocks[i].LOBBY_FLOOR_HEIGHT;
							houseGFA.domFloorNo = dataBlocks[i].NO_OF_DOMFLOOR;
							houseGFA.lobbyFloorNo = dataBlocks[i].NO_OF_LOBBYFLOOR;
							houseGFA.refugeHeight = dataBlocks[i].REFUGE_FLOOR_HEIGHT;
						}
						
						houseCount++;
					}
					else {
						;// Non-domestic not yet supported
					}
				}
				apartGFA.towerNo = apartCount;
				houseGFA.towerNo = houseCount;
				option.setGFAParameter(apartGFA, true, true);
				option.setGFAParameter(houseGFA, true, false);
				
				var apartHeight = option.getTowerHeight(true, true);
				var houseHeight = option.getTowerHeight(true, false);
				// option.
				
				for(var i=0; i<option.blocks.length; i++) {
					if(option.blocks[i].towerType=="Apartment") {
						option.blocks[i].height = apartHeight;
					}
					else if(option.blocks[i].towerType=="House") {
						option.blocks[i].height = houseHeight;
					}
					
					var hkptCenter = option.blocks[i].geom.coordinates[0];
					
					var squareVertices = [];
					
					for(var j=0; j<hkptCenter.length; j++) {
						squareVertices.push(CoordTransform.hk2cartesian(hkptCenter[j][0], hkptCenter[j][1], option.siteHeight));
					}
					
					var polygon = new Cesium.PolygonGraphics({
						hierarchy: new Cesium.PolygonHierarchy(squareVertices),
						extrudedHeight: option.siteHeight+option.blocks[i].height,
						height: option.siteHeight,
						shadows: Cesium.ShadowMode.ENABLED,
						material: Cesium.Color.BURLYWOOD
					});
					
					parent.threeDGIS.threeDView.viewer.entities.add({
						id: 'ProjectBlock_'+option.blocks[i].towerType+'_'+i,
						polygon: polygon,
						outline: true,
						shadows: Cesium.ShadowMode.ENABLED		// Does not seem to be working
					});
				}
				
				var flatRegion = {
					position: option.siteFlatRegion,
					name: 'flat'+Date.now()
				};
				
				var layers = parent.threeDGIS.threeDView.viewer.scene.layers._layers._array;
				for(var i=0; i<layers.length; i++) {
					layers[i].addFlattenRegion(flatRegion);
					parent.threeDGIS.flatRegion = flatRegion;
				}
				
				var polygonVertices = [];
				for(var i=0; i<option.siteFlatRegion.length; i=i+3) {
					var lng = option.siteFlatRegion[i];
					var lat = option.siteFlatRegion[i+1];
					var h = option.siteFlatRegion[i+2];
					
					polygonVertices.push(Cesium.Cartesian3.fromDegrees(lng, lat, h));
				}
				
				var polygon = new Cesium.PolygonGraphics({
					hierarchy: new Cesium.PolygonHierarchy(polygonVertices),
					material: new Cesium.Color(0.5, 0.5, 0.5, 0.9),
					outline: true,
					outlineColor : Cesium.Color.RED,
					closeTop: false,
					closeBottom: false,
					height: option.siteHeight,
					extrudedHeight: option.siteHeight+5
				});
				
				var newEntity = parent.threeDGIS.threeDView.viewer.entities.add({
					id: 'Project_Site',
					polygon: polygon,
					outline: true
					// shadows: Cesium.ShadowMode.ENABLED
				});
				// newEntity.clampToS3M = true;
				parent.threeDGIS.threeDView.viewer.flyTo(newEntity);
			}
			
			projectUIControl();
		},
		error: function(err) {
			alert("AJAX function failed");
			console.log(err);
		}
	});
}	

	function check(obj)
    {
        var ids=document.getElementsByName("selected_id[]");
        if(obj.checked)
        {
            for(var i=0;i<ids.length;i++)
            {
                ids[i].checked=true;
            }
        }
    }

	
	function check_bx(obj)
    {
        var ids=document.getElementsByName("selected_id[]");
        if(obj.checked)
        {
            for(var i=0;i<ids.length;i++)
            {
                ids[i].checked=false;
            }
        }
    }
	</script>
	<script src="3dgis/js/class/viewerComponents/3DGIS.js"></script>
	<script src="3dgis/js/class/PMO/Project.js"></script>
	<script src="3dgis/js/class/PMO/Option.js"></script>
	<script src="3dgis/lib/proj4js/proj4.js"></script>
	<script src="3dgis/js/class/CoordTransform.js"></script>
	<script type="text/javascript" src="../iClient/for3D/webgl/examples/js/require.min.js" data-main="js/main"></script>
</body>
</html>
