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
<%@ page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link rel="stylesheet" href="stylesheets/foundation.min.css" />
<script src="javascripts/jquery.min.js"></script>
<script src="javascripts/foundation.min.js"></script>
</head>
<div class="title-bar" data-responsive-toggle="realEstateMenu"
	data-hide-for="small">
	<button class="menu-icon" type="button" data-toggle></button>
	<div class="title-bar-title">Menu</div>
</div>
<div class="top-bar" id="realEstateMenu">
	<div class="top-bar-left">
		<ul class="menu" data-responsive-menu="accordion">
			<li class="menu-text">Lease transfer made faster and easier</li>
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
<div class="row">
	<div class="medium-7 large-6 columns">
		<h1>Close Your Eyes and Open Your Mind</h1>
		<p class="subheader">There is beauty in space, and it is orderly.
			There is no weather, and there is regularity. It is predictable.
			Everything in space obeys the laws of physics. If you know these
			laws, and obey them, space will treat you kindly.</p>
		<button class="button">Take a Tour</button>
		<button class="button">Start a free trial</button>
	</div>
	<div class="show-for-large large-3 columns">
		<img src="http://placehold.it/400x370&text=PSR1257 + 12 C"
			alt="picture of space">
	</div>
	<div class="medium-5 large-3 columns">
		<div class="callout secondary">
			<form>
				<div class="row">
					<div class="small-12 columns">
						<label>Find Your Dream Planet <input type="text"
							placeholder="Search destinations">
						</label>
					</div>
					<div class="small-12 columns">
						<label>Number of Moons <input type="number"
							placeholder="Moons required">
						</label>
						<button type="submit" class="button">Search Now!</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="row column">
	<hr>
</div>
<div class="row column">
	<p class="lead">Trending Planetary Destinations</p>
</div>
<div class="row small-up-1 medium-up-2 large-up-3">
	<div class="column">
		<div class="callout">
			<p>Pegasi B</p>
			<p>
				<img src="http://placehold.it/400x370&text=Pegasi B"
					alt="image of a planet called Pegasi B">
			</p>
			<p class="lead">Copernican Revolution caused an uproar</p>
			<p class="subheader">Find Earth-like planets life outside the
				Solar System</p>
		</div>
	</div>
	<div class="column">
		<div class="callout">
			<p>Pegasi B</p>
			<p>
				<img src="http://placehold.it/400x370&text=Pegasi B"
					alt="image of a planet called Pegasi B">
			</p>
			<p class="lead">Copernican Revolution caused an uproar</p>
			<p class="subheader">Find Earth-like planets life outside the
				Solar System</p>
		</div>
	</div>
	<div class="column">
		<div class="callout">
			<p>Pegasi B</p>
			<p>
				<img src="http://placehold.it/400x370&text=Pegasi B"
					alt="image of a planet called Pegasi B">
			</p>
			<p class="lead">Copernican Revolution caused an uproar</p>
			<p class="subheader">Find Earth-like planets life outside the
				Solar System</p>
		</div>
	</div>
	<div class="column">
		<div class="callout">
			<p>Pegasi B</p>
			<p>
				<img src="http://placehold.it/400x370&text=Pegasi B"
					alt="image of a planet called Pegasi B">
			</p>
			<p class="lead">Copernican Revolution caused an uproar</p>
			<p class="subheader">Find Earth-like planets life outside the
				Solar System</p>
		</div>
	</div>
	<div class="column">
		<div class="callout">
			<p>Pegasi B</p>
			<p>
				<img src="http://placehold.it/400x370&text=Pegasi B"
					alt="image of a planet called Pegasi B">
			</p>
			<p class="lead">Copernican Revolution caused an uproar</p>
			<p class="subheader">Find Earth-like planets life outside the
				Solar System</p>
		</div>
	</div>
	<div class="column">
		<div class="callout">
			<p>Pegasi B</p>
			<p>
				<img src="http://placehold.it/400x370&text=Pegasi B"
					alt="image of a planet called Pegasi B">
			</p>
			<p class="lead">Copernican Revolution caused an uproar</p>
			<p class="subheader">Find Earth-like planets life outside the
				Solar System</p>
		</div>
	</div>
</div>
<div class="row column">
	<a class="button hollow expanded">Load More</a>
</div>
<footer>
	<div class="row expanded callout secondary">
		<div class="small-6 large-3 columns">
			<p class="lead">Offices</p>
			<ul class="menu vertical">
				<li><a href="#">One</a></li>
				<li><a href="#">Two</a></li>
				<li><a href="#">Three</a></li>
				<li><a href="#">Four</a></li>
			</ul>
		</div>
		<div class="small-6 large-3 columns">
			<p class="lead">Solar Systems</p>
			<ul class="menu vertical">
				<li><a href="#">One</a></li>
				<li><a href="#">Two</a></li>
				<li><a href="#">Three</a></li>
				<li><a href="#">Four</a></li>
			</ul>
		</div>
		<div class="small-6 large-3 columns">
			<p class="lead">Contact</p>
			<ul class="menu vertical">
				<li><a href="#"><i class="fi-social-twitter"></i> Twitter</a></li>
				<li><a href="#"><i class="fi-social-facebook"></i> Facebook</a></li>
				<li><a href="#"><i class="fi-social-instagram"></i>
						Instagram</a></li>
				<li><a href="#"><i class="fi-social-pinterest"></i>
						Pinterest</a></li>
			</ul>
		</div>
		<div class="small-6 large-3 columns">
			<p class="lead">Offices</p>
			<ul class="menu vertical">
				<li><a href="#">One</a></li>
				<li><a href="#">Two</a></li>
				<li><a href="#">Three</a></li>
				<li><a href="#">Four</a></li>
			</ul>
		</div>
	</div>
	<div class="row">
		<div class="medium-6 columns">
			<ul class="menu">
				<li><a href="#">Legal</a></li>
				<li><a href="#">Partner</a></li>
				<li><a href="#">Explore</a></li>
			</ul>
		</div>
		<div class="medium-6 columns">
			<ul class="menu float-right">
				<li class="menu-text">Copyright</li>
			</ul>
		</div>
	</div>
</footer>
</html>