package cn.com.wtrj.edu.community.teacher.controller.pay;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.teacher.common.Constant.RetCode;
import cn.com.wtrj.edu.community.teacher.common.PayItemConstant;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtStudentPayInfo;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtStudentPayStatusInfo;
import cn.com.wtrj.jx.web.portal.service.IWtrjStudentService;
import cn.com.wtrj.jx.web.portal.service.ecomAnnualPayRec.IEcomAnnualPayRecService;

@Controller
@RequestMapping("/pay")
public class PayController extends BaseController {
	@Autowired
	private IEcomAnnualPayRecService payService;
	@Autowired
	private IWtrjStudentService stuService;

	private static final Logger logger = Logger.getLogger(PayController.class);

	/**
	 * 查询班级年费缴纳状况
	 * 
	 * @return
	 */
	@RequestMapping("serachClassPaymentInfo")
	@ResponseBody
	public BaseRet<Map<String, Object>> searchClassPaymentInfo(String status) {
		logger.info("按班主任id查询所辖学生缴费状况");
		BaseRet<Map<String, Object>> ret = new BaseRet<Map<String, Object>>();
		ret.setCode(RetCode.SUCCESS);
		try {
			// 获取当前登录老师id，权限控制在首页菜单加载时完成，能进入此页面一定为班主任。
			int teacherId = getCurrentUser().getUserId();
			if("全部".equals(status)){
				status=null;
			}
			if("已缴".equals(status)){
				status="1";
			}
			if("未缴".equals(status)){
				status="0";
			}
			// int payItemId=PayItemConstant.SERVICE_CHARGE.getId();
			logger.info("[班主任teacherId=" + teacherId);
			// 按当前班主任id,缴费状态查询学生缴费情况
			List<MtStudentPayStatusInfo> payInfo = payService.searchStudentsPayStatusInfoByHearTeacher(teacherId,
					status);

			int totalNumber = stuService.findStudentsByHeadTeacher(teacherId).size();
			int paidNumber = payService.searchStudentsPayStatusInfoByHearTeacher(teacherId, "1").size();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("totalNumber", totalNumber);
			map.put("paidNumber", paidNumber);
			map.put("unpaidNumber", totalNumber-paidNumber);
			map.put("records", payInfo);
			ret.setData(map);
		} catch (Exception e) {
			ret.setCode(RetCode.ERROR);
			ret.setMsg("系统异常！");
			
		}
		logger.info("【查询结束】");
		return ret;
	}
}
