<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Create an account</title>
    
    <style>

      .containers{
        display: inline-block;
        width: 100%;
        padding:20px;
      }
      .form-group {
	      display: inline-block;
	      width: 40%;
	      margin-left: calc((100% - 40%) / 2);
      }
      .form-signin-heading{
        display: inline-block;
        width: 100%;
        text-align: center;  
        padding-bottom:10px;
      }
      .form-control{
      	display: inline-block;
        width: 55%;
        margin-left: calc((100% - 55%) / 2);
        margin-bottom: 10px;
      }
      .btn-block{
	    display: inline-block;
	  	width: 22%;
        margin-left: calc((100% - 22%) / 2);
	    margin-bottom: 10px;
      } 
      span{
  		display: inline-block;
        width: 100%;
   		text-align: center; 
   		color:red;
   		}
   		
   		.text-center  a{
   		text-decoration: none;
   		}

  
      
      
</style>
</head>

<body>

<div class="containers">

    <form:form method="POST" modelAttribute="userForm" class="form-signin">
        <h2 class="form-signin-heading">Create your account</h2>
        
          <spring:bind path="firstName">
            <div class="form-group ">
                <form:input type="text" path="firstName" class="form-control"
                            placeholder="Name"></form:input>
            </div>
        </spring:bind>
        
        
        <spring:bind path="username">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="text" path="username" class="form-control" placeholder="Email"
                            autofocus="true"></form:input><br>
                <form:errors path="username"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="password">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="password" class="form-control" placeholder="Password"></form:input><br>
                <form:errors path="password"></form:errors>
            </div>
        </spring:bind>

        <spring:bind path="passwordConfirm">
            <div class="form-group ${status.error ? 'has-error' : ''}">
                <form:input type="password" path="passwordConfirm" class="form-control"
                            placeholder="Confirm your password"></form:input><br>
                <form:errors path="passwordConfirm"></form:errors>
            </div>
        </spring:bind>
        
       

        <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
    </form:form>
     <h4 class="text-center"><a href="${contextPath}/login"> <i class="fa fa-angle-left"></i> Back</a></h4>
</div>
</body>
</html>
