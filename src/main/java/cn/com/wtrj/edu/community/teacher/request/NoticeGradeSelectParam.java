package cn.com.wtrj.edu.community.teacher.request;

public class NoticeGradeSelectParam {
	private String gradeKeyNo;
	
	private Boolean selected;

	public Boolean getSelected() {
		return selected;
	}

	public void setSelected(Boolean selected) {
		this.selected = selected;
	}

	public String getGradeKeyNo() {
		return gradeKeyNo;
	}

	public void setGradeKeyNo(String gradeKeyNo) {
		this.gradeKeyNo = gradeKeyNo;
	}
}
