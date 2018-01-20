package cn.com.wtrj.edu.community.teacher.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 页面跳转控制器
 * 
 * @author admin
 *
 */
@Controller
@RequestMapping("/pageSkip")
public class PageSkipController {

	/**
	 * 综合分析，跳转到/comprehensiveAnalysis/comprehensiveAnalysisIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/comprehensiveAnalysis")
	public String toComprehensiveAnalysis() {
		return "comprehensiveAnalysis/comprehensiveAnalysisIndex";
	}

	/**
	 * 成绩，跳转到/score/scoreIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/score")
	public String toSCore() {
		return "score/scoreIndex";
	}
	/**
	 * 教师信息
	 * @return
	 */
	@RequestMapping("/teacherInfo")
	public String toTeacherInfo() {
		return "teacherInfo/teacherInfo";
	}

	/**
	 * 考勤，跳转到/attendance/attendanceIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/attendance")
	public String toAttendance() {
		return "/attendance/attendanceIndex";
	}

	/**
	 * 综合素质，跳转到/quality/qualityIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/quality")
	public String toQuality() {
		return "quality/qualityIndex";
	}
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/mainPage")
	public String mainPage(Model model,String id) {
		model.addAttribute("id", id);
		return "phoneNumList/mainPage";
	}
	/**
	 * 家长会详情页面
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping("/parentsMeetingDitail")
	public String parentsMeetingDitail(Model model,String id) {
		model.addAttribute("id", id);
		return "parentsMeeting/parentsMeetingDitail";
	}

	/**
	 * 生辅老师查看信息
	 * 
	 * @return
	 */
	@RequestMapping("/cartInformation")
	public String cartInformation() {
		return "/cartInformation/cartInformation";
	}
	/**
	 * 家长会
	 * @return
	 */
	@RequestMapping("/parentsMeeting")
	public String parentsMeeting() {
		return "/parentsMeeting/parentsMeetingHistory";
	}
	/**
	 * 调到家长会发布页面
	 * @return
	 */
	@RequestMapping("/publishParentsMeeting")
	public String publishParentsMeeting(Model model,Integer teacherId) {
		return "/parentsMeeting/publishParentsMeeting";
	}
	/**
	 * 班主任查看信息
	 * 
	 * @return
	 */
	@RequestMapping("/headTeacherExamine")
	public String headTeacherExamine() {
		return "/headTeacherExamine/headTeacherExamine";
	}
	/**
	 * 通讯录
	 *
	 * @return
	 */
	@RequestMapping("/phoneNumList")
	public String phoneNumList() {
		return "/phoneNumList/phoneNumList";
	}
	/**
	 * 教职工通讯录
	 *
	 * @return
	 */
	@RequestMapping("/empPhoneListMain")
	public String queryEmpPhoneListMain() {
		return "phoneNumList/empAddrListMain";
	}

	/**
	 * 成长足迹，跳转到/growth/growthIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/growth")
	public String toGrowth() {
		return "/growth/growthIndex";
	}

	/**
	 * 个人主页，跳转到/personalHomepage/personalHomepageIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/personalHomepage")
	public String toPersonalHomePage() {
		return "/personalHomepage/personalHomepageIndex";
	}

	/**
	 * 发表功能
	 * 
	 * @return
	 */
	@RequestMapping("/upload")
	public String upload() {
		return "/upload/uploadIndex";
	}

	/**
	 * 课程表，跳转到/course/courseIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/course")
	public String toCourse() {
		return "course/courseIndex";
	}

	/**
	 * 访客登记，跳转到visitor/visitorIndex.jsp
	 * 
	 * @return
	 */

	@RequestMapping("/visitor/list")
	public String toVisitor() {
		return "visitor/visitorList";
	}

	/**
	 * 班级圈发布，跳转到/classCircle/classCirclePublish.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/classCirclePublish")
	public String toClassCirclePublish() {
		return "classCircle/classCirclePublish";
	}

	/**
	 * 班级圈，跳转到/classCircle/classCircleIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/classCircleIndex")
	public String toClassCircleIndex() {
		return "classCircle/classCircleIndex";
	}
	
	/**
	 * 跳转到学生评分，跳转到/stuIns/stuInsIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/stuInsIndex")
	public String toStuInsIndex() {
		return "stuIns/stuInsIndex";
	}
	
	
	@RequestMapping("/leave/list")
	public String toLeave() {
		return "leave/index";
	}
	
	/**
	 * 跳转到缴费情况查询页面
	 * @return
	 */
	@RequestMapping("/paymentSummary")
	public String toPaymentSummary() {
		return "serviceChagePayment/paymentSummary";
	}
	
	@RequestMapping("/toTeacherAddressBook")
	public String toTeacherAdressBook() {
		return "teacherAddressBook/index";
	}
	
	@RequestMapping("/toTeacherArchive")
	public String toTeacherArchive() {
		return "teacherArchive/index";
	}
	
	@RequestMapping("/toScore")
	public String toScore() {
		return "score/junfenTongji";
	}
	
	@RequestMapping("/toParentAddressBook")
	public String toParentAddressBook() {
		return "phoneNumList/parentAddrListMain";
	}
	
	@RequestMapping("/toStudentPage")
	public String studentPage(Model model,String id) {
		model.addAttribute("id", id);
		return "parentAddressBook/studentPage";
	}
}
