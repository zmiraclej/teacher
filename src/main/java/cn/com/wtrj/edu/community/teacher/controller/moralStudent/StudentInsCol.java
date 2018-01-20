package cn.com.wtrj.edu.community.teacher.controller.moralStudent;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.common.Constant.RetCode;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.jx.web.portal.model.entities.moralStudent.WtrjMoralINS;
import cn.com.wtrj.jx.web.portal.model.mt.entities.moral.MtInsDto;
import cn.com.wtrj.jx.web.portal.service.dto.UserPermission;
import cn.com.wtrj.jx.web.portal.service.moralStudent.IWtrjMoralINSService;

//学生信息实例信息查看
@Controller
@RequestMapping("/stuIns")
public class StudentInsCol extends BaseController {
	/** 班主任 **/
	public static final String TEACHER_BZR = "01";
	/** 任课老师 **/
	public static final String TEACHER_RKLS = "02";
	/** 生辅老师 **/
	public static final String TEACHER_SFLS = "03";
	/** 德育老师 **/
	public static final String TEACHER_DEYLS = "04";
	private static Logger logger = Logger.getLogger(StudentInsCol.class);

	@Autowired
	private IWtrjMoralINSService wtrjMoralINSService;

	@ResponseBody
	@RequestMapping(value = "/list")
	public BaseRet<List<MtInsDto>> list() {
		logger.info("教师查询所需要评分的学生");
		BaseRet<List<MtInsDto>> ret = new BaseRet<List<MtInsDto>>();
		try {
			List<MtInsDto> list = getInsListByUserPermisson();
			ret.setData(list);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("教师查询所需要评分的学生");
		return ret;
	}

	// 获取详情
	@RequestMapping(value = "/detail")
	public String stuInsDetail(@RequestParam(value = "id") Integer id, Model model) {
		logger.info("教师查询学生评分详情");
		MtInsDto result = wtrjMoralINSService.getINSDto(id);
		model.addAttribute("ins", result);
		logger.info("教师查询学生评分详情");
		return "stuIns/stuInsDetail";
	}

	/**
	 * 根据老师不同的角色，查询学生实例
	 * 
	 * 班主任和任课老师直接根据teacherId查询
	 * 
	 * @return
	 */
	private List<MtInsDto> getInsListByUserPermisson() {
//		ShiroUser teacher = getCurrentUser();
////		UserPermission up = getPermission();
		List<MtInsDto> list = new ArrayList<MtInsDto>();
//
//		// 模拟登录角色
//		up.setIsHeadTeacher(true);
//		//up.setIsCourseTeacher(true);
//		//up.setIsMoralTeacher(true);
//		// up.setIsDormTeacher(true);
//		// 班主任和任课老师
//		if (up.getIsHeadTeacher() != null && (up.getIsHeadTeacher() || up.getIsCourseTeacher())) {
//			// 模拟数据
//			//teacher.setUserId(2);
////			list = wtrjMoralINSService.selectINSByPageByTeacherId(0, 1000, null, teacher.getUserId());
//		}
//		// 生辅老师
//		if (up.getIsDormTeacher() != null && up.getIsDormTeacher()) {
//			// 模拟数据
//			List<Integer> l = new ArrayList<Integer>();
//			l.add(1);
//			l.add(2);
////			list = wtrjMoralINSService.lifeTeacherGetINS(l);
//		}
//		// 德育老师
//		if (up.getIsMoralTeacher() != null && up.getIsMoralTeacher()) {
//			// 模拟数据
//			String schoolCode = "0202";
////			list = wtrjMoralINSService.deYuTeacherGetINS(schoolCode);
//		}
		return list;
	}
}
