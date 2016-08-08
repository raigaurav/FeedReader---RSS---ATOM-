package com.feeds.feeds;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.model.Feed;
import com.model.FeedMessage;
import com.model.MyFeeds;
import com.model.Register;
import com.model.UserFeedUrlBean;

import org.springframework.web.servlet.ModelAndView;

import com.rometools.rome.feed.*;
import com.rometools.rome.feed.module.Module;
import com.rometools.rome.feed.synd.SyndContent;
import com.rometools.rome.feed.synd.SyndEntry;
import com.rometools.rome.feed.synd.SyndFeed;
import com.rometools.rome.io.*;
import com.DAO.FeedsDAO;
import com.DAO.RegisterDAO;
/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	FeedsDAO feedsDAO;
	@Autowired
	RegisterDAO registerDAO;
	MyFeeds rss = new MyFeeds();

	@RequestMapping(value = {"/","/feedlinks"}, method = RequestMethod.GET)
	public String feedlinks(Model model) throws IOException {

		// Gives the username of current loggedin user
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//All are predefined build in spring function. Just have to use it
		String username = authentication.getName();

		//Gets list of feeds for username
		ArrayList<UserFeedUrlBean> userFeedBeanList = new ArrayList<UserFeedUrlBean>(feedsDAO.getListofFeeds(username));
		model.addAttribute("userFeedBeanList",userFeedBeanList);
		model.addAttribute("username",username);
		return "feedlinks";

	}


	@RequestMapping(value = "/feeds", method = RequestMethod.GET)
	public String home(@RequestParam("feedurl") String feedurl,Model model) throws IOException {

		// Gives the username of current loggedin user
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		//All are predefined build in spring function. Just have to use it
		String username = authentication.getName();

		SyndFeed syndFeeds = rss.getFeeds(feedurl);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-hh.mm.ss");
		String pubDate = null;
		if(null != syndFeeds.getPublishedDate() )
		{
			pubDate = formatter.format(syndFeeds.getPublishedDate());
		}

		Feed feedDetails = new Feed(syndFeeds.getTitle(),syndFeeds.getLink(), syndFeeds.getDescription(), syndFeeds.getLanguage(), syndFeeds.getCopyright(), pubDate);

		ArrayList<FeedMessage> feedMessageList = new ArrayList<FeedMessage>();
		for(SyndEntry entry : syndFeeds.getEntries())
		{
			FeedMessage feedMessage = new FeedMessage();
			feedMessage.setTitle(entry.getTitle());
			feedMessage.setAuthor(entry.getAuthor());
			feedMessage.setLink(entry.getLink());
			feedMessage.setGuid(entry.getUri());
			if(entry.getContents().size() > 0)
			{
				feedMessage.setContent(entry.getContents().get(0).getValue());
			}
			else if(entry.getDescription() != null)
			{
				feedMessage.setContent(entry.getDescription().getValue().toString());
			}
			feedMessageList.add(feedMessage);  
		}
		
		//Checking Subscription to the feedurl
		String subscription  = feedsDAO.checkSubscriptionOnPageLoad(feedDetails.getTitle(), feedurl, username);

		model.addAttribute("subscription", subscription);
		model.addAttribute("feedMessageList",feedMessageList);
		model.addAttribute("feedDetails",feedDetails);
		model.addAttribute("username",username);
		model.addAttribute("feedurl",feedurl);

		return "feeds";
	}


	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginpage(Model model) {
		return "login";
	}
	

	/*@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    return "redirect:/login?logout";//You can redirect wherever you want, but generally it's a good practice to show login screen again.
	}*/

	@ResponseBody
	@RequestMapping(value = "/newFeedUrl", method = RequestMethod.GET)
	public String searchUrl(@RequestParam("url") String searchUrl ,Model model) throws IOException, IllegalArgumentException, FeedException {

		String feedUrl = null;
		feedUrl = rss.getFeedUrl(searchUrl);
		System.out.println(feedUrl);
		return feedUrl; 	
	}


	@RequestMapping(value="/register")
	public String register(){

		return "register";
	}

	//Registration of new user
	@ResponseBody
	@RequestMapping(value="/newuser",method = RequestMethod.POST)
	public String newuser(@RequestParam("first_name") String first_name,@RequestParam("last_name") String last_name,
			@RequestParam("email")String username,@RequestParam("password")String password){
		System.out.println("newusercalled");
		Register reg = new Register(username,first_name,last_name,password,1);
		registerDAO.registration(reg);
		return "success";
	}

	@ResponseBody
	@RequestMapping(value="/userExists",method = RequestMethod.GET)
	public String userExists(@RequestParam("email") String username){
		String check = registerDAO.userExists(username);
		return check;
	}

	@ResponseBody
	@RequestMapping(value="/subscribe", method = RequestMethod.GET)
	public String subscribeFeeds(@RequestParam("feed_title") String feed_title, @RequestParam("feed_url") String feed_url) {
		// Gives the username of current loggedin user
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String username = authentication.getName();
		
		return feedsDAO.checkSubscription(feed_title, feed_url, username);
	}
}