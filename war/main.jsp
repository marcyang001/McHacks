<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilter"%>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.example.appengine.helloworld.Upload"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
<link rel="stylesheet" href="stylesheets/foundation.min.css" />
<link rel="stylesheet" href="stylesheets/owl.carousel.css">
<link rel="stylesheet" href="stylesheets/owl.theme.css">
<link rel="stylesheet" href="stylesheets/app.css">
<script src="javascripts/jquery.min.js"></script>
<script src="javascripts/foundation.min.js"></script>
<script src="javascripts/owl.carousel.min.js"></script>
</head>
<div class="title-bar" data-responsive-toggle="realEstateMenu"
	data-hide-for="small">
	<button class="menu-icon" type="button" data-toggle></button>
	<div class="title-bar-title">
		<a href="/">Home</a>
	</div>
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
	<div class="medium-7 large-9 columns">
		<h1>Want to transfer your lease?</h1>
		<p class="subheader">If you are going away after study and the
			lease will still be valid for some time? No worries anymore! Post
			your lease here for people to take yours!</p>
		<%
		  if (user != null) {
		%>
		<p>
			<button class="button" onclick="window.location='guestbook.jsp';">Post
				your lease now!</button>
		</p>
		<%
		  } else {
		%>
		<p>
			You need to signin to transfer your lease! <a class="button"
				href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
				in</a>
		</p>
		<%
		  }
		%>
	</div>
	<div class="medium-5 large-3 columns">
		<div class="callout secondary">
			<form>
				<div class="row">
					<div class="small-12 columns">
						<label>Minimum price? <input type="text" id="minPrice"
							placeholder="Enter in CAD">
						</label>
					</div>
					<div class="small-12 columns">
						<label>Maximum price? <input type="text" id="maxPrice"
							placeholder="Enter in CAD">
						</label>
						<button class="button" onclick="return search();">Search Now!</button>
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
	<p class="lead">Listings</p>
</div>
<div class="row small-up-1 medium-up-2 large-up-3">
	<%
	  int maxFetch = 6;
		double maxPrice = 100000000.0;
		double minPrice = 0.0;
		if (request.getParameter("maxPrice") != null) {
	  if (!request.getParameter("maxPrice").isEmpty()) {
		      maxPrice = Double.parseDouble(request.getParameter("maxPrice"));
	  }
	    }
		if (request.getParameter("minPrice") != null) {
	  if (!request.getParameter("minPrice").isEmpty()) {
		      minPrice = Double.parseDouble(request.getParameter("minPrice"));
	  }
	    }
		  DatastoreService datastore =
	  DatastoreServiceFactory.getDatastoreService();
		  Filter heightMinFilter =
		      new FilterPredicate("pricingJ",
		                          FilterOperator.GREATER_THAN_OR_EQUAL,
		                          minPrice);

		    Filter heightMaxFilter =
		      new FilterPredicate("pricingJ",
		                          FilterOperator.LESS_THAN_OR_EQUAL,
		                          maxPrice);

		    //Use CompositeFilter to combine multiple filters
		    Filter heightRangeFilter =
		      CompositeFilterOperator.and(heightMinFilter, heightMaxFilter);

	  // Run an ancestor query to ensure we see the most up-to-date
	  // view of the Greetings belonging to the selected Guestbook.
	  Query query =
	      new Query("Listing").setFilter(heightRangeFilter)
	          .addSort("pricingJ", Query.SortDirection.ASCENDING)
	          .addSort("date", Query.SortDirection.DESCENDING);
	  List<Entity> listings =
	      datastore.prepare(query).asList(FetchOptions.Builder.withLimit(500));
	  if (listings.isEmpty()) {
	%>
	<p>No Listings..</p>
	<%
	  } else {
	    if (request.getParameter("maxFetch") != null) {
	      if (!request.getParameter("maxFetch").isEmpty()) {
	        maxFetch = Integer.parseInt(request.getParameter("maxFetch"));
	      }
	    }
	    if (maxFetch < 6) {
	      maxFetch = 6;
	    }
	    for (int i = maxFetch - 6; i < maxFetch && i < listings.size(); i++) {
	      Entity listing = listings.get(i);
	      pageContext.setAttribute("home_addressH",
	          listing.getProperty("HomeAddressJ"));
	      pageContext.setAttribute("lease_price",
	          listing.getProperty("pricingJ"));
	      pageContext.setAttribute("contact_info",
	          listing.getProperty("contactJ"));
	      pageContext.setAttribute("start_period",
	          listing.getProperty("startPeriodJ"));
	      pageContext.setAttribute("title_info", listing.getProperty("titleJ"));
	      pageContext.setAttribute("listing_user", listing.getProperty("user"));
	%>
	<div class="column">
		<div class="callout">
			<p>${fn:escapeXml(title_info)}</p>
			<div class="listing">
				<div id="owl-demo" class="owl-carousel owl-theme">
					<%
					  List<String> images = Upload.getImages(listing);
					  for(String image : images){
					    pageContext.setAttribute("image", image);
					%>
					<div class="item">
						<div class="image-wrapper overlay-fade-in">
							<img src=${fn:escapeXml(image)} width="400" height="370">
							<div class="image-overlay-content">
								<h2>${listing_user.email}</h2>
							</div>
						</div>
					</div>
					<%
					  }
					%>
				</div>
			</div>
			<p class="lead">\$${fn:escapeXml(lease_price)}</p>
			<p class="subheader"><a target="_blank" href="http://maps.google.com/?q=${fn:escapeXml(home_addressH)}">${fn:escapeXml(home_addressH)}</a></p>
			<p>Phone: ${fn:escapeXml(contact_info)}</p>
			<p>Available from: ${fn:escapeXml(start_period)}</p>
		</div>
	</div>
	<%
	  }
		  }
	%>
