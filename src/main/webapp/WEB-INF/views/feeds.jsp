<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>

<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
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
	href="<c:url value="/resources/css/feeds.css" />" />
<link href='https://fonts.googleapis.com/css?family=Ubuntu'
	rel='stylesheet' type='text/css'>

<script>
	$(function() {
		$("#tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix");
		$("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");

	});
</script>
<script>
	$(document).ready(function() {
		if ($("#button-subscribe").html() == "Unsubscribe") {
			$("#button-subscribe").addClass("btn-success");
			$("#button-subscribe").removeClass("btn-primary");
		} else {
			$("#button-subscribe").addClass("btn-primary");
			$("#button-subscribe").removeClass("btn-success");
		}
		$("#button-subscribe").click(function() {
			$.ajax({
				url : "subscribe",
				type : "GET",
				data : {
					"feed_title" : $("#feed_title").val(),
					"feed_url" : $("#feed_url").val()
				},
				dataType : 'text',
				success : function(response) {
					if (response == "Unsubscribe") {
						$("#button-subscribe").addClass("btn-success");
						$("#button-subscribe").removeClass("btn-primary");
						$("#button-subscribe").html("Unsubscribe");
					} else {
						$("#button-subscribe").addClass("btn-primary");
						$("#button-subscribe").removeClass("btn-success");
						$("#button-subscribe").html("Subscribe")
					}
				},

			});
		});
	})
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
						<li><a href="feedlinks"><span
								class="glyphicon glyphicon-home"></span> Home</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
	<input type="hidden" id="feed_title" value="${feedDetails.getTitle()}">
	<input type="hidden" id="feed_url" value="${feedurl}">

	<div class="detailDiv">
		<div class="logoutDiv">
			<h4>${username}</h4>
			<c:url value="/logout" var="logoutUrl" />
			<form id="logout" action="${logoutUrl}" method="post">
				<input class="btn btn-warning" type="submit" value="Logout" /> <input
					type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		</div>
		<h2>
			<a href="feedlinks">Feeds</a>
		</h2>
		<p>
			<b>${feedDetails.getTitle()}</b>
		</p>
		<p>
			<b>${feedDetails.getDescription()}</b>
		</p>
		<p>
			<b>${feedDetails.getPubDate()}</b>
		</p>
		<button id="button-subscribe" type="button"
			class="btn btn-primary btn-md">${subscription}</button>
	</div>

	<br>
	<br>
	<div id="tabs">
		<ul>
			<c:forEach var="feedMessage" items="${feedMessageList}">
				<li><a href="#${feedMessage.getGuid()}">${feedMessage.getTitle()}</a></li>
			</c:forEach>
		</ul>
		<c:forEach var="feedMessage" items="${feedMessageList}">
			<div id="${feedMessage.getGuid()}" class="contents">
				<h3>${feedMessage.getTitle()}</h3>
				<h5>${feedMessage.getAuthor()}</h5>
				<br>
				<p>${feedMessage.getContent()}</p>
			</div>
		</c:forEach>
	</div>
	<br>
</body>
</html>
