package com.model;
import java.net.URL;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;

import com.rometools.rome.feed.*;
import com.rometools.rome.feed.synd.SyndEntry;
import com.rometools.rome.feed.synd.SyndFeed;
import com.rometools.rome.io.*;

public class MyFeeds {

	public String getFeedUrl(String pageUrl) throws IOException	{

		/* Parsing html directly
		 * String html = "<link rel='alternate' type='application/rss+xml' title='Example' href='http://www.aweber.com/blog/feed/'/>";
		 * Document doc = Jsoup.parse(html);
		 */
		// It uses Jsoup to check if website source code has above lines it.
		Document doc = Jsoup.connect(pageUrl).timeout(0).get();
		Elements links = doc.select("link");
		String linkHref = null;
		for(Element link : links) {
			if(link.attr("type") != null && (link.attr("type").equals("application/rss+xml") || link.attr("type").equals("application/atom+xml"))) {
				linkHref = link.attr("href");
			}
		}              
		if(linkHref == null) {
			URL feedUrl = new URL(pageUrl);
			SyndFeedInput input = new SyndFeedInput();    
			SyndFeed feed = null;
			try {
				feed = input.build(new XmlReader(feedUrl));
			} catch (Exception e) {
				System.out.println("No Rss Link Found"); 
				return null;
			}
			return pageUrl;		
		}
		else {
			System.out.println("Feed Url Found" + linkHref);
		}
		return linkHref;
	}
	
			
	public SyndFeed getFeeds(String url) {
		boolean ok = false;
		SyndFeed feed = null;
		try {

			URL feedUrl = new URL(url);
			SyndFeedInput input = new SyndFeedInput();
			feed = input.build(new XmlReader(feedUrl));
			
			System.out.println(feed);
			/*for ( SyndEntry entry : feed.getEntries())
			{
				System.out.println(entry.getTitle());
				System.out.println(entry.getContents());
				System.out.println();
			}*/

			/*System.out.println(feed.getEntries().get(1).getContents().get(0).getValue());*/

			ok = true;
			
		}
		catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("ERROR: "+ex.getMessage());
		}

		if (!ok) {
			System.out.println();
			System.out.println("FeedReader reads and prints any RSS/Atom feed type.");
			System.out.println("The first parameter must be the URL of the feed to read.");
			System.out.println();
		}
		return feed;
	}

}