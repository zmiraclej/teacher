package cn.com.wtrj.edu.community.response;

import java.util.List;

public class ParentAddressBook {
	private String className;
	
	private List<ParentPhoneInfo> parentList;

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public List<ParentPhoneInfo> getParentList() {
		return parentList;
	}

	public void setParentList(List<ParentPhoneInfo> parentList) {
		this.parentList = parentList;
	}
	
}
