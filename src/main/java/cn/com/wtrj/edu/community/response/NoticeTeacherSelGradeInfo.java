package cn.com.wtrj.edu.community.response;

import java.util.List;

public class NoticeTeacherSelGradeInfo {
	private String schoolCode;
	
	private String schoolName;
	
	private List<GradeInfo> grades;

	public String getSchoolCode() {
		return schoolCode;
	}

	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public List<GradeInfo> getGrades() {
		return grades;
	}

	public void setGrades(List<GradeInfo> grades) {
		this.grades = grades;
	}
}
