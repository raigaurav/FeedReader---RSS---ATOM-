package com.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.model.UserFeedUrlBean;


public class FeedsDAO {

	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<UserFeedUrlBean> getListofFeeds(String username)
	{
		String select  = "Select FEEDNAME, FEEDURL from myfeeds_userfeeds where USERNAME = '"+username+"'";
		List<UserFeedUrlBean> result =  this.jdbcTemplate.query(select, new RowMapper<UserFeedUrlBean>(){
			@Override
			public UserFeedUrlBean mapRow(ResultSet rs, int arg1) throws SQLException{
				UserFeedUrlBean urlbean= new UserFeedUrlBean();
				urlbean.setFeedlink(rs.getString(2));
				urlbean.setFeedname(rs.getString(1));
				//return rs.getString(1);
				//return rs.getString(2);
				return urlbean;
			}
		});
		/*List<String> result = new ArrayList<String>();
		result.add("http://www.theverge.com/rss/full.xml");*/
		
		return result;
	}
	public String checkSubscriptionOnPageLoad(String feed_title,String feed_url, String username)
	{
		String smt = "Select FEEDURL from myfeeds_userfeeds where USERNAME = '"+username+"' and FEEDURL = '"+feed_url+"'";
		List<String> feedList = this.jdbcTemplate.query(smt, new RowMapper<String>(){
			@Override
			public String mapRow(ResultSet rs, int arg1) throws SQLException {
				String tmp = rs.getString(1);
				return tmp;
			}
		});
		if(feedList.isEmpty())
		{
		    return "Subscribe";
		}
		else
		{
			return "Unsubscribe";
		}
	}
	
	public String checkSubscription(String feed_title,String feed_url, String username)
	{
		String smt = "Select FEEDURL from myfeeds_userfeeds where USERNAME = '"+username+"' and FEEDURL = '"+feed_url+"'";
		List<String> feedList = this.jdbcTemplate.query(smt, new RowMapper<String>(){
			@Override
			public String mapRow(ResultSet rs, int arg1) throws SQLException {
				String tmp = rs.getString(1);
				return tmp;
			}
		});
		if(feedList.isEmpty())
		{
			String insertSmt = "Insert into myfeeds_userfeeds(USERNAME,FEEDURL,FEEDNAME) Values('"+username+"','"+feed_url+"','"+feed_title+"')";
		    jdbcTemplate.update(insertSmt);
		    return "Unsubscribe";
		}
		else
		{
			String deleteSmt = "Delete from myfeeds_userfeeds where USERNAME = '"+username+"' and FEEDURL = '"+feed_url+"'";
		    jdbcTemplate.update(deleteSmt);
			return "Subscribe";
		}
	}

	
}
