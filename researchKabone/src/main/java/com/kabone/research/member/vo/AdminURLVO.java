package com.kabone.research.member.vo;

public class AdminURLVO {
	
	public String userLevel;
	public String menuId;
	public String menuUrl;
	
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuUrl() {
		return menuUrl;
	}
	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}
	@Override
	public String toString() {
		return "AdminURLVo [userLevel=" + userLevel + ", menuId=" + menuId
				+ ", menuUrl=" + menuUrl + "]";
	}
}
