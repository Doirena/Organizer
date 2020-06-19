<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
		crossorigin="anonymous">
	<link rel="stylesheet"	href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	<link rel="stylesheet" href="/resources/demos/style.css" />
	<%@ page isELIgnored="false"%>
	<title>Edit/New Task</title>
	<style>
		.containers{
	        display: inline-block;
	        width: 100%;
	        padding: 20px;
	     }
		.btn-primary{
			margin-bottom:	0px;
		}
		.form-control{
			width: 50%;
			margin-top:5px;
			margin-bottom:5px;
		}
		.datepicker{
			width: 15%;
		}
		.selec{
			display: inline-block;
			width: 80px;
		}
		.tim{
			display: inline-block;
	        width: 100%;
	        margin-top: 0px;
		}
		.form-group p{
			display: inline-block;
			width: 100%;
			margin:0;
			font-weight: bold;
			float: left;
		}
		 .error{
        outline: 1px solid red;
    }    
		
	</style>
</head>
<body>
<div class="containers">

	<form id="target" class="form-group" action="save" method="post" >
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" type="text" name="tid" value="${task.id}" />
		<input type="hidden" type="text" name="id" value="${user.id}" />
		<p>Date</p>
		<input type="text" class="datepicker form-control" name="date" id="dateEmpty" autocomplete="off"
						value=<fmt:formatDate value="${(newDate == null)?task.start_date:newDate}" pattern="yyyy-MM-dd"/>></input>
		<div class = tim>
			<p>Start time</p>
			<select type="text" class="form-control selec" id="Shour" name="shour">  </select> : <select type="text" class="form-control selec" id="Smin" name="smin">  </select>
		</div>
		<div class = tim>
			<p>Finish time</p>
			<select type="text" class="form-control selec" id="Fhour" name="fhour"></select> : <select type="text" class="form-control selec" id="Fmin" name="fmin"></select>
		</div>
		<p>Name</p>
		<input type="text" name="name" id="name" class="form-control"  value="${(task.name!=null)? task.name : ''}" />
		<p>Description</p>
		<textarea class="form-control" name="description" rows="4" cols="50" maxlength="10000">${(task.description != null)?task.description:''}</textarea>
		
				<!-- <br /> <input class="btn btn-primary" type="submit" value="Save"> -->
				<button type="button" id="but" class="btn btn-primary">Save</button>
				<a class="btn btn-dark" href="${contextPath}/organizer/tasks?filter=${dateYour}">Back</a>
	</form>

<h6 style="color:#DC143C">${msg}</h6>

<p id="rez"></p>
</div>


	<script>
	
	//function if calendar
		$(function() {

			$(".datepicker").datepicker({
				dateFormat : "yy-mm-dd",
				onSelect: function() {
				 //value = $( this ).val();
				 $(this).removeClass("error");
				 var value='<h6>Reserved time for '+ $( this ).val()+'</h6>'+'<hr>';
				 $('#rez').text('');
				 <c:forEach items="${tasksByID}" var="tasks">
				 if($( this ).val() == '<fmt:formatDate value="${tasks.start_date}" pattern="yyyy-MM-dd"/>' )
				 value+='<fmt:formatDate value="${tasks.start_date}" pattern="HH:mm"/>'+' - '
				 +'<fmt:formatDate value="${tasks.finish_date}" pattern="HH:mm"/>'+' '
				 +`${tasks.name}`+' '
				 +`${tasks.description}`+'<hr>'

				 </c:forEach>
				 $('#rez').append(value);
			    }
				
			});

		});
	

//console.log('<fmt:formatDate value="${tasksDate}" pattern="yyyy-MM-dd"/>')
//console.log('<fmt:formatDate value="${newDate}" pattern="yyyy-MM-dd"/>')
//console.log($(".datepicker").val());
//$('#rez').append($(".datepicker").val());
var value_startPage='<h6>Reserved time for '+ '${dateYour}'+'</h6>'+'<hr>';
<c:forEach items="${tasksByID}" var="tasks">
	if('${dateYour}' == '<fmt:formatDate value="${tasks.start_date}" pattern="yyyy-MM-dd"/>' ){
	value_startPage+='<fmt:formatDate value="${tasks.start_date}" pattern="HH:mm"/>'+' - '
	+'<fmt:formatDate value="${tasks.finish_date}" pattern="HH:mm"/>'+' <b>|</b> '
	+`${tasks.name}`+' '
	+`${tasks.description}`+'<hr>'
	}
</c:forEach>
$('#rez').append(value_startPage);



//list of hours and check what is selected
		var hours = ["07", "08", "09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"];
		
		var option_sh = '';
		var option_fh = '';
		var sh = '<fmt:formatDate value="${task.start_date}" pattern="HH"/>';
		
		var fh = '<fmt:formatDate value="${task.finish_date}" pattern="HH"/>';
		for (var i = 0; i < hours.length; i++) {
			if (hours[i] == sh) {
				option_sh += '<option value="'+ hours[i] + '" selected="selected">'
						+ hours[i] + '</option>'
			} else {
				option_sh += '<option value="'+ hours[i] + '">' + hours[i]
						+ '</option>';
			}
			
			if (hours[i] == fh) {
				option_fh += '<option value="'+ hours[i] + '" selected="selected">'
						+ hours[i] + '</option>'
			} else {
				option_fh += '<option value="'+ hours[i] + '">' + hours[i]
						+ '</option>';
			}
			
		}
		$('#Shour').append(option_sh);
		$('#Fhour').append(option_fh);
// list of minutes and check what is selected	
		var minutes = [];
		for (var y = 0; y < 60; y=y+5) {
			var j = y.toString();
			if(y<10){
				j="0"+j;
			}
			minutes.push(j);
		}
		
		var option_sm = '';
		var option_fm = '';
		var sm= '<fmt:formatDate value="${task.start_date}" pattern="mm"/>';
		var fm = '<fmt:formatDate value="${task.finish_date}" pattern="mm"/>';
		for (var ii = 0; ii < minutes.length; ii++) {
			if (minutes[ii] == sm) {
				option_sm += '<option value="'+ minutes[ii] + '" selected="selected">'
						+ minutes[ii] + '</option>'
			} else {
				option_sm += '<option value="'+ minutes[ii] + '">' + minutes[ii]
						+ '</option>';
			}
			
			if (minutes[ii] == fm) {
				option_fm += '<option value="'+ minutes[ii] + '" selected="selected">'
						+ minutes[ii] + '</option>'
			} else {
				option_fm += '<option value="'+ minutes[ii] + '">' + minutes[ii]
						+ '</option>';
			}
			
		}
		$('#Smin').append(option_sm);
		$('#Fmin').append(option_fm);
		

//check is empty field
$( "#but" ).click(function() {
	if(!$('#name').val() && !$('#dateEmpty').val()){
        $('#name').addClass("error");
        $('#dateEmpty').addClass("error");
        
    } else if( !$('#name').val()){
    	 $$('#name').addClass("error");
    	 
    } else if( !$('#dateEmpty').val()){
    	 $('#dateEmpty').addClass("error");
    } 
	else{
        $('#name').removeClass("error");
        $('#dateEmpty').removeClass("error");
       	$( "#target" ).submit()
   	 	}
	});
	
	//remove error class	
	$(document).ready(function(){
    $('#name').blur(function(){
        if(!$(this).val()){
           
        } else{
            $(this).removeClass("error");
        }
    });
});
	
	
		

	
	</script>
</body>

</html>