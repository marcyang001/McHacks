
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page
	import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link rel="stylesheet" href="stylesheets/foundation.min.css" />
<link rel="stylesheet" href="stylesheets/app.css">
<script src="javascripts/jquery.min.js"></script>
<script src="javascripts/foundation.min.js"></script>

<body>
<div class="title-bar" data-responsive-toggle="realEstateMenu"
	data-hide-for="small">
	<button class="menu-icon" type="button" data-toggle></button>
	<div class="title-bar-title">Menu</div>
</div>
<div class="top-bar" id="realEstateMenu">
	<div class="top-bar-left">
		<ul class="menu" data-responsive-menu="accordion">
			<li class="menu-text">Post your lease and get away from it!</li>
		</ul>
	</div>
	<div class="top-bar-right">
		<ul class="menu">
			<%
			  UserService userService = UserServiceFactory.getUserService();
						User user = userService.getCurrentUser();
						if (user != null) {
							pageContext.setAttribute("user", user);
			%>
			<p>
				${fn:escapeXml(user.nickname)} <a class="button"
					href="<%=userService.createLogoutURL(request.getRequestURI())%>">sign
					out</a>
			</p>
			<%
			  } else {
			%>
			<p>
				<a class="button"
					href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
					in</a>
			</p>
			<%
			  }
			%>
		</ul>
	</div>
</div>
<br>
	<form
		action="<%=BlobstoreServiceFactory.getBlobstoreService().createUploadUrl(
          "/upload")%>"
		method="post" enctype="multipart/form-data">
		<div>
			<label>Description<BR> <input name="titleH" size="20" placeholder="ex)size, characteristics"></label>
		</div>
		<div>
			<label>Phone Number<BR> <input name="contactH" size="20"></label>
		</div>
		<div>
			<label>Start Period of Lease <BR> <input
				name="startPeriodH" size="20" placeholder="yy/mm/dd or yyyy/mm"></label>
		</div>

		<div>
			<label>Price per Month<BR> <input name="priceH"
				size="20" placeholder="in CAD"></label>
		</div>
		<div>
			<label>Address</label><BR>
		</div>
		<div>
			<textarea name="addressH" rows="3" cols="60"></textarea>
		</div>
		<input type="file" name="myFile" multiple /> <input type="submit"
			value="Submit">
	</form>
</body>
</html>