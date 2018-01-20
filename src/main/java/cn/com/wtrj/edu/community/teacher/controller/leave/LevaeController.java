package cn.com.wtrj.edu.community.teacher.controller.leave;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import cn.com.wtrj.edu.community.exception.DataSysException;
import cn.com.wtrj.edu.community.request.formBean.LeaveRecFormBean;
import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.common.Constant;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.util.DataSynUtil;
import cn.com.wtrj.edu.community.util.DateUtil;
import cn.com.wtrj.edu.community.util.RefuseFormRepeatCommitUtil;
import cn.com.wtrj.edu.community.util.TokenProccessor;
import cn.com.wtrj.edu.community.util.WeixinUtil;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomLeaveRec;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomSchoolAppid;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjParent;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjRptMsg;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjStudent;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjTeacher;
import cn.com.wtrj.jx.web.portal.service.ITeacherService;
import cn.com.wtrj.jx.web.portal.service.IWtrjStudentService;
import cn.com.wtrj.jx.web.portal.service.impl.SchoolAppidService;
import cn.com.wtrj.jx.web.portal.service.impl.SmsService;
import cn.com.wtrj.jx.web.portal.service.leave.IWtrjEcomLeaveRecService;
import cn.com.wtrj.jx.web.portal.service.parent.IWtrjEcomParentService;
import cn.com.wtrj.jx.web.portal.util.HttpRequestUtils;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.bean.WxCpMessage;

@Controller
@RequestMapping("/leave")
public class LevaeController extends BaseController {
	private static Logger logger = Logger.getLogger(LevaeController.class);
	@Autowired
	private IWtrjStudentService wtrjStudentServiceImpl;
	@Autowired
	private IWtrjEcomParentService wtrjEcomParentServiceImpl;
	@Autowired
	private IWtrjEcomLeaveRecService wtrjEcomLeaveRecServiceImpl;
	@Autowired
	private ITeacherService teacherServiceImpl;
	@Autowired
	private SchoolAppidService schoolAppidServiceImpl;
	@Autowired
	private SmsService smsService;

	/*
	 * @Value("${send_to_appid}") private String sendAppid;
	 * 
	 * @Value("${send_to_secret}") private String sendSecret;
	 * 
	 * @Value("${send_to_agent_id}") private Integer agentId;
	 */
	@Value("${sms_wx_send_api}")
	private String sendWxUrl;

	@Value("${esb_BaseUrl}")
	private String esbBaseUrl;
	@Value("${ecom_appid}")
	private String ecomAppid;
	@Value("${ecom_secret}")
	private String ecomSecret;

	@RequestMapping("/edit")
	public String editLeaveRec(HttpServletRequest request) {
		request.getSession().setAttribute("token", TokenProccessor.getInstance().makeToken()); // 在服务器使用session保存token(令牌)
		return "leave/leaveIndex";
	}

