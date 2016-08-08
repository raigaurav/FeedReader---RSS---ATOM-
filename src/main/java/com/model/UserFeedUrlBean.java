package com.model;

public class UserFeedUrlBean {

	String feedlink;
	
	String feedname;

	public String getFeedlink() {
		return feedlink;
	}

	public void setFeedlink(String feedlink) {
		this.feedlink = feedlink;
	}

	public String getFeedname() {
		return feedname;
	}

	public void setFeedname(String feedname) {
		this.feedname = feedname;
	}

	@Override
	public String toString() {
		return "UserFeedUrlBean [feedlink=" + feedlink + ", feedname="
				+ feedname + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((feedlink == null) ? 0 : feedlink.hashCode());
		result = prime * result
				+ ((feedname == null) ? 0 : feedname.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserFeedUrlBean other = (UserFeedUrlBean) obj;
		if (feedlink == null) {
			if (other.feedlink != null)
				return false;
		} else if (!feedlink.equals(other.feedlink))
			return false;
		if (feedname == null) {
			if (other.feedname != null)
				return false;
		} else if (!feedname.equals(other.feedname))
			return false;
		return true;
	}
	
	
	
}
