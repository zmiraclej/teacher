package cn.com.wtrj.edu.community.teacher.common;

public class Constant {
	/**
	 * 页面request请求处理结果
	 * @author wusm
	 *
	 */
	public static class RetCode{
		
		/**
		 * 页面request请求处理结果：01：发生异常
		 */
		public static String ERROR = "01";
		
		/**
		 * 页面request请求处理结果：02：成功
		 */
		public static String SUCCESS = "02";
	}
	
	/**
	 * 通知公告类型
	 * @author wusm
	 *
	 */
	public static class NoticeType {
		/**
		 * 通知
		 */
		public static String NOTICE = "01";
		
		/**
		 * 公告
		 */
		public static String NOTICE_PUB = "02";
		
		public static String TEAHCER_NOTICE = "11";
	}
	
	
	public static class NoticeSelectKey {
		/** 科目选择KEY */
		public static final String COURSE_SELECT = "notice_couse_select";
		
		public static final String ROLE_SELECT = "notice_role_select";
		
	}
}
