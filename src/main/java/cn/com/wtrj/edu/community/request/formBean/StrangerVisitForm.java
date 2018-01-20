package cn.com.wtrj.edu.community.request.formBean;

public class StrangerVisitForm {
	private String visitorName;
	private String cardNo;
	private String phone;
	private String strCarNum;
	private String strVisitTime;
	private String strLeaveTime;
	private String strVisitRemark;
	public static final Integer VISIT_TYPE_STRANGER = 1;

	public String getVisitorName() {
		return visitorName;
	}

	public void setVisitorName(String visitorName) {
		this.visitorName = visitorName;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getStrCarNum() {
		return strCarNum;
	}

	public void setStrCarNum(String strCarNum) {
		this.strCarNum = strCarNum;
	}

	public String getStrVisitTime() {
		return strVisitTime;
	}

	public void setStrVisitTime(String strVisitTime) {
		this.strVisitTime = strVisitTime;
	}

	public String getStrLeaveTime() {
		return strLeaveTime;
	}

	public void setStrLeaveTime(String strLeaveTime) {
		this.strLeaveTime = strLeaveTime;
	}

	public String getStrVisitRemark() {
		return strVisitRemark;
	}

	public void setStrVisitRemark(String strVisitRemark) {
		this.strVisitRemark = strVisitRemark;
	}

	@Override
	public String toString() {
		return "StrVisitForm [visitorName=" + visitorName + ", cardNo=" + cardNo + ", phone=" + phone + ", strCarNum="
				+ strCarNum + ", strVisitTime=" + strVisitTime + ", strLeaveTime=" + strLeaveTime + ", strVisitRemark="
				+ strVisitRemark + "]";
	}

}