	@ResponseBody
	@RequestMapping("save")
	public BaseRet<String> toLeaveForm(@RequestBody LeaveRecFormBean leave, HttpServletRequest request) {
		/*
		 * // 防止表单重复提交 boolean repeat =
		 * RefuseFormRepeatCommitUtil.isRepeatSubmit(request);// 判断用户是否是重复提交 if
		 * (repeat == true) { return "leave/leaveList"; }
		 * request.getSession().removeAttribute("token");// 移除session中的token
		 */
		BaseRet<String> ret = new BaseRet<String>();
		WtrjEcomLeaveRec leaveRec = new WtrjEcomLeaveRec();
		try {
			// 获取当前用户
			ShiroUser currentUser = getCurrentUser();
			logger.info("获取当前用户信息：" + currentUser.getMobile());
			// 获取学生信息
			WtrjStudent student = wtrjStudentServiceImpl.selectByPrimaryKey(leave.getStudentId());
			// 查询指定学生的班主任信息
			List<WtrjTeacher> teacher = teacherServiceImpl.selectTeacherByStudentId(leave.getStudentId());

			// =============请假记录存入社区数据库======================
			Date startTime = DateUtil.dateStrToDate(leave.getStart(), DateUtil.DATAFORMAT_HM_STR);
			Date endTime = DateUtil.dateStrToDate(leave.getEnd(), DateUtil.DATAFORMAT_HM_STR);
			String uid = UUID.randomUUID().toString();
			leaveRec.setId(uid);
			leaveRec.setStudentId(leave.getStudentId());
			leaveRec.setStudentName(student.getName());
			leaveRec.setClassId(student.getClassId());
			leaveRec.setClassNo(student.getClassNo());
			leaveRec.setSchoolCode(student.getSchoolCode());
			leaveRec.setSchoolName(student.getSchoolName());
			leaveRec.setStage(Integer.valueOf(student.getCureentSchoolCode()));
			leaveRec.setGrade(student.getGradeNo());

			// 请假人0-教师 1-家长
			leaveRec.setStaterType("0");
			leaveRec.setType(leave.getType());
			leaveRec.setStartTime(startTime);
			leaveRec.setEndTime(endTime);
			leaveRec.setReason(leave.getReason());
			// 由老师端发起
			leaveRec.setStarterTeacherId(currentUser.getUserId());
			leaveRec.setStarterTeacherMobile(currentUser.getMobile());
			leaveRec.setStarterTeacherName(currentUser.getName());
			leaveRec.setStarterTeacherJobno(teacher.get(0).getJobNumber());
			// 家长确认状态 0-已确认 1-未确认
			leaveRec.setConfirmParentStatus("1");
			leaveRec.setCreateTime(new Date());
			leaveRec.setUpdateTime(new Date());
			
			// 请假申请是否有效0-无效 1-有效
			leaveRec.setFlag("1");
			logger.info("请假申请开始存入社区数据库:" + leaveRec.toString());
			wtrjEcomLeaveRecServiceImpl.saveLeaveRec(leaveRec);
			logger.info("请假申请存入社区数据库，成功！" + leaveRec.toString());
			ret.setCode(Constant.RetCode.SUCCESS);
			
			// 同步一卡通
			updateEsb(startTime, endTime, student.getStudentNo());
			
			// 发送微信消息通知
			sendWxMessage(leave.getStudentId(), Integer.valueOf(student.getSchoolCode()), uid);
		} catch (Exception e) {
			logger.error("请假申请失败！", e);
			ret.setCode(Constant.RetCode.ERROR);
			//请假失败时删除发起的请假
			wtrjEcomLeaveRecServiceImpl.deleteLeaveRecordsByStarterTeacherId(leaveRec);
		}
		return ret;
	}

	/**
	 * 老师确认请假
	 */
	@ResponseBody
	@RequestMapping("/updateStatus")
	public BaseRet<String> updateLeaveRecords(@RequestBody WtrjEcomLeaveRec rec) {
		BaseRet<String> ret = new BaseRet<String>();
		ShiroUser currentUser = getCurrentUser();
		WtrjEcomLeaveRec record = wtrjEcomLeaveRecServiceImpl.findLeaveRecById(rec.getId());
		List<WtrjTeacher> teacher = teacherServiceImpl.selectTeacherByStudentId(rec.getStudentId());
		try {
			logger.info("请假确认开始:" + rec.toString());
			rec.setUpdateTime(new Date());
			rec.setConfirmTeacherId(currentUser.getUserId());
			rec.setConfirmTeacherMobile(currentUser.getMobile());
			rec.setConfirmTeacherName(currentUser.getName());
			rec.setConfirmTeacherJobno(teacher.get(0).getJobNumber());
			rec.setConfirmTeacherTime(new Date());
			rec.setConfirmTeacherStatus("0");
			int result = wtrjEcomLeaveRecServiceImpl.updateConfirmTeacherStatus(rec);
			if (result > 0) {
				logger.info("请假确认成功:" + result);
				ret.setCode(Constant.RetCode.SUCCESS);
				// 成功确认后进行一卡通同步
				// 获取学生信息
				WtrjStudent student = wtrjStudentServiceImpl.selectByPrimaryKey(rec.getStudentId());
				// 同步一卡通
				updateEsb(record.getStartTime(), record.getEndTime(), student.getStudentNo());
				// 发送微信消息
				// sendWxMessage(student.getId(),
				// Integer.valueOf(student.getSchoolCode()),rec.getId());
			} else {
				logger.error("请假确认失败:" + result);
				ret.setCode(Constant.RetCode.ERROR);
			}
		} /*
			 * catch (DataSysException e) { logger.error("数据同步到一卡通失败"+e);
			 * ret.setCode(Constant.RetCode.ERROR); }
			 */ catch (Exception e) {
			logger.error("请假确认异常:" + e);
			ret.setCode(Constant.RetCode.ERROR);
		}
		return ret;
	}

	@RequestMapping("/records")
	@ResponseBody
	public List<WtrjEcomLeaveRec> listLeaveRecords() {
		ShiroUser currentUser = getCurrentUser();
		List<WtrjEcomLeaveRec> records = wtrjEcomLeaveRecServiceImpl
				.findLeaveRecordsByTeacherId(currentUser.getUserId());
		return records;
	}

