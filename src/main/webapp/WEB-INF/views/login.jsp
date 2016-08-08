<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
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
	href="<c:url value="/resources/css/login.css" />" />
<title>Login Page</title>

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


	<div id="login-box">

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>
		<div id="logo"></div>
		<br> <a href="register"><button
				class="btn btn-md btn-warning">Register Here</button></a><br> <br>
				
		<br>
		<form class="form-horizontal" id="loginform"
			action="<c:url value='j_spring_security_check' />" method='POST'>
			<div class="form-group">
				<label for="inputEmail" class="col-sm-3 control-label">Email</label>
				<div class="col-sm-9">
					<input class="form-control" name="username" id="inputEmail"
						placeholder="Email" type="text">
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-3 control-label">Password</label>
				<div class="col-sm-9">
					<input class="form-control" name="password" id="inputPassword"
						placeholder="Password" type="password">
				</div>
			</div>
			<div class="form-group">
			<h4>${loginStatus}</h4>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-9">
					<div class="checkbox">
						<label class=""> <input class=""
							name="_spring_security_remember_me" type="checkbox">Remember
							me
						</label>
					</div>
				</div>
			</div>
			<div class="form-group last">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="submit" class="btn btn-success btn-md">Sign
						in</button>
					<button type="reset" class="btn btn-default btn-md">Reset</button>
				</div>
			</div>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>

	</div>

</body>
</html>