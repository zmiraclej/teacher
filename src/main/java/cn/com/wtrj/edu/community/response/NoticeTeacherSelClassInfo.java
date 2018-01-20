package cn.com.wtrj.edu.community.response;

import java.util.List;

public class NoticeTeacherSelClassInfo {
	private String schoolCode;
	
	private String schoolName;
	
	private Integer grade;
	
	private String gradeName;
	
	private List<ClassInfo> classes;

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

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	public List<ClassInfo> getClasses() {
		return classes;
	}

	public void setClasses(List<ClassInfo> classes) {
		this.classes = classes;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}
}
