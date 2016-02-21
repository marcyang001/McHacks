package com.example.appengine.helloworld;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class Upload extends HttpServlet {
  private BlobstoreService blobstoreService = BlobstoreServiceFactory
      .getBlobstoreService();

  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse res)
      throws ServletException, IOException {

    Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
    List<BlobKey> blobKeys = blobs.get("myFile");
    List<String> imagesUrl = new ArrayList<String>();
    String baseUrl = "http://mchack2016.appspot.com";
    if (req.getRequestURL().toString().contains("localhost")) {
      baseUrl = "http://localhost:8888";
    }
    for (BlobKey bk : blobKeys) {
      imagesUrl.add(baseUrl + "/serve?blob-key=" + bk.getKeyString());
    }
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    // this is the key for the whole entity --> Leasing
    // dont touch these two lines
    String content = req.getParameter("addressH");
    double pricing = Double.parseDouble(req.getParameter("priceH"));
    String contact = req.getParameter("contactH");
    String startPeriod = req.getParameter("startPeriodH");
    String title = req.getParameter("titleH");
    Key guestbookKey = KeyFactory.createKey("Guestbook", user.getNickname()+title);
    Date date = new Date();
    // these data will be stored in the data storage
    Entity leasing = new Entity("Listing", guestbookKey);
    leasing.setProperty("user", user);
    leasing.setProperty("date", date);
    leasing.setProperty("HomeAddressJ", content);
    leasing.setProperty("pricingJ", pricing);
    leasing.setProperty("contactJ", contact);
    leasing.setProperty("startPeriodJ", startPeriod);
    leasing.setProperty("titleJ", title);
    leasing.setProperty("images", imagesUrl);
    
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    datastore.put(leasing);
    if (blobKeys == null || blobKeys.isEmpty()) {
      res.sendError(res.SC_INTERNAL_SERVER_ERROR, "File upload was not successful. Please try again");
    } else {
      res.sendRedirect("/");
//      res.sendRedirect("/serve?blob-key=" + blobKeys.get(0).getKeyString() + "ANG" + blobKeys.get(1).getKeyString());
    }
  }
  public static List<String> getImages(Entity e) {
    return (List<String>) e.getProperty("images");
  }
}
