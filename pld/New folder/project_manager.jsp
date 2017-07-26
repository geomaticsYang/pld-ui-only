<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>1</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style2.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script>
$(document).ready(function(){
  $("#openlist").click(function(){
	  toggle('table1');
   $('#edit').attr("disabled",false); 
  });
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
  $("#edit").click(function(){
	  alert("111");
	 var name=document.forms[0].user_name;  
	var msg=document.getElementById("msg");  
	if(name.value.length==0){  
            //提示用户  
            //alert("姓名为必填项");  
            name_msg.innerHTML="<font color='red'>*姓名为必填项</font>";  
            //聚焦（鼠标定位）  
                        name.focus();  
            return ;//中断方法的运行  
        }  
	 $.ajax({  
                    type:"GET",  
                    url: "/luck.jsp",  
                    dataType:"json",  
                    success:function(data){  
                        index = data.value;  
                    }  
                });  
  });
});

$(document).ready(function(){
  $("#Delete").click(function(){
	 $.ajax({  
                    type:"GET",  
                    url: "test.jsp",  
                    dataType:"json",
                    success:function(data){		
                    createShowingTable(data); 
                    }  ,
					error:function(data) {
						 
						 alert("error");
						   },
                }); 
  });
});


function createShowingTable(data) {  
    var tableStr = "<table class='tab-list' width='99%'>";  
    tableStr = tableStr  
            + "<tr class='list-header'>"  
            +"<td width='30%'>id</td>"  
            +"<td width='20%'>name</td>"  
            +"</tr>";  
    var len = data.length;

    for ( var i = 0; i < len; i++) {  
        tableStr = tableStr + "<tr>"  
                +"<td>"+ data.id + "</td>"  
                + "<td>"+ data.name + "</td>"   
                +"</tr>";  
    }  
    if(len==0){  
        tableStr = tableStr + "<tr style='text-align: center'>"  
        +"<td colspan='6'><font color='#cd0a0a'>"+ 暂无记录 + "</font></td>"  
        +"</tr>";  
    }  
    tableStr = tableStr + "</table>"; 
	alert(tableStr);
    //添加到div中  
    $("#table1").html(tableStr);  
} 

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
input[type="button" i]:disabled, input[type="submit" i]:disabled, input[type="reset" i]:disabled, input[type="file" i]:disabled::-webkit-file-upload-button, button:disabled, select:disabled, keygen:disabled, optgroup:disabled, option:disabled, select[disabled] > option {
    color: #ffffff;;
}
</style>
<body>						
<% 
String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
String username = request.getParameter("username");//用request得到 
String post = request.getParameter("post");//用request得到
%>	

	<div class="toolbar"> 
	<input type="submit" class="button white medium" onclick="toggle('div1')" value="Create">
	<input type="submit" class="button white medium" disabled="disabled" id="edit" value="Edit">  
	<input type="submit" class="button white medium" id="Delete" onclick="" value="Delete"> 
	<input type="submit" class="button white medium" onclick="" value="Search">
	<input type="submit" class="button white medium" id="openlist" onclick="" value="Open">
	</div>
	<div class="content">
	<div style="width:100px;height:265px;overflow-y:scroll; overflow-x:hidden;float:left;display:none;margin-left:10px;" id="table1" >
	
	</div>
	<div id="div1" style="display:none;margin-left:120px;margin-top:40px;">
	<table >
	<tr><td align="right"><span >Name</span></td><td><input type="text" name="name" id="name" class="inputinfo" value=""/></td></tr>
	<tr><td align="right"><span >Description</span></td><td><input type="text" name="description" id="description" class="inputinfo" value=""/></td></tr>
	<tr><td><span >username</span></td><td><%=username%></td></tr>
	<tr><td><span >post</span></td><td><%=post%></td></tr>
	<tr><td colSpan="2" align="right"><input type="submit" class="button white medium" onclick="" value="提交"></td></tr>
	</table>
	</div>
	</div>
  
	<div style="margin:10px 20px;font-size:18px;font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, sans-serif;color:#333;"><span >Design option</span></div>
	<div class="toolbar" style="margin-top:10px;"> 
	<button class="button white medium">Create</button>
	<button class="button white medium">Edit</button>  
	<button class="button white medium">Delete</button>  
	<button class="button white medium">Search</button>
	<button class="button white medium">Open</button> 	
	</div>
	<div class="content">	
	</div>


</body>
</html>
