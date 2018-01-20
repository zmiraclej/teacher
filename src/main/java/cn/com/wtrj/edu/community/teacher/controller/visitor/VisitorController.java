package cn.com.wtrj.edu.community.teacher.controller.visitor;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

import cn.com.wtrj.edu.community.exception.DataSysException;
import cn.com.wtrj.edu.community.exception.GenerateQcodeException;
import cn.com.wtrj.edu.community.exception.SaveToEcomDatabaseException;
import cn.com.wtrj.edu.community.request.formBean.ParentVisitorForm;
import cn.com.wtrj.edu.community.request.formBean.StrangerVisitForm;
import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.util.DataSynUtil;
import cn.com.wtrj.edu.community.util.DateUtil;
import cn.com.wtrj.edu.community.util.MD5Util;
import cn.com.wtrj.edu.community.util.QRCodeUtil;
import cn.com.wtrj.edu.community.util.RandomCodeUtil;
import cn.com.wtrj.edu.community.util.RefuseFormRepeatCommitUtil;
import cn.com.wtrj.edu.community.util.TokenProccessor;
import cn.com.wtrj.edu.community.util.WeixinUtil;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomVisitor;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjParent;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjStudent;
import cn.com.wtrj.jx.web.portal.service.IWtrjStudentService;
import cn.com.wtrj.jx.web.portal.service.parent.IWtrjEcomParentService;
import cn.com.wtrj.jx.web.portal.service.visitor.IVisitorService;
import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.bean.WxCpMessage;
import me.chanjar.weixin.cp.bean.article.NewArticle;

@Controller
@RequestMapping("/visitor")
public class VisitorController extends BaseController {
	private static Logger logger = Logger.getLogger(VisitorController.class);

	private static final String VISIT_TYPE_PARENT = "01";
	private static final String VISIT_TYPE_STRANGER = "02";
	private static final String VISIT_DEL_FLAG_TRUE = "1";
	private static final String VISIT_DEL_FLAG_FALSE = "0";

	@Value("${qcode_path}")
	private String qcodePath;
	@Value("${img_server}")
	private String imgServer;
	@Value("${send_to_appid}")
	private String sendAppid;
	@Value("${send_to_secret}")
	private String sendSecret;
	@Value("${send_to_agent_id}")
	private Integer agentId;
	@Value("${access_path}")
	private String accessPath;
	@Value("${esb_BaseUrl}")
	private String esbBaseUrl;
	@Value("${ecom_appid}")
	private String ecomAppid;
	@Value("${ecom_secret}")
	private String ecomSecret;
	@Value("${news_msg_url}")
	private String newsUrl;
	@Value("${redirect_url}")
	private String redirectUrl;

	@Autowired
	private IVisitorService visitorServiceImpl;

	@Autowired
	private IWtrjStudentService wtrjStudentServiceImpl;

	@Autowired
	private IWtrjEcomParentService wtrjEcomParentServiceImpl;

	public static void main(String[] args) {
		/*
		 * String newsUrl =
		 * "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=URL&response_type=code&scope=SCOPE&agentid=AGENTID&state=STATE#wechat_redirect";
		 * String sendAppid = "wx1345f3e70f353d68"; String redirectUrl=
		 * "http%3a%2f%2freport.cdwtrj.com%2fwtrj-ecom-teacher%2fvisitor%2fqcode";
		 * String agentId = "17"; newsUrl = newsUrl.replace("APPID",
		 * sendAppid).replaceAll("URL", redirectUrl).replaceAll("AGENTID", agentId);
		 * 
		 * System.out.println(newsUrl);
		 */
/*
		for (long i = 0; i < 100000000000000000L; i++) {
			long time = new Date().getTime();
			try {
				Thread.sleep(1);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println(Integer.toHexString((int)(time)));;
		}*/
	}


	// 学生家长
	@RequestMapping("/eldership")
	public ModelAndView saveParentVisitItem(ParentVisitorForm parVisitorForm, HttpServletRequest request) {
		ModelAndView model = null;
		// 防止表单重复提交
		boolean repeat = RefuseFormRepeatCommitUtil.isRepeatSubmit(request);// 判断用户是否是重复提交
		if (repeat == true) {
			model = new ModelAndView("visitor/visitorList");
			return model;
		}
		request.getSession().removeAttribute("token");// 移除session中的token

		try {
			// 处理具体的业务逻辑
			// 获取教师信息
			ShiroUser user = getCurrentUser();
			// 获取来访家长信息
			WtrjParent parentInfo = wtrjEcomParentServiceImpl.findParentInfoByName(parVisitorForm.getParent());

			// 生成唯一卡号
			String cardNo = RandomCodeUtil.getRandomCode(8);
			
			String qcodeName = cardNo + ".jpg";
			// 生成二维码
			String text = cardNo + QRCodeUtil.SUF_CODE;
			String qtext = QRCodeUtil.PRE_CODE + text.substring(0, text.length() - 16) + MD5Util.MD5(text, true, true);
			try {
				logger.info("开始生成二维码");
				QRCodeUtil.encode(qtext, "", qcodePath + qcodeName, true);
			} catch (Exception e) {
				throw new GenerateQcodeException();
			}

			String path = qcodePath + qcodeName;

			System.out.println("=============================");
			System.out.println("文件路径：" + path);
			System.out.println("=============================");

			// 数据存入社区库
			WtrjEcomVisitor visitItem = new WtrjEcomVisitor();
			visitItem.setTeacherId(user.getUserId());
			visitItem.setVisitType(VisitorController.VISIT_TYPE_PARENT);
			visitItem.setVisitorName(parVisitorForm.getParent());
			visitItem.setParentId(parentInfo.getId());
			visitItem.setVisitorPhone(parentInfo.getPhone());
			visitItem.setCardNo(cardNo);
			visitItem.setCarNum(parVisitorForm.getCarNum());
			visitItem.setVisitTime(parVisitorForm.getVisitTime());
			visitItem.setLeaveTime(parVisitorForm.getLeaveTime());
			visitItem.setDelFlg(VisitorController.VISIT_DEL_FLAG_FALSE);
			visitItem.setCreateTime(new Date(System.currentTimeMillis()));
			visitItem.setQrPicUrl(path);
			visitItem.setRemark(parVisitorForm.getVisitRemark());

			// 数据存入社区库
			logger.info("访客记录信息开始存入社区数据库：" + visitItem.toString());
			try {
				visitorServiceImpl.saveVisitItem(visitItem);
			} catch (Exception e) {
				throw new SaveToEcomDatabaseException();
			}
			logger.info("访客记录信息存入社区数据库成功：" + visitItem.toString());

			// 字符创--日期转换处理
			Date visitStart = DateUtil.dateStrToDate(visitItem.getVisitTime(), DateUtil.DATAFORMAT_LOCAL_STR);
			Date visitEnd = DateUtil.dateStrToDate(visitItem.getLeaveTime(), DateUtil.DATAFORMAT_LOCAL_STR);
			String start = DateUtil.dateTodateStr(visitStart, DateUtil.DATAFORMAT_FULL_STR);
			String end = DateUtil.dateTodateStr(visitEnd, DateUtil.DATAFORMAT_FULL_STR);

			// 数据同步到一卡通
			JsonObject tempJson = new JsonObject();
			tempJson.addProperty("no", visitItem.getVisitorPhone());
			JsonObject json = new JsonObject();

			json.addProperty("no", visitItem.getVisitorPhone());
			json.addProperty("type", visitItem.getVisitType());
			json.addProperty("cardNo", cardNo);
			json.addProperty("name", visitItem.getVisitorName());
			json.addProperty("remark", visitItem.getRemark());
			json.addProperty("start", start);
			json.addProperty("end", end);

			logger.info("数据开始同步到一卡通");
			String token = DataSynUtil.getToken(esbBaseUrl, ecomAppid, ecomSecret);
			DataSynUtil.deleteVisit(esbBaseUrl, token, tempJson);
			JsonObject msg = DataSynUtil.insertVisit(esbBaseUrl, token, json);
			if (!("0".equals(msg.get("errcode").getAsString()))) {
				throw new DataSysException();
			} else {
				logger.info("数据同步到一卡通成功");
			}

			// 将二维码发送给家长
			WxCpService wxCpService = WeixinUtil.getWxCpService(sendAppid, sendSecret);

			// 图片访问路径
			String imgUrl = imgServer + accessPath + qcodeName;
			System.out.println("============================");
			System.out.println("图片路径：" + imgUrl);
			System.out.println("============================");

			// 图文消息路径
			String newsPath = newsUrl.replace("APPID", sendAppid).replaceAll("URL", redirectUrl).replaceAll("AGENTID",
					agentId + "");
			System.out.println("===================================");
			System.out.println(newsPath);
			System.out.println("===================================");

			NewArticle article = new NewArticle();
			article.setPicUrl(imgUrl);
			article.setTitle("获取二维码凭证");
			article.setUrl(newsPath);
			WxCpMessage newsMessage = WxCpMessage.NEWS().agentId(agentId).addArticle(article)
					.toUser(parentInfo.getPhone()).build();
			wxCpService.messageSend(newsMessage);

			/*
			 * String mediaId = WeixinUtil.uploadMedia(wxCpService.getAccessToken(),
			 * "image", qcodePath); WxCpMessage wxTextMessage =
			 * WxCpMessage.TEXT().agentId(agentId).toUser(user.getMobile())
			 * .content("访客登记成功，请将以下二维码发送给来访者，供其进出校门使用").build(); WxCpMessage wxImageMessage
			 * = WxCpMessage.IMAGE().agentId(agentId).toUser(user.getMobile()).mediaId(
			 * mediaId) .build(); wxCpService.messageSend(wxTextMessage);
			 * wxCpService.messageSend(wxImageMessage);
			 */
			logger.info("发送二维码给当前用户：{" + user.getName() + ":" + user.getMobile() + "}");

			model = new ModelAndView("visitor/visitorDetail");
			model.addObject("qcodeNum", cardNo + ".jpg");
			model.addObject("visit", visitItem);
		} catch (SaveToEcomDatabaseException e) {
			logger.error("来访信息保存至社区数据库失败" + e);
		} catch (GenerateQcodeException e) {
			logger.error("生成二维码失败" + e);
		} catch (DataSysException e) {
			logger.error("数据同步到一卡通失败" + e);
		} catch (WxErrorException e) {
			logger.error("二维码推送失败" + e);
		} catch (Exception e) {
			logger.error("来访信息登记失败" + e);
		}

		return model;
	}

	@RequestMapping("/qcode")
	public String toQcode() {
		return "visitor/qcode";
	}

	// 校外访客
	@RequestMapping("/stranger")
	public ModelAndView saveStrangerVisitItem(StrangerVisitForm strVisitor, HttpServletRequest request) {
		ModelAndView model = null;
		// 防止表单重复提交
		boolean repeat = RefuseFormRepeatCommitUtil.isRepeatSubmit(request);// 判断用户是否是重复提交
		if (repeat == true) {
			model = new ModelAndView("visitor/visitorList");
			return model;
		}
		request.getSession().removeAttribute("token");// 移除session中的token

		// 处理具体的业务逻辑
		// 获取被访者信息
		try {
			ShiroUser user = getCurrentUser();
			logger.info("获取当前用户信息:" + user.toString());

			// 生成唯一卡号
			String cardNo = RandomCodeUtil.getRandomCode(8);
			String qcodeName = cardNo + ".jpg";
			logger.info("生成临时卡号：" + cardNo);
			// 生成二维码
			String text = cardNo + QRCodeUtil.SUF_CODE;
			String qtext = QRCodeUtil.PRE_CODE + text.substring(0, text.length() - 16) + MD5Util.MD5(text, true, true);
			try {
				// 生成二维码并保存到指定盘符(以卡号命名)
				logger.info("开始生成二维码");
				QRCodeUtil.encode(qtext, "", qcodePath + qcodeName, true);
			} catch (Exception e) {
				throw new GenerateQcodeException();
			}

			String path = qcodePath + qcodeName;

			System.out.println("======================================");
			System.out.println(qcodePath);
			System.out.println("======================================");

			// 封装实体
			WtrjEcomVisitor visitItem = new WtrjEcomVisitor();
			visitItem.setTeacherId(user.getUserId());
			visitItem.setVisitType(VisitorController.VISIT_TYPE_STRANGER);
			visitItem.setVisitorName(strVisitor.getVisitorName());
			visitItem.setVisitorPhone(strVisitor.getPhone());
			visitItem.setVisitorIdCard(strVisitor.getCardNo());
			visitItem.setCarNum(strVisitor.getStrCarNum());
			visitItem.setRemark(strVisitor.getStrVisitRemark());
			visitItem.setVisitTime(strVisitor.getStrVisitTime());
			visitItem.setLeaveTime(strVisitor.getStrLeaveTime());
			visitItem.setCardNo(cardNo);
			visitItem.setDelFlg(VisitorController.VISIT_DEL_FLAG_FALSE);
			visitItem.setCreateTime(new Date(System.currentTimeMillis()));
			visitItem.setQrPicUrl(path);
			// 数据存入社区库
			logger.info("访客记录信息开始存入社区数据库：" + visitItem.toString());
			try {
				visitorServiceImpl.saveVisitItem(visitItem);
			} catch (Exception e) {
				throw new SaveToEcomDatabaseException();
			}
			logger.info("访客记录信息存入社区数据库成功：" + visitItem.toString());

			// 字符创--日期转换处理
			Date visitStart = DateUtil.dateStrToDate(visitItem.getVisitTime(), DateUtil.DATAFORMAT_LOCAL_STR);
			Date visitEnd = DateUtil.dateStrToDate(visitItem.getLeaveTime(), DateUtil.DATAFORMAT_LOCAL_STR);
			String start = DateUtil.dateTodateStr(visitStart, DateUtil.DATAFORMAT_FULL_STR);
			String end = DateUtil.dateTodateStr(visitEnd, DateUtil.DATAFORMAT_FULL_STR);
			// 数据同步到一卡通
			JsonObject tempJson = new JsonObject();
			tempJson.addProperty("no", visitItem.getVisitorPhone());
			JsonObject json = new JsonObject();

			json.addProperty("no", visitItem.getVisitorPhone());
			json.addProperty("type", visitItem.getVisitType());
			json.addProperty("cardNo", cardNo);
			json.addProperty("name", visitItem.getVisitorName());
			json.addProperty("remark", visitItem.getRemark());
			json.addProperty("start", start);
			json.addProperty("end", end);

			logger.info("数据开始同步到一卡通");
			String token = DataSynUtil.getToken(esbBaseUrl, ecomAppid, ecomSecret);
			DataSynUtil.deleteVisit(esbBaseUrl, token, tempJson);
			JsonObject msg = DataSynUtil.insertVisit(esbBaseUrl, token, json);
			if (!("0".equals(msg.get("errcode").getAsString()))) {
				throw new DataSysException();
			} else {
				logger.info("数据同步到一卡通成功");
			}

			// 将二维码发送给邀约者，并通知邀约者将该二维码转发给来访者
			String imgUrl = imgServer + accessPath + qcodeName;

			System.out.println("==========================");
			System.out.println(imgUrl);
			System.out.println("==========================");

			// 图文消息路径
			String newsPath = newsUrl.replace("APPID", sendAppid).replaceAll("URL", redirectUrl).replaceAll("AGENTID",
					agentId + "");
			System.out.println("===================================");
			System.out.println(newsPath);
			System.out.println("===================================");

			WxCpService wxCpService = WeixinUtil.getWxCpService(sendAppid, sendSecret);
			NewArticle article = new NewArticle();
			article.setPicUrl(imgUrl);
			article.setTitle("获取二维码凭证");
			article.setUrl(newsPath);
			WxCpMessage newsMessage = WxCpMessage.NEWS().agentId(agentId).addArticle(article).toUser("15723278648")
					.build();
			wxCpService.messageSend(newsMessage);

			/*
			 * String mediaId = WeixinUtil.uploadMedia(wxCpService.getAccessToken(),
			 * "image", qcodePath); WxCpMessage wxTextMessage =
			 * WxCpMessage.TEXT().agentId(agentId).toUser(user.getMobile())
			 * .content("访客登记成功，请将以下二维码发送给来访者，供其进出校门使用").build(); WxCpMessage wxImageMessage
			 * = WxCpMessage.IMAGE().agentId(agentId).toUser(user.getMobile()).mediaId(
			 * mediaId) .build(); wxCpService.messageSend(wxTextMessage);
			 * wxCpService.messageSend(wxImageMessage);
			 */

			logger.info("发送二维码给当前用户：{" + user.getName() + ":" + user.getMobile() + "}");

			model = new ModelAndView("visitor/visitorDetail");
			model.addObject("qcodeNum", qcodeName);
			model.addObject("visit", visitItem);
		} catch (SaveToEcomDatabaseException e) {
			logger.error("来访信息保存至社区数据库失败" + e);
		} catch (GenerateQcodeException e) {
			logger.error("生成二维码失败" + e);
		} catch (DataSysException e) {
			logger.error("数据同步到一卡通失败" + e);
		} catch (WxErrorException e) {
			logger.error("二维码推送失败" + e);
		} catch (Exception e) {
			logger.error("来访信息登记失败" + e);
		}

		return model;
	}

	// 查询来访记录
	@RequestMapping("/info")
	@ResponseBody
	public List<WtrjEcomVisitor> toVisitorList() {
		ShiroUser currentUser = getCurrentUser();
		return visitorServiceImpl.findVisitorsByTeacherId(currentUser.getUserId());
	}

	@RequestMapping("/form")
	public String toVisitorForm(HttpServletRequest request) {
		request.getSession().setAttribute("token", TokenProccessor.getInstance().makeToken()); // 在服务器使用session保存token(令牌)
		return "visitor/visitorIndex";
	}

	@RequestMapping("/detail")
	public ModelAndView toVisitorDetail(@RequestParam Integer id) {
		ModelAndView model = new ModelAndView("visitor/visitorDetail");
		WtrjEcomVisitor visitor = visitorServiceImpl.findVisitorById(id);
		model.addObject("visit", visitor);
		return model;
	}

	// 获取当前教师关联的学生信息
	@RequestMapping("list/students")
	@ResponseBody
	public List<WtrjStudent> getStudents(@RequestParam(value = "param", defaultValue = "No Records") String param) {
		List<WtrjStudent> students = null;
		ShiroUser teacher = getCurrentUser();

		if (teacher != null && teacher.getUserId() != null && teacher.getUserId() != 0) {
			students = wtrjStudentServiceImpl.findStudentsByTeacherIdAndParam(teacher.getUserId(), param);
		}
		return students;
	}

	@RequestMapping("list/parents")
	@ResponseBody
	public List<WtrjParent> getParents(
			@RequestParam(value = "studentName", defaultValue = "No Records") String studentName) {
		List<WtrjParent> parents = wtrjEcomParentServiceImpl.findParentsByStudentName(studentName);
		return parents;
	}
}
