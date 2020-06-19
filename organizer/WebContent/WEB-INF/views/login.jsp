<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--<c:set var="contextPath" value="${pageContext.request.contextPath}"/>-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <title>Log in</title>
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
      .form-heading{
        display: inline-block;
        width: 100%;
        text-align: center;  
      }
      .form-control{
      	display: inline-block;
        width: 51%;
        margin-left: calc((100% - 51%) / 2);
        margin-bottom: 10px;
      }
      .btn-block{
	      display: inline-block;
	      width: 51%;
	      margin-left: calc((100% - 51%) / 2);
	      margin-bottom: 10px;
      }
  span{
   display: inline-block;
        width: 100%;
   text-align: center; 
  }
  .text-center  a{
   		text-decoration: none;
   		}
      
      
      
</style>
</head>

<body>

<div class="containers">

    <form method="POST" action="${contextPath}/login" class="form-signin">
        <h2 class="form-heading">Log in</h2>

        <div class="form-group ${error != null ? 'has-error' : ''}">
            <span>${message}</span>
            <input name="username" type="text" class="form-control" placeholder="Email"
                   autofocus/>
            <input name="password" type="password" class="form-control" placeholder="Password"/>
            <span>${error}</span>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <button class="btn btn-lg btn-primary btn-block" type="submit">Log In</button>
            <h4 class="text-center"><a href="${contextPath}/registration">Create new account</a></h4>
        </div>

    </form>

</div>
</body>
</html>
