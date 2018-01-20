package cn.com.wtrj.edu.community.teacher.request;

public class TeacherSelectParam {
	private String teacherKeyNo;
	
	private Boolean selected;

	public String getTeacherKeyNo() {
		return teacherKeyNo;
	}

	public void setTeacherKeyNo(String teacherKeyNo) {
		this.teacherKeyNo = teacherKeyNo;
	}

	public Boolean getSelected() {
		return selected;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}
}
