package cn.com.wtrj.edu.community.request.formBean;

public class ParentVisitorForm {
	public static final Integer VISIT_TYPE_PARENT = 0;
	private String student;
	private String parent;
	private String carNum;
	private String visitTime;
	private String leaveTime;
	private String visitRemark;

	public String getStudent() {
		return student;
	}

	public void setStudent(String student) {
		this.student = student;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getCarNum() {
		return carNum;
	}

	public void setCarNum(String carNum) {
		this.carNum = carNum;
	}

	public String getVisitTime() {
		return visitTime;
	}

	public void setVisitTime(String visitTime) {
		this.visitTime = visitTime;
	}

	public String getLeaveTime() {
		return leaveTime;
	}

	public void setLeaveTime(String leaveTime) {
		this.leaveTime = leaveTime;
	}

	public String getVisitRemark() {
		return visitRemark;
	}

	public void setVisitRemark(String visitRemark) {
		this.visitRemark = visitRemark;
	}

	@Override
	public String toString() {
		return "visitorForm [student=" + student + ", parent=" + parent + ", carNum=" + carNum + ", visitTime="
				+ visitTime + ", leaveTime=" + leaveTime + ", visitRemark=" + visitRemark + "]";
	}

}