</div>
<div class="row column">
	<%
    pageContext.setAttribute("maxPrice", Double.toString(maxPrice));
    pageContext.setAttribute("minPrice", Double.toString(minPrice));
	  if (maxFetch > 6) {
	    int previous = maxFetch - 6;
	    pageContext.setAttribute("prv", Integer.toString(previous));
	%>
	<a class="button hollow expanded" href="/?maxFetch=${fn:escapeXml(prv)}&maxPrice=${fn:escapeXml(maxPrice)}&minPrice=${fn:escapeXml(minPrice)}">Previous page</a>
	<%
	  }
	%>
	<%
	  if (maxFetch < listings.size()) {
	    int next = maxFetch + 6;
	    pageContext.setAttribute("next", Integer.toString(next));
	%>
	<a class="button hollow expanded" href="/?maxFetch=${fn:escapeXml(next)}&maxPrice=${fn:escapeXml(maxPrice)}&minPrice=${fn:escapeXml(minPrice)}">Next page</a>
	<%
	  }
	%>
</div>
<footer>
	<div class="row expanded callout secondary">
		<div style="text-align: right">
			<a href="#"><i class="fi-social-twitter"></i> Twitter</a> <a href="#"><i
				class="fi-social-facebook"></i> Facebook</a> <a href="#"><i
				class="fi-social-instagram"></i> Instagram</a> <a href="#"><i
				class="fi-social-linkedin"></i> Likedin</a>
		</div>
	</div>
	<div class="row">
		<div class="medium-6 columns">
			<ul class="menu">
				<li><a href="#">Legal</a></li>
				<li><a href="#">Partner</a></li>
				<li><a href="#">Career</a></li>
				<li><a href="#">About</a></li>
			</ul>
		</div>
		<div class="medium-6 columns">
			<ul class="menu float-right">
				<li class="menu-text">Copyright</li>
			</ul>
		</div>
	</div>
</footer>
<script type="text/javascript">
function search() {
	console.log("here");
	console.log(document.getElementById("minPrice").value);
	window.location.href="/?minPrice="+document.getElementById("minPrice").value+"&maxPrice="+document.getElementById("maxPrice").value;
	return false;
}
	$(document).ready(function() {
		$(".owl-carousel").owlCarousel({

			navigation : true, // Show next and prev buttons
			slideSpeed : 300,
			paginationSpeed : 400,
			singleItem : true

		// "singleItem:true" is a shortcut for:
		// items : 1, 
		// itemsDesktop : false,
		// itemsDesktopSmall : false,
		// itemsTablet: false,
		// itemsMobile : false

		});
	});
</script>