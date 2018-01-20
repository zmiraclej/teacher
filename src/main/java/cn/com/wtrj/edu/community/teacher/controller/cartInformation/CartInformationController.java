package cn.com.wtrj.edu.community.teacher.controller.cartInformation;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.common.Constant;
import cn.com.wtrj.edu.community.teacher.common.Constant.RetCode;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomClass;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjParent;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjStudent;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtDormBackDelay;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtParentInfo;
import cn.com.wtrj.jx.web.portal.service.IWtrjEcomClassService;
import cn.com.wtrj.jx.web.portal.service.IWtrjStudentService;
import cn.com.wtrj.jx.web.portal.service.parent.IWtrjEcomParentService;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.api.impl.WxCpServiceImpl;
import me.chanjar.weixin.cp.bean.WxCpMessage;
import me.chanjar.weixin.cp.config.WxCpConfigStorage;
import me.chanjar.weixin.cp.config.WxCpInMemoryConfigStorage;

@Controller
@RequestMapping("/cartInformation")
public class CartInformationController extends BaseController {
	private static Logger logger = Logger.getLogger(CartInformationController.class);
	@Autowired
	private IWtrjEcomClassService wtrjEcomClassService;

	@Autowired
	private IWtrjEcomParentService wtrjEcomParentService;

	@Autowired
	private IWtrjStudentService wtrjStudentService;

	@Value("${send_to_appid}")
	String appid;
	@Value("${send_to_secret}")
	String secret;
	@Value("${send_to_agent_id}")
	String sendToAgentId;

	/**
	 * 通过生辅教师找到对应的班级
	 * 
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/searchClassByTeacherId")
	public BaseRet<List<WtrjEcomClass>> searchStudentList() {
		logger.info("查询家长对应下的学生集合");
		BaseRet<List<WtrjEcomClass>> ret = new BaseRet<List<WtrjEcomClass>>();
		try {
			ShiroUser teacher = getCurrentUser();
			List<WtrjEcomClass> list = wtrjEcomClassService.searchClassByTeacherId(teacher.getUserId());
			ret.setData(list);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("查询家长对应下的学生集合结束");
		return ret;
	}

	@ResponseBody
	@RequestMapping(value = "/searchDormBackDelayById", method = RequestMethod.GET)
	public BaseRet<List<MtDormBackDelay>> searchDormBackDelayById(Integer classId) {
		logger.info("查询考勤记录集合");
		BaseRet<List<MtDormBackDelay>> ret = new BaseRet<List<MtDormBackDelay>>();

		try {
			List<MtDormBackDelay> list = wtrjEcomClassService.searchDormBackDelayById(classId);
			ret.setData(list);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("查询考勤记录结束");
		return ret;
	}

	/**
	 * 班主任查询异常打卡学生记录
	 * 
	 * @param teacherId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/headTeacherSearchDormBackDelay", method = RequestMethod.GET)
	public BaseRet<List<MtDormBackDelay>> headTeacherSearchDormBackDelay(Integer teacherId) {
		logger.info("班主任查询考勤记录异常集合");
		BaseRet<List<MtDormBackDelay>> ret = new BaseRet<List<MtDormBackDelay>>();

		try {
			ShiroUser teacher = getCurrentUser();
			List<MtDormBackDelay> list = wtrjEcomClassService.headTeacherSearchDormBackDelay(teacher.getUserId());
			ret.setData(list);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("班主任查询考勤记录异常集合结束");
		return ret;
	}

	/**
	 * 推送消息给班主任
	 * 
	 * @param str
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/informationToHeadTeacher", method = RequestMethod.GET)
	public BaseRet<String> informationToHeadTeacher(String str) {
		logger.info("推送消息给班主任");
		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);
			String strAfter = str.substring(0, str.length());
			String[] strArr = strAfter.split(",");
			for (String s : strArr) {
				wtrjEcomClassService.informationToHeadTeacher(Integer.parseInt(s));
			}

			// List<MtDormBackDelay> list=wtrjEcomClassService.
			ret.setMsg("推送消息给班主任成功");
		} catch (Exception e) {
			logger.error("推送消息给班主任失败！", e);
			ret.setCode(Constant.RetCode.ERROR);
			ret.setMsg("推送消息给班主任失败！" + e.getMessage());
		}
		logger.info("推送消息给班主任结束.");
		return ret;
	}

	@ResponseBody
	@RequestMapping(value = "/informationToHouseholder", method = RequestMethod.POST)
	public BaseRet<String> informationToHouseholder(String str) {
		logger.info("推送消息给家长");
		BaseRet<String> ret = new BaseRet<String>();
		try {
			List<String> list = new ArrayList<String>();
			String strAfter = str.substring(0, str.length());
			String[] strArr = strAfter.split(",");
			if (strArr.length > 0) {
				for (String s : strArr) {
					String studentNo = wtrjEcomClassService.selectStudentNoById(Integer.parseInt(s));
					if (studentNo != null && studentNo.length() != 0 && !"null".equals(studentNo)) {
						list.add(studentNo);
					}
				}
			}

			WxCpService wxCpService = new WxCpServiceImpl();
			WxCpInMemoryConfigStorage config = new WxCpInMemoryConfigStorage();
			// 设置微信企业号的appid
			config.setCorpId(appid);
			// 设置微信企业号的app corpSecret
			config.setCorpSecret(secret);
			wxCpService.setWxCpConfigStorage((WxCpConfigStorage) (config));
			// 获取接收消息的应用id
			Integer agentId = Integer.parseInt(sendToAgentId);
			if (list != null && list.size() > 0) {
				for (String studentNoStr : list) {

					// 根据学号查询学生信息
					WtrjStudent student = wtrjStudentService.searchStudentInfoByStudentNo(studentNoStr);
					// 获取家长信息
					List<MtParentInfo> parents = wtrjEcomParentService.findWtrjParentsByStudentNo(studentNoStr);

					
					
					MtDormBackDelay dormBackDelay = wtrjEcomClassService.searchMtDormBackDelayByStudentNo(studentNoStr);

					String content = "您的孩子--" + dormBackDelay.getName() + "于" + dormBackDelay.getCheckDate()
							+ "打卡，打卡时间异常。";
					logger.info("开始向家长推送信息：" + content);
					// 将消息发送给指定用户
					// 根据消息中的学生id找到对应的家长(根据学生id查询家长表信息,得到家长的企业号账号)
					for (MtParentInfo parent : parents) {
						String phone = parent.getPhone();
						WxCpMessage wxmessage = WxCpMessage.TEXT().agentId(agentId).toUser(phone).content(content)
								.build();
						wxCpService.messageSend(wxmessage);
					}
					// 修改状态
					wtrjEcomClassService.informationToHouseholder(studentNoStr);
				}
			}
			logger.info("推送消息给家长完成");
			ret.setMsg("推送消息给家长成功");
			ret.setCode(Constant.RetCode.SUCCESS);
		} catch (Exception e) {
			logger.error("推送消息给家长失败！", e);
			ret.setCode(Constant.RetCode.ERROR);
			ret.setMsg("推送消息给家长失败！" + e.getMessage());
		}
		logger.info("推送消息给家长结束.");
		return ret;
	}

}