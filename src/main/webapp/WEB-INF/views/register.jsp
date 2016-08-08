<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="_csrf" content="${_csrf.token}" />
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
<script
	src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js">
	
</script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
	integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7"
	crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css"
	integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r"
	crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"
	integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS"
	crossorigin="anonymous"></script>
<link type="text/css" rel="stylesheet"
	href="<c:url value="/resources/css/register.css" />" />
<link href='https://fonts.googleapis.com/css?family=Ubuntu'
	rel='stylesheet' type='text/css'>
<title>Register</title>

<script>
	$(function() {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});
		$('form')
				.validate(
						{
							rules : {
								first_name : {
									minlength : 3,
									maxlength : 20,
									required : true
								},
								last_name : {
									minlength : 3,
									maxlength : 20,
									required : true
								},
								email : {
									required : true,
								},
								password : {
									minlength : 5,
									required : true,
								},
								confirm : {
									minlength : 5,
									equalTo : "#password"
								},
							},
							submitHandler : function(form) {
								$.ajax({
											url : "newuser",
											type : "POST",
											data : $(form).serializeArray(),
											success : function(data,
													textStatus, jqXHR) {
												$("#registerform")[0].reset();
												$("#registerform")
														.append(
																"<h3 style='color:green'>Registration Successful</h3>");
											},
											error : function(jqXHR, textStatus,
													errorThrown) {
												alert(errorThrown);
											}
										});
							},
							highlight : function(element) {
								$(element).closest('.form-group').addClass(
										'has-error');
							},
							unhighlight : function(element) {
								$(element).closest('.form-group').removeClass(
										'has-error');
							},
							errorElement : 'span',
							errorClass : 'help-block',
							errorPlacement : function(error, element) {
								if (element.parent('.input-group').length) {
									error.insertAfter(element.parent());
								} else {
									error.insertAfter(element);
								}
							}
						});
		"src/main"
		$("#email").focusout(function() {
			var email = $("#email").val();
			$.ajax({
				url : "userExists",
				type : "GET",
				data : "email=" + email,
				success : function(data) {
					if (data == "success") {
						$("#emailmsg").text("Email already exists");
						$("#emailmsg").css("color", "#AA4550");
						$("#submit").attr("disabled", "true");
					} else {
						$("#emailmsg").text("");
						$("#submit").removeAttr("disabled");
					}
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="container-fluid">
		<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="navbar-header">
			<a href="feedlinks"><img
				src="<c:url value="/resources/images/logo.png" />"
				class="navbar-brand" /></a>
		</div>
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="feedlinks"><span class=""></span> MyFeeds</a></li>
				</ul>
			</div>
		</div>
		</nav>
	</div>
	<br><br>
	<div class="container-fluid">
		<div class="formDiv">
			<form id="registerform">
				<div class="row">
					<div class="form-group col-md-9">
						<label for="first_name">First Name</label> <input
							class="form-control" id="first_name" name="first_name"
							placeholder="First Name" type="text">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-9">
						<label for="last_name">Last Name</label> <input
							class="form-control" id="last_name" name="last_name"
							placeholder="Last Name" type="text">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-9">
						<label for="email">E-mail</label> <input class="form-control"
							id="email" name="email" placeholder="E-mail" type="email">
						<p id="emailmsg"></p>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-9">
						<label for="password">Password</label> <input class="form-control"
							id="password" name="password" placeholder="Password"
							type="password">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-9">
						<label for="confirm">Confirm</label> <input class="form-control"
							id="confirm" name="confirm" placeholder="Confirm Password"
							type="password">
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-2">
						<br /> <input class="btn btn-warning btn-md" id="submit"
							type="submit" value="Sign Up">
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>