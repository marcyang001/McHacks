/**
 * Copyright 2012 Google Inc. All Rights Reserved. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.example.appengine.helloworld;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class SignGuestbookServlet extends HttpServlet {
  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse resp)
      throws IOException {
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    
    /*
    String sublet = "sublet";
    
    String ownerName = req.getParameter("owner_name");
    String address = req.getParameter("address");
    String availTime = req.getParameter("time"); //the period when the lease is available to sublet
    String price = req.getParameter("price");
    //user the key Sublet to get all the leases available
    Key leaseKey = KeyFactory.createKey("Sublet", sublet);
    
    Date date = new Date();
    Entity lease = new Entity("Lease", leaseKey);
      
    lease.setProperty("user", user);
    lease.setProperty("owner", ownerName);
    lease.setProperty("available_date", availTime);
    lease.setProperty("address", address);
    lease.setProperty("price", price);
    
    */
  //this is the key for the whole entity --> Leasing
    String guestbookName = req.getParameter("leaseNameH");
    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);
    //dont touch these two lines
    
    
    
    String content = req.getParameter("addressH");
    String pricing = req.getParameter("priceH");
    String contact = req.getParameter("contactH");
    String startPeriod = req.getParameter("startPeriodH");
    String title = req.getParameter("titleH");
    
    Date date = new Date();
    //these data will be stored in the data storage
    Entity leasing = new Entity("Listing", guestbookKey);
    
    leasing.setProperty("user", user);
    leasing.setProperty("date", date);
    leasing.setProperty("HomeAddressJ", content);
    leasing.setProperty("pricingJ", pricing);
    leasing.setProperty("contactJ", contact);
    leasing.setProperty("startPeriodJ", startPeriod);
    leasing.setProperty("titleJ", title);
    
    
    
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    datastore.put(leasing);

    resp.sendRedirect("/guestbook.jsp?guestbookName=" + guestbookName);
    
  }
}