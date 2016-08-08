<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Feeds</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<!-- Latest compiled and minified CSS -->
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
	href="<c:url value="/resources/css/feedlinks.css" />" />
<link href='https://fonts.googleapis.com/css?family=Ubuntu'
	rel='stylesheet' type='text/css'>

<script>
	$(function() {
		$("#button-search")
				.click(
						function() {
							$("#message").html("");
							var searchBtn = $("#search-input").val();
							$
									.ajax({
										url : "newFeedUrl",
										type : "GET",
										data : "url=" + searchBtn,
										dataType : 'text',
										success : function(response) {
											if (response == "") {
												$("#message")
														.html(
																"<h4 style='color:red'>Required FeedUrl not found</h4>");
											} else {
												window.location.href = "feeds?feedurl="
														+ response;
											}

										},

									});
						});
	})
</script>
</head>

<body>

	<div class="feedLinkDiv">
		<h3>MyFeeds</h3>
		<div class="logoutDiv">
			<h4>${username}</h4>
			<c:url value="/logout" var="logoutUrl" />
			<form id="logout" action="${logoutUrl}" method="post">
				<input class="btn btn-warning" type="submit" value="Logout" /> <input
					type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
		<div class="sidebar">

			<div class="seachBox">
				<form id="search-form">
					<input id="search-input" name="url" type="text"
						placeholder="Type Feed Url Or Website Url ">
					<p id="message"></p>
					<input type="button" class="btn btn-primary" id="button-search"
						value="Add Feed" />
				</form>


			</div>
		</div>
		<div class="mainDiv">
			<h3
				style="font-family: Ubuntu; font-weight: bold; position: relative; top: 10px; left: 20px;">List
				of Subscribed Feeds</h3>
			<br>
			<c:forEach var="userFeedBean" items="${userFeedBeanList}">
				<a href="feeds?feedurl=${userFeedBean.getFeedlink()}">${userFeedBean.getFeedname()}</a>
				<hr>
			</c:forEach>
			<br>
			<br>



		</div>

	</div>
</body>
</html>