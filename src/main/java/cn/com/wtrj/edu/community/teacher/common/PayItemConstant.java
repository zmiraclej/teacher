package cn.com.wtrj.edu.community.teacher.common;

/**
 * 缴费项目
 * @author admin
 *
 */
public enum PayItemConstant {
	SERVICE_CHARGE(1,"服务费");
	private int id;
	private String name;
	
	PayItemConstant(int id,String name){
		this.id=id;
		this.name=name;
	}
	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}
	
}
