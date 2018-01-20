package cn.com.wtrj.edu.community.teacher.bean;

import java.io.Serializable;

public class UiSelectBean implements Serializable{

	protected String title;
	
	protected String value;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