	/**
	 * 教师删除请假记录
	 * 
	 * @param rec
	 * @return
	 */
	@ResponseBody
	@RequestMapping("deleteRecord")
	public BaseRet<String> deleteRecord(@RequestBody WtrjEcomLeaveRec rec) {
		BaseRet<String> ret = new BaseRet<String>();
		ShiroUser currentUser = getCurrentUser();
		try {
			rec.setStarterTeacherId(currentUser.getUserId());
			logger.info("教师删除请假记录开始！当前教师："+currentUser.getUserId());
			int result = wtrjEcomLeaveRecServiceImpl.deleteLeaveRecordsByStarterTeacherId(rec);
			// 获取学生信息
			WtrjStudent student = wtrjStudentServiceImpl.selectByPrimaryKey(rec.getStudentId());
			// 删除一卡通请假数据
			deleteEsb(student.getStudentNo());
			if (result > 0) {
				logger.info("教师删除请假记录成功！");
				ret.setCode(Constant.RetCode.SUCCESS);
			}
		} catch (Exception e) {
			logger.error("教师删除请假记录失败！" + e);
			ret.setCode(Constant.RetCode.ERROR);
		}

		return ret;
	}

	/**
	 * 根据教师id查询发起的请假记录
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("starterRecords")
	public List<WtrjEcomLeaveRec> findLeaveRecordsByStarter() {
		ShiroUser currentUser = getCurrentUser();
		List<WtrjEcomLeaveRec> records = wtrjEcomLeaveRecServiceImpl
				.findLeaveRecordsByStarterTeahcerId(currentUser.getUserId());
		for (WtrjEcomLeaveRec item : records) {
			item.setStartTimeStr(DateUtil.dateTodateStr(item.getStartTime(), DateUtil.DATAFORMAT_LOCAL_STR));
			item.setEndTimeStr(DateUtil.dateTodateStr(item.getEndTime(), DateUtil.DATAFORMAT_LOCAL_STR));
		}
		return records;
	}

	/**
	 * 根据教师id查询确认的请假记录
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("confirmRecords")
	public List<WtrjEcomLeaveRec> findLeaveRecordsByConfirm() {
		ShiroUser currentUser = getCurrentUser();
		List<WtrjEcomLeaveRec> records = null;
		try {
			records = wtrjEcomLeaveRecServiceImpl.findLeaveRecordsByConfirmTeahcerId(currentUser.getUserId());
			for (WtrjEcomLeaveRec item : records) {
				item.setStartTimeStr(DateUtil.dateTodateStr(item.getStartTime(), DateUtil.DATAFORMAT_LOCAL_STR));
				item.setEndTimeStr(DateUtil.dateTodateStr(item.getEndTime(), DateUtil.DATAFORMAT_LOCAL_STR));
			}
		} catch (Exception e) {
			logger.error("查询教师确认请假记录失败" + e);
		}

		return records;
	}

	@RequestMapping("/detail")
	public ModelAndView toLeaveDetail(@RequestParam String id) {
		ModelAndView model = new ModelAndView("leave/leaveDetail");
		WtrjEcomLeaveRec leaveRec = wtrjEcomLeaveRecServiceImpl.findLeaveRecById(id);
		model.addObject("leave", leaveRec);
		String startTime = DateUtil.dateTodateStr(leaveRec.getStartTime(), DateUtil.DATAFORMAT_LOCAL_STR);
		String endTime = DateUtil.dateTodateStr(leaveRec.getEndTime(), DateUtil.DATAFORMAT_LOCAL_STR);
		// 01-事假 02-病假，03-其他
		if ("01".equals(leaveRec.getType())) {
			model.addObject("type", "事假");
		} else if ("02".equals(leaveRec.getType())) {
			model.addObject("type", "病假");
		} else {
			model.addObject("type", "其他");
		}
		model.addObject("startTime", startTime);
		model.addObject("endTime", endTime);
		return model;
	}

	@RequestMapping("students")
	@ResponseBody
	public List<WtrjStudent> findStudents() {
		List<WtrjStudent> students = null;

		ShiroUser teacher = getCurrentUser();
		if (teacher != null && teacher.getUserId() != null && teacher.getUserId() != 0) {
			students = wtrjStudentServiceImpl.selectStudentsByTeacherId(teacher.getUserId());
		}
		return students;
	}

	/**
	 * 请假同步一卡通
	 * 
	 * @return
	 * @throws DataSysException
	 */
	private void updateEsb(Date startTime, Date endTime, String studentNo) throws DataSysException {
		// 数据同步到一卡通
		String start = DateUtil.dateTodateStr(startTime, DateUtil.DATAFORMAT_FULL_STR);
		String end = DateUtil.dateTodateStr(endTime, DateUtil.DATAFORMAT_FULL_STR);
		JsonObject json = new JsonObject();
		json.addProperty("no", studentNo);
		json.addProperty("start", start);
		json.addProperty("end", end);
		logger.info("同步一卡通数据开始！");
		String token = DataSynUtil.getToken(esbBaseUrl, ecomAppid, ecomSecret);
		JsonObject msg = DataSynUtil.updateLeave(esbBaseUrl, token, json);
		if (!("0".equals(msg.get("errcode").getAsString()))) {
			throw new DataSysException();
		} else {
			logger.info("数据同步到一卡通成功");
		}
	}
	/**
	 * 删除一卡通请假数据
	 * @param studentNo 
	 * @throws Exception
	 */
	private void deleteEsb(String studentNo) throws Exception {
		JsonObject json = new JsonObject();
		json.addProperty("no", studentNo);
		logger.info("删除一卡通请假数据开始！no:"+studentNo);
		String token = DataSynUtil.getToken(esbBaseUrl, ecomAppid, ecomSecret);
		JsonObject msg = DataSynUtil.deleteLeave(esbBaseUrl, token, json);
		if(!("0".equals(msg.get("errcode").getAsString()))) {
			throw new Exception();
		}else {
			logger.info("删除一卡通请假数据成功！"+msg);
		}
	}

