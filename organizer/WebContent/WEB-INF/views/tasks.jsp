<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!-- <c:set var="contextPath" value="${pageContext.request.contextPath}"/>-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet"	href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
	 <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	<link rel="stylesheet" href="/resources/demos/style.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <title>Your task</title>
	<style>
		.containers{
	        display: inline-block;
	        width: 100%;
	        padding:20px;
	      }
	       .form-control{
		    position: absolute;
		  	left: calc((100% - 130px) / 2);
    		top: 130px;
    		width: 130px;
		    background-color: transparent;
		  }
		  .form-control:focus{
		  	background-color: transparent;
		  }
		  .fa-calendar{
		  	display: inline-block;
		  	width: 100%;
		  	margin-left: 48px;
    		margin-top: 14px;
    		font-size: 17px;
		  }
		  #emptyTask{
		  	color:#A9A9A9;
		  }
		 a.logout{
		  	color:#007bff;
		  	margin-left:90%;
		  }
		  
		  a.logout:hover{
		  	color:#007bff;
		  }
		  	
		  .btn-block{
			  width:20%; 
			  margin-left:40%; 
			  margin-top: 30px;
			  margin-bottom: 30px;
		  } 
		  .table-bordered td, .table-bordered th, .table thead th {
		  	 border: 1px solid #ced4da;
		  }
		  #tableStyle tr:nth-child(even){
		  	 background-color: #dee2e6;
		  }
		  
		  #tableStyle tr:nth-child(odd){
		  	 background-color: #F5FFFA;
		  }

		  #tableStyle .btn{
		  	 margin-bottom: 13px;
		  }
		  
		  .rowStyle{
			 display: inline-block;
			 width: 100%;
			 font-weight: 400;
			 padding-top: 0.375rem;
	    	 padding-bottom: 0.375rem;
		  }     
	</style>    
    
</head>
<body>
<div class="containers">

    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="POST" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        
        <a class="logout" onclick="document.forms['logoutForm'].submit()">Logout</a>

    </c:if>
    
 
   


	<h2 align="center">Hello ${user.firstName}</h2>
	<h4 align="center">Your task for:</h4>
					<form method="get" align="center"  >
	            <input   type="text" value="${yourDate}" name="filter" class="datepicker form-control" autocomplete="off" />
	             <i class="fa fa-calendar"></i>
	</form>
	
	
	
	
	
	
	<a class="btn btn-lg btn-primary btn-block"  href="${contextPath}/task/edit?id=${user.id}&&dateYour=${yourDate}"> Create new Task</a>
	
	
	<div id="table"></div>
		<div align="center" id="emptyTask"></div>
	<div class="modal fade " id="modal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">Are You Sure?</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        There is no way to return this action
	      </div>
	      <div class="modal-footer">
	        <a id="modal-btn-yes" class="btn btn-danger" >Yes</a>
	        <button type="button" class="btn btn-primary" data-dismiss="modal">No</button>
	      </div>
	
	    </div>
	  </div>
	</div>
</div>

<script>
//function if calendar
var value=$( ".datepicker" ).val();
$(function() {

	$(".datepicker").datepicker({
		dateFormat : "yy-mm-dd",
		onSelect: function() {
			 if(value != $( this ).val()){
					  $( "form" ).submit();
					 // console.log("suveike")
			 	}
			 }
	});

});


//this is for delete function, to confirm Your delete
$(document).ready(function() {
    $('a[data-confirm]').click(function(ev) {
        var href = $(this).attr('href');
        $('#modal').find('.modal-title').text($(this).attr('data-confirm'));
        $('#modal-btn-yes').attr('href', href);
        $('#modal').modal({show:true});
        return false;
    });
});

	


//DATA from database
var nameTime = [];
var startTime = [];
var finishTime = [];
var finishM = [];
var description = [];
var duration = [];
var edit = [];
var delet = [];


	<c:forEach items="${tasks}" var="tasks">
		nameTime.push('<p class = "rowStyle"><fmt:formatDate value="${tasks.start_time}" pattern="HH:mm"/> - <fmt:formatDate value="${tasks.finish_time}" pattern="HH:mm"/> ${tasks.name}</p>');
		startTime.push('<fmt:formatDate value="${tasks.start_time}" pattern="HH"/>');
		finishTime.push('<fmt:formatDate value="${tasks.finish_time}" pattern="HH"/>');
		finishM.push('<fmt:formatDate value="${tasks.finish_time}" pattern="mm"/>');
		description.push('<p class = "rowStyle">'+`${tasks.description}`+'</p>');
		duration.push('<p class = "rowStyle"> ${tasks.duration} </p>');
		delet.push('<a  href="${contextPath}/task/delete?tid=${tasks.id}" class="btn btn-danger" role="button" data-confirm="Are you sure you want to delete?">Delete</a> <br>');
		edit.push('<a href="${contextPath}/task/edit?id=${user.id}&&tid=${tasks.id}&&dateYour=${yourDate}" class="btn btn-success">Edit</a><br>');
		
		</c:forEach>




//For calendar table:
	var tableData ='';
	var countTime = 0;
	tableData='<table class="table table-bordered" id="tableStyle">'+
  		'<thead>'+
	    '<tr>'+
	     ' <th>Time</th>'+
	     ' <th>Task</th>'+
	      '<th>Description</th>'+
	      '<th>Duration</th>'+
	      '<th colspan="2">Action</th>'+
	    '</tr>'+
		'</thead>'
		
for (var i = 7; i <= 23; i++) {
	var timeTable;
	if(i.toString().length === 1 ){
		timeTable = "0"+i;
	}else{
		timeTable = i.toString();
	}			
//Make all Tasks empty
	var nameTask='';
	var descTask='';
	var durTask='';
	var editTask='';
	var deletTask='';
	
	if(countTime !=0){
		nameTask = nameTaskF;
		descTask = descTaskF;
		durTask = durTaskF; 
		deletTask = deletTaskF;
		editTask = editTaskF;
		countTime--;
	}
	
	var count = 0;
	for (var j = 0; j < nameTime.length; j++) {
		if(timeTable === startTime[j]){
			count++;
			if (count>=2) {
				nameTask = nameTask + nameTime[j];
				descTask = descTask + description[j];
				durTask = durTask + duration[j];
				deletTask = deletTask + delet[j];
				editTask = editTask + edit[j]; 
			} else{
			nameTask = nameTask +nameTime[j];
			descTask = descTask + description[j];
			durTask = durTask + duration[j];
			deletTask = deletTask + delet[j];
			editTask = editTask + edit[j]; 
			}
			
			if(timeTable != finishTime[j]){
				countTime = parseInt(finishTime[j])-i;
				if(finishM[j] === "00" && countTime === 1 ){
					countTime = 0;
				}else if(finishM[j] !== "00" && countTime === 1 ){
					countTime = 1;
				}
				else if(finishM[j] !== "00" && countTime < 1 ){
					countTime +=1;
				}
				else if(finishM[j] === "00" && countTime > 1 ){
					countTime = countTime-1;
				}
				nameTaskF = nameTime[j];
				descTaskF = description[j];
				durTaskF =  duration[j];
				deletTaskF = delet[j];
				editTaskF = edit[j]; 
				
			}
		}	
	}
	
		      tableData+=
				    '<tr>'+
			      '<th>'+timeTable+':00</th>'+
			      '<td>'+nameTask+'</td>'+
			      '<td>'+descTask+'</td>'+
			      '<td>'+durTask+'</td>'+
			      '<td>'+deletTask+'</td>'+
			      '<td>'+editTask+'</td>'+
			    '</tr>'
	
}
// all tasks put to table
 $('#table').append(tableData);
  	//For empty task
if(nameTime.length===0){
	console.log("nieko nera")
	$('#emptyTask').append("<h3>This day You don't have any Task </h3>");
	$('#tableStyle').text("");
} 

</script>
	
</body>
</html>