	/**
	 * 发送请假通知
	 */
	private void sendWxMessage(Integer stuId, Integer schoolCode, String msgCode) {
		ShiroUser currentUser = getCurrentUser();
		if (schoolCode >= 1 && schoolCode <= 5) {
			schoolCode = 1;
		} else if (schoolCode >= 6 && schoolCode <= 9) {
			schoolCode = 6;
		} else if (schoolCode >= 10 && schoolCode <= 13) {
			schoolCode = 10;
		} else if (schoolCode >= 14 && schoolCode <= 17) {
			schoolCode = 14;
		} else if (schoolCode >= 18 && schoolCode <= 21) {
			schoolCode = 18;
		} else if (schoolCode >= 22 && schoolCode <= 25) {
			schoolCode = 22;
		}
		// 查询配置信息
		WtrjEcomSchoolAppid schoolAppid = schoolAppidServiceImpl.searchByShoolCode(String.valueOf(schoolCode),
				"message");
		// 获取学生id对应的家长信息
		List<WtrjParent> parents = wtrjEcomParentServiceImpl.findParentsByStudentId(stuId);
		// 获取学生信息
		WtrjStudent student = wtrjStudentServiceImpl.selectByPrimaryKey(stuId);
		try {
			// ==================请假消息推送至家长=====================
			String content = "家长，您好，您的小孩【" + student.getName()
					+ "】已向班主任老师提出了请假申请，请您到社区微信号下的【请假】版块查看请假详情，如您对本次请假有疑问，请自行联系班主任进行确认。(班主任电话：" + currentUser.getMobile()
					+ ")";
			logger.info("开始向家长推送请假通知:" + content);
			for (WtrjParent parent : parents) {
				String messageId = UUID.randomUUID().toString();
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("sendAppid", schoolAppid.getCorpId());
				jsonObject.addProperty("agentId", schoolAppid.getAgentId());
				jsonObject.addProperty("messageId", messageId);
				jsonObject.addProperty("sendSecret", schoolAppid.getAppSecret());
				jsonObject.addProperty("content", "【维睿教育社区】" + content);
				jsonObject.addProperty("toUser", parent.getPhone());
				// 发送微信
				JsonObject result = HttpRequestUtils.httpPost(sendWxUrl, jsonObject);
				WtrjRptMsg param = new WtrjRptMsg();
				if (result != null && result.get("errorcode") != null
						&& "0".equals(result.get("errorcode").getAsString())) {
					logger.info("发送微信给家长：" + parent.getPhone() + "成功！");
					param.setSuccessFlag("2");
				} else {
					logger.error("发送微信给家长：" + parent.getPhone() + "失败！");
					param.setSuccessFlag("3");
				}
				param.setContent(content);
				param.setMsgCode(msgCode);
				param.setMsgType("1");
				param.setType("1");
				param.setSendTime(Calendar.getInstance().getTime());
				param.setToUser(parent.getPhone());
				param.setId(messageId);
				smsService.saveSmsInfo(param);
			}
		} catch (Exception e) {
			logger.error("微信消息发送失败！" + e);
			throw e;
		}
	}
}
