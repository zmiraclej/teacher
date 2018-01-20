package cn.com.wtrj.edu.community.teacher.controller.notice;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.base.Strings;
import com.google.gson.JsonObject;

import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.response.ClassInfo;
import cn.com.wtrj.edu.community.response.GradeInfo;
import cn.com.wtrj.edu.community.response.NoticeParentInfo;
import cn.com.wtrj.edu.community.response.NoticeParentSelGradeInfo;
import cn.com.wtrj.edu.community.teacher.bean.Sms;
import cn.com.wtrj.edu.community.teacher.common.Constant;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.teacher.job.SmsJob;
import cn.com.wtrj.edu.community.teacher.job.WxJob;
import cn.com.wtrj.edu.community.teacher.request.NoticeAddParam;
import cn.com.wtrj.edu.community.teacher.request.NoticeClassSelectParam;
import cn.com.wtrj.edu.community.teacher.request.NoticeGradeSelectParam;
import cn.com.wtrj.edu.community.teacher.request.ParentSelectParam;
import cn.com.wtrj.edu.community.teacher.response.Notice;
import cn.com.wtrj.edu.community.teacher.response.NoticeStatus;
import cn.com.wtrj.edu.community.teacher.response.ParentNotice;
import cn.com.wtrj.edu.community.teacher.response.ParentNoticeStatus;
import cn.com.wtrj.edu.community.teacher.response.TeacherNotice;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomNotice;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtNoticeSendStatus;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtParentNoticeSendStatus;
import cn.com.wtrj.jx.web.portal.service.dto.notice.EcomPermisson;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeClassKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeGradeKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeParentKey;
import cn.com.wtrj.jx.web.portal.service.impl.SmsService;
import cn.com.wtrj.jx.web.portal.service.notice.IEcomNoticeService;
import cn.com.wtrj.jx.web.portal.service.notice.IEcomPermissionService;
import me.chanjar.weixin.common.exception.WxErrorException;

@Controller
@RequestMapping("/notice")
public class NoticeController extends BaseController {
	private static Logger logger = Logger.getLogger(NoticeController.class);

	private static final String PARENT_AUTH = "parentAuth";

	private static final String[] CLASS_NAMES = { "一班", "二班", "三班", "四班", "五班", "六班", "七班", "八班", "九班", "十班", "十一班",
			"十二班" };

	@Autowired
	IEcomNoticeService noticeService;

	@Autowired
	IEcomPermissionService parentAuthService;

	@Value("${send_to_appid_beicheng}")
	private String sendAppidBeicheng;
	@Value("${send_to_secret_beicheng}")
	private String sendSecretBeicheng;
	@Value("${send_to_agent_id_beicheng}")
	private Integer agentIdBeicheng;

	@Value("${send_to_appid_dazhou}")
	private String sendAppidDazhou;
	@Value("${send_to_secret_dazhou}")
	private String sendSecretDazhou;
	@Value("${send_to_agent_id_dazhou}")
	private Integer agentIdDazhou;

	@Value("${send_to_appid_jinjiang}")
	private String sendAppidJinjiang;
	@Value("${send_to_secret_jinjiang}")
	private String sendSecretJinjiang;
	@Value("${send_to_agent_id_jinjiang}")
	private Integer agentIdJinjiang;

	@Value("${send_to_appid_pixian}")
	private String sendAppidPixian;
	@Value("${send_to_secret_pixian}")
	private String sendSecretPixian;
	@Value("${send_to_agent_id_pixian}")
	private Integer agentIdPixian;

	@Value("${send_to_appid_chenghua}")
	private String sendAppidChenghua;
	@Value("${send_to_secret_chenghua}")
	private String sendSecretChenghua;
	@Value("${send_to_agent_id_chenghua}")
	private Integer agentIdChenghua;

	@Value("${notice_default_pic_url}")
	private String noticeDefaultPic;

	@Autowired
	private SmsService smsService;

	@Value("${sms_wx_send_api}")
	private String sendWxUrl;

	@Value("${sms_shortmessage_send_api}")
	private String sendShortMsgUrl;

	/**
	 * 短信发送开关
	 */
	@Value("${sms_send_flag}")
	private Boolean smsSendFlag;

	/**
	 * 线程池的管理工具 调度型线程池
	 */
	private final static ScheduledExecutorService msScheduler = Executors.newScheduledThreadPool(10);

	/**
	 * 上传图片
	 * 
	 * @param file
	 * @param request
	 * @param response
	 * @throws Exception
	 */

	@Value("${upload.notice.path}")
	String classCirclePath;
	@Value("${upload.path.base}")
	String uploadPathBase;
	@Value("${upload.url}")
	String uploadUrl;

	/**
	 * 跳转到通知，跳转到/stuIns/stuInsIndex.jsp
	 * 
	 * @return
	 */
	@RequestMapping("/index")
	public String notice(Map<String, Object> model) {
		logger.info("跳转到通知页面 开始");
		try {
			super.clearPermission();
			
			List<WtrjEcomNotice> notices = noticeService.searhNoticeByTeacherId(this.getCurrentUser().getUserId());

			Map<String, List<Notice>> map = new HashMap<String, List<Notice>>();

			for (WtrjEcomNotice record : notices) {
				Calendar publishTime = Calendar.getInstance();
				publishTime.setTime(record.getPulishTime());
				Integer month = publishTime.get(Calendar.MONTH) + 1;
				Integer day = publishTime.get(Calendar.DAY_OF_MONTH);
				Integer hour = publishTime.get(Calendar.HOUR_OF_DAY);
				Integer minute = publishTime.get(Calendar.MINUTE);

				List<Notice> pn = map.get(String.valueOf(month));
				if (pn == null) {
					pn = new ArrayList<Notice>();
				}

				Notice p = new Notice();
				p.setTitle(record.getTitle());
				p.setPublishTime(month + "月" + day + "日 " + hour + ":" + minute);
				p.setNoticeNo(record.getNoticeNo());

				pn.add(p);

				map.put(String.valueOf(month), pn);
			}

			List<ParentNotice> pnList = new ArrayList<ParentNotice>();
			for (String key : map.keySet()) {
				ParentNotice pn = new ParentNotice();
				pn.setMonth(Integer.valueOf(key));
				pn.setNotices(map.get(key));

				pnList.add(pn);
			}

			Comparator<ParentNotice> pnt = new Comparator<ParentNotice>() {

				@Override
				public int compare(ParentNotice o1, ParentNotice o2) {
					if (o1.getMonth() < o2.getMonth()) {
						return 1;
					}
					if (o1.getMonth() > o2.getMonth()) {
						return -1;
					}
					return 0;
				}
			};
			Collections.sort(pnList, pnt);

			model.put("array", pnList);

			List<WtrjEcomNotice> teacherNotices = noticeService
					.searhTeacherNoticeByTeacherId(this.getCurrentUser().getUserId());

			Map<String, List<Notice>> teacherMap = new HashMap<String, List<Notice>>();

			for (WtrjEcomNotice record : teacherNotices) {
				Calendar publishTime = Calendar.getInstance();
				publishTime.setTime(record.getPulishTime());
				Integer month = publishTime.get(Calendar.MONTH) + 1;
				Integer day = publishTime.get(Calendar.DAY_OF_MONTH);
				Integer hour = publishTime.get(Calendar.HOUR_OF_DAY);
				Integer minute = publishTime.get(Calendar.MINUTE);

				List<Notice> pn = teacherMap.get(String.valueOf(month));
				if (pn == null) {
					pn = new ArrayList<Notice>();
				}

				Notice p = new Notice();
				int len = record.getContent().length() > 10 ? 10 : record.getContent().length();
				p.setTitle(record.getContent().substring(0, len) + "...");
				p.setPublishTime(month + "月" + day + "日 " + hour + ":" + minute);
				p.setNoticeNo(record.getNoticeNo());

				pn.add(p);

				teacherMap.put(String.valueOf(month), pn);
			}

			List<TeacherNotice> tnList = new ArrayList<TeacherNotice>();
			for (String key : teacherMap.keySet()) {
				TeacherNotice pn = new TeacherNotice();
				pn.setMonth(Integer.valueOf(key));
				pn.setNotices(teacherMap.get(key));

				tnList.add(pn);
			}

			Comparator<TeacherNotice> ct = new Comparator<TeacherNotice>() {

				@Override
				public int compare(TeacherNotice o1, TeacherNotice o2) {
					if (o1.getMonth() < o2.getMonth()) {
						return 1;
					}
					if (o1.getMonth() > o2.getMonth()) {
						return -1;
					}
					return 0;
				}
			};
			Collections.sort(tnList, ct);

			model.put("teacherArray", tnList);
		} catch (Exception e) {
			logger.error("跳转到通知页面 异常", e);
		}

		logger.info("跳转到通知页面 开始");
		return "notice/index";
	}

	@RequestMapping("/detail/{noticeNo}")
	public String toEcomNoticeDetail(@PathVariable("noticeNo") String noticeNo, Map<String, Object> model) {
		logger.info("跳转到通知明细页面 开始");
		WtrjEcomNotice dto = noticeService.searchNoticeDetailByNoticeNo(noticeNo);
		model.put("title", dto.getTitle());
		model.put("content", dto.getContent());

		Map<String, ParentNoticeStatus> statusMap = new HashMap<String, ParentNoticeStatus>();
		List<MtParentNoticeSendStatus> shortMsgs = noticeService.searchParentNoticeSendStatus(noticeNo);
		if (shortMsgs != null) {
			for (MtParentNoticeSendStatus sm : shortMsgs) {
				ParentNoticeStatus status = statusMap.get(sm.getMobile());
				if (status == null) {
					status = new ParentNoticeStatus();
					status.setStudentName(sm.getStudentName());
					status.setParentName(sm.getParentName());
					status.setMobile(sm.getMobile());
					status.setShortMsgStatus("未发送");
					status.setWxStatus("未发送");
				}

				String state = sm.getStatus();
				if ("2".equals(sm.getMsgType())) {
					switch (state) {
					case "2":
						status.setShortMsgStatus("发送中");
						break;
					case "3":
						status.setShortMsgStatus("失败");
						break;
					case "1":
						status.setShortMsgStatus("成功");
						break;

					default:
						status.setShortMsgStatus("未发送");
						break;
					}
				} else {
					switch (state) {
					case "2":
						status.setWxStatus("发送中");
						break;
					case "3":
						status.setWxStatus("失败");
						break;
					case "1":
						status.setWxStatus("成功");
						break;

					default:
						status.setWxStatus("未发送");
						break;
					}
				}

				statusMap.put(sm.getMobile(), status);
			}
		}

		List<ParentNoticeStatus> ns = new ArrayList<ParentNoticeStatus>();
		for (String key : statusMap.keySet()) {
			ns.add(statusMap.get(key));
		}

		model.put("sendDetails", ns);

		logger.info("跳转到通知明细页面 结束");
		return "notice/noticeDetail";
	}

	@RequestMapping("/toAddParentNotice")
	public String toAddNotice(Map<String, Object> model) {
		logger.info("跳转到家长通知追加页面");
		try {
			Object auth = SecurityUtils.getSubject().getSession().getAttribute(PARENT_AUTH);
			int selectedNum = 0;
			if (auth != null) {
				EcomPermisson per = (EcomPermisson) auth;
				Map<String, Boolean> map = per.getParentSelected();
				if (map != null) {
					for (String key : map.keySet()) {
						if (map.get(key) == null ? false : map.get(key)) {
							selectedNum = selectedNum + 1;
						}
					}
				}
			}

			model.put("selectedNum", selectedNum);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute("tempNoticeInfo");
			if (obj != null) {
				model.put("tempNoticeInfo", obj);
			}
		} catch (Exception e) {
			logger.error("跳转到教师通知追加页面 异常", e);
		}

		logger.info("跳转到教师通知追加页面");
		return "notice/addParentNotice";
	}

	@RequestMapping("/toParentGradeSelect")
	public String toParentGradeSelect(Map<String, Object> model) {
		logger.info("跳转到家长选择页面 开始");
		try {
			Map<String, List<GradeInfo>> map = new HashMap<String, List<GradeInfo>>();
			// ------------------做成页面显示用返回值----------------------------------
			List<NoticeParentSelGradeInfo> gradeInfos = new ArrayList<NoticeParentSelGradeInfo>();

			EcomPermisson permisson = this.getParentAuth();
			List<NoticeGradeKey> dtos = permisson.getOwnedGrades();
			if (dtos != null && dtos.size() > 0) {
				for (NoticeGradeKey dto : dtos) {
					List<GradeInfo> arry = map.get(dto.getSchoolCode());
					if (arry == null) {
						arry = new ArrayList<GradeInfo>();
						map.put(dto.getSchoolCode(), arry);
					}
					GradeInfo gi = new GradeInfo();
					gi.setSchoolCode(dto.getSchoolCode());
					gi.setStage(dto.getStage());
					gi.setGrade(dto.getGrade());
					gi.setDispayName(genGradeName(dto.getStage(), dto.getGrade()));
					gi.setGradeKeyNo(dto.getSchoolCode() + "_" + dto.getStage() + "_" + dto.getGrade());

					arry.add(gi);
				}

				for (String key : map.keySet()) {
					NoticeParentSelGradeInfo info = new NoticeParentSelGradeInfo();
					info.setSchoolCode(key);
					info.setGrades(map.get(key));
					info.setSchoolName(parentAuthService.getSchoolNameByCode(key));

					gradeInfos.add(info);
				}
			}

			model.put("array", gradeInfos);

			logger.info("跳转到家长选择页面 结束");
		} catch (Exception e) {
			logger.error("跳转到家长选择页面 异常", e);
		}

		return "notice/parentGradeSelect";
	}

	@RequestMapping("/toParentClassSelect")
	public String toParentClassSelect(@RequestParam(value = "schoolCode") String schoolCode,
			@RequestParam(value = "stage") Integer stage, @RequestParam(value = "grade") Integer grade,
			Map<String, Object> model) {
		logger.info("跳转到家长班级选择页面 开始");
		try {
			EcomPermisson permisson = this.getParentAuth();
			List<NoticeClassKey> dtos = permisson.getOwnedClasses();
			List<ClassInfo> classInfos = new ArrayList<ClassInfo>();
			for (NoticeClassKey dto : dtos) {
				if (dto.getSchoolCode().equals(schoolCode) && dto.getStage() == stage && dto.getGrade() == grade) {
					ClassInfo gi = new ClassInfo();
					gi.setSchoolCode(dto.getSchoolCode());
					gi.setStage(dto.getStage());
					gi.setGrade(dto.getGrade());
					gi.setDispayName(dto.getClassName());
					gi.setClassNo(dto.getClassNo());

					gi.setGradeNo(dto.getSchoolCode() + "_" + dto.getStage() + "_" + dto.getGrade());
					gi.setClassKeyNo(
							dto.getSchoolCode() + "_" + dto.getStage() + "_" + dto.getGrade() + "_" + dto.getClassNo());

					classInfos.add(gi);
				}

			}

			// 排序处理
			Comparator<ClassInfo> ct = new Comparator<ClassInfo>() {

				@Override
				public int compare(ClassInfo o1, ClassInfo o2) {
					if (o1.getClassNo() < o2.getClassNo()) {
						return -1;
					} else if (o1.getClassNo() > o2.getClassNo()) {
						return 1;
					}
					return 0;
				}
			};

			Collections.sort(classInfos, ct);

			model.put("array", classInfos);
		} catch (Exception e) {
			logger.error("跳转到家长班级选择页面 异常", e);
		}

		logger.info("跳转到家长班级选择页面 结束");
		return "notice/parentClassSelect";
	}

	@RequestMapping("/toParentSelect")
	public String toParentSelect(@RequestParam(value = "schoolCode") String schoolCode,
			@RequestParam(value = "stage") Integer stage, @RequestParam(value = "grade") Integer grade,
			@RequestParam(value = "classNo") Integer classNo, Map<String, Object> model) {
		logger.info("跳转到家长选择页面 开始");
		try {
			EcomPermisson permisson = this.getParentAuth();
			List<NoticeParentKey> dtos = permisson.getOwnedParents();
			List<NoticeParentInfo> classInfos = new ArrayList<NoticeParentInfo>();
			for (NoticeParentKey dto : dtos) {

				if (dto.getSchoolCode().equals(schoolCode) && dto.getStage() == stage && dto.getGrade() == grade
						&& dto.getClassNo() == classNo) {
					NoticeParentInfo gi = new NoticeParentInfo();
					gi.setSchoolCode(dto.getSchoolCode());
					gi.setStage(dto.getStage());
					gi.setGrade(dto.getGrade());
					gi.setClassNo(dto.getClassNo());
					gi.setParentName(StringUtils.isEmpty(dto.getParentName()) ? "家长" : dto.getParentName());
					gi.setParentPhone(dto.getParentPhone());
					gi.setParentKeyNo(dto.getParentKeyNo());
					gi.setStudentName(dto.getStudentName());

					Map<String, Boolean> selectedMap = permisson.getParentSelected();
					gi.setSelected(selectedMap == null ? false
							: (selectedMap.get(dto.getParentKeyNo()) == null ? false : true));

					classInfos.add(gi);
				}

			}

			model.put("array", classInfos);

			model.put("schoolCode", schoolCode);
			model.put("stage", stage);
			model.put("grade", grade);
		} catch (Exception e) {
			logger.error("跳转到家长选择页面 异常", e);
		}

		logger.info("跳转到家长选择页面 结束");
		return "notice/parentSelect";
	}

	/**
	 * 生成显示名称
	 * 
	 * @param schoolCode
	 * @param stage
	 * @param grade
	 * @return
	 */
	private String genGradeName(Integer stage, Integer grade) {
		StringBuilder name = new StringBuilder();
		switch (stage) {
		case 1:
			name.append("小学");
			break;
		case 2:
			name.append("初中");
			break;
		case 3:
			name.append("高中");
			break;
		case 4:
			name.append("国高");
			break;
		default:
			break;
		}

		switch (grade) {
		case 1:
			name.append("一年级");
			break;
		case 2:
			name.append("二年级");
			break;
		case 3:
			name.append("三年级");
			break;
		case 4:
			name.append("四年级");
			break;
		case 5:
			name.append("五年级");
			break;
		case 6:
			name.append("六年级");
			break;
		default:
			break;
		}
		return name.toString();
	}

	@RequestMapping(value = "/uploadPhoto")
	public void uploadPhoto(MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("通知附件上传开始");
		try {
			request.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			final String[] allowedExt = new String[] { "png", "psd", "bmp", "jpg", "jpeg", "gif", "txt", "doc", "docx",
					"mp3", "wma", "m4a", "exe", "zip", "rar", "pdf", "xls", "xlsx" };
			final String[] imagesExt = new String[] { "png", "psd", "bmp", "jpg", "jpeg", "gif" };
			response.setContentType("text/html;charset=utf-8");
			// 设置字符编码为UTF-8, 这样支持汉字显示
			response.setCharacterEncoding("UTF-8");

			/*
			 * String rootPath = request.getSession().getServletContext()
			 * .getRealPath("/");
			 */
			// String rootPath = "F://upload";
			String rootPath = classCirclePath;
			String fileName = file.getOriginalFilename();
			long size = file.getSize();
			if ("".equals(rootPath) || size == 0) {
				return;
			}

			// 得到去除路径的文件名
			String t_name = fileName.substring(fileName.lastIndexOf("//") + 1);
			// 得到文件的扩展名(无扩展名时将得到全名)
			String t_ext = t_name.substring(t_name.lastIndexOf(".") + 1);
			t_ext = t_ext.toLowerCase();
			// 拒绝接受规定文件格式之外的文件类型
			int allowFlag = 0;
			int allowedExtCount = allowedExt.length;
			for (; allowFlag < allowedExtCount; allowFlag++) {
				if (allowedExt[allowFlag].equals(t_ext))
					break;
			}
			if (allowFlag == allowedExtCount) {
				out.println("不支持的格式");
				return;
			}

			// 是不是图片
			int imageFlag = 0;
			int imageExtCount = imagesExt.length;
			boolean isImage = false;
			for (; imageFlag < imageExtCount; imageFlag++) {
				if (imagesExt[imageFlag].equals(t_ext)) {
					isImage = true;
					break;
				}
			}

			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);// 获取年份
			int month = cal.get(Calendar.MONTH) + 1;// 获取月份
			int day = cal.get(Calendar.DATE);// 获取日
			String uid = UUID.randomUUID().toString();
			String prefix = uid.replace("-", "");
			StringBuffer sb = new StringBuffer();
			sb.append("/");
			sb.append(year);
			sb.append("/");
			sb.append(month);
			sb.append("/");
			sb.append(day);
			sb.append("/");
			// 保存的最终文件完整路径,保存在web根目录下的upload目录下
			String filePath = sb.toString();

			File targetFile = new File(uploadPathBase + rootPath + filePath);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}
			// new File("D://imgs/photo1.jpg");
			targetFile = new File(uploadPathBase + rootPath + filePath + prefix + "." + t_ext);
			// 保存
			try {
				file.transferTo(targetFile);
				JsonObject resultJson = new JsonObject();
				resultJson.addProperty("error", 0);

				String newFilePath = filePath.replaceAll("\\\\", "/") + prefix + "." + t_ext;
				resultJson.addProperty("url", uploadUrl + classCirclePath + newFilePath);
				out.println(resultJson.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			logger.error("通知附件上传出现异常！", e);
		}

		logger.info("通知附件上传 结束");
	}

	/**
	 * 保存家长选择数据
	 * 
	 * @param parents
	 * @return
	 */
	@RequestMapping(value = "/saveParentSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveParentSelect(@RequestBody List<ParentSelectParam> parents) {
		logger.info("保存家长选择 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getParentAuth();
			Map<String, Boolean> map = p.getParentSelected();
			if (map == null) {
				map = new HashMap<String, Boolean>();
			}
			for (ParentSelectParam sp : parents) {
				map.put(sp.getParentKeyNo(), sp.getSelected());
			}
			p.setParentSelected(map);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存家长选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存家长选择 结束！");
		return ret;
	}

	@RequestMapping(value = "/saveParentGradeSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveParentGradeSelect(@RequestBody List<NoticeGradeSelectParam> grades) {
		logger.info("保存通知年级选择 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getParentAuth();
			Map<String, Boolean> map = p.getGradeSelected();
			if (map == null) {
				map = new HashMap<String, Boolean>();
			}
			for (NoticeGradeSelectParam sp : grades) {
				map.put(sp.getGradeKeyNo(), sp.getSelected());
			}

			p.setGradeSelected(map);

			// ------------更新班级状态------------------------
			List<NoticeClassKey> classKeys = p.getOwnedClasses();
			Map<String, Boolean> classSelectedMap = p.getClassSelected();
			if (classSelectedMap == null) {
				classSelectedMap = new HashMap<String, Boolean>();
			}

			for (NoticeGradeSelectParam grade : grades) {
				String[] keys = grade.getGradeKeyNo().split("_");

				for (NoticeClassKey noticeClassKey : classKeys) {
					if (keys.length > 2 && noticeClassKey.getSchoolCode().equals(keys[0])
							&& noticeClassKey.getStage() == Integer.valueOf(keys[1])
							&& noticeClassKey.getGrade() == Integer.valueOf(keys[2])) {
						classSelectedMap.put(noticeClassKey.getClassKeyNo(), grade.getSelected());
					}

				}
			}
			p.setClassSelected(classSelectedMap);

			// ------------更新家长状态------------------------
			List<NoticeParentKey> parentKeys = p.getOwnedParents();
			Map<String, Boolean> parentSelectedMap = p.getParentSelected();
			if (parentSelectedMap == null) {
				parentSelectedMap = new HashMap<String, Boolean>();
			}

			for (NoticeGradeSelectParam grade : grades) {
				String[] keys = grade.getGradeKeyNo().split("_");

				for (NoticeParentKey noticeParentKey : parentKeys) {
					if (keys.length > 2 && noticeParentKey.getSchoolCode().equals(keys[0])
							&& noticeParentKey.getStage() == Integer.valueOf(keys[1])
							&& noticeParentKey.getGrade() == Integer.valueOf(keys[2])) {
						parentSelectedMap.put(noticeParentKey.getParentKeyNo(), grade.getSelected());
					}

				}
			}
			p.setParentSelected(parentSelectedMap);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存通知年级选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存通知年级选择 结束！");
		return ret;
	}

	@RequestMapping(value = "/saveParentClassSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveParentClassSelect(@RequestBody List<NoticeClassSelectParam> grades) {
		logger.info("保存家长班级选择 开始！" + grades);

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getParentAuth();
			Map<String, Boolean> map = p.getClassSelected();
			if (map == null) {
				map = new HashMap<String, Boolean>();
			}
			for (NoticeClassSelectParam sp : grades) {
				map.put(sp.getClassKeyNo(), sp.getSelected());
			}

			p.setClassSelected(map);

			// ------------更新家长状态------------------------
			List<NoticeParentKey> parentKeys = p.getOwnedParents();
			Map<String, Boolean> parentSelectedMap = p.getParentSelected();
			if (parentSelectedMap == null) {
				parentSelectedMap = new HashMap<String, Boolean>();
			}

			for (NoticeClassSelectParam classInfo : grades) {
				String[] keys = classInfo.getClassKeyNo().split("_");

				for (NoticeParentKey noticeParentKey : parentKeys) {
					if (keys.length > 3 && noticeParentKey.getSchoolCode().equals(keys[0])
							&& noticeParentKey.getStage() == Integer.valueOf(keys[1])
							&& noticeParentKey.getGrade() == Integer.valueOf(keys[2])
							&& noticeParentKey.getClassNo() == Integer.valueOf(keys[3])) {
						parentSelectedMap.put(noticeParentKey.getParentKeyNo(), classInfo.getSelected());
					}

				}
			}
			p.setParentSelected(parentSelectedMap);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存家长班级选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存家长班级选择 结束！");
		return ret;
	}

	private void sendWx(String uid, String content, Map<String, List<String>> mobiles) throws WxErrorException {

		for (String key : mobiles.keySet()) {

			String sendAppid = "";
			Integer agentId = null;
			String sendSecret = "";

			Integer schoolCode = Integer.valueOf(key);
			if (schoolCode >= 1 && schoolCode <= 5) {
				sendAppid = this.sendAppidJinjiang;
				agentId = this.agentIdJinjiang;
				sendSecret = this.sendSecretJinjiang;
			} else if (schoolCode >= 6 && schoolCode <= 9) {
				sendAppid = this.sendAppidChenghua;
				agentId = this.agentIdChenghua;
				sendSecret = this.sendSecretChenghua;
			} else if (schoolCode >= 10 && schoolCode <= 13) {
				sendAppid = this.sendAppidPixian;
				agentId = this.agentIdPixian;
				sendSecret = this.sendSecretPixian;
			} else if (schoolCode >= 14 && schoolCode <= 17) {
				sendAppid = this.sendAppidBeicheng;
				agentId = this.agentIdBeicheng;
				sendSecret = this.sendSecretBeicheng;
			} else if (schoolCode >= 18 && schoolCode <= 21) {
				sendAppid = this.sendAppidDazhou;
				agentId = this.agentIdDazhou;
				sendSecret = this.sendSecretDazhou;
			} else if (schoolCode >= 22 && schoolCode <= 25) {
			}

			msScheduler.schedule(new WxJob(sendWxUrl, "1", sendAppid, sendSecret, agentId, content, uid, smsService,
					mobiles.get(key)), 1, TimeUnit.SECONDS);
		}

	}

	private void sendSms(String content, String msgCode, List<String> mobiles) {

		if (Strings.isNullOrEmpty(content))
			return;

		if (mobiles == null || mobiles.size() == 0)
			return;

		Sms sms = new Sms(sendShortMsgUrl, "2", "0", content, msgCode, mobiles);

		// 异步执行短信任务
		msScheduler.schedule(new SmsJob(sms, smsService), 1, TimeUnit.SECONDS);

	}

	@RequestMapping(value = "/saveNotice", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveNotice(@RequestBody NoticeAddParam param) {
		logger.info("保存通知 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			String content = editContent(param.getContent());

			WtrjEcomNotice record = new WtrjEcomNotice();
			record.setTitle(param.getTitle());
			record.setContent(param.getContent());
			record.setPulishTime(Calendar.getInstance().getTime());
			record.setTeacherId(this.getCurrentUser().getUserId());
			// 通知公告类型
			record.setType(Constant.NoticeType.NOTICE);
			// 通知单号
			UUID uid = UUID.randomUUID();
			record.setNoticeNo(uid.toString());

			StringBuilder sb = new StringBuilder();
			for (String file : param.getFiles()) {
				sb.append(file);
				sb.append(";");
			}
			if (sb.length() > 0) {
				record.setAttachFile(sb.substring(0, sb.length() - 1));
			}

			noticeService.saveNotice(record);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute(PARENT_AUTH);
			if (obj != null) {
				EcomPermisson permisson = (EcomPermisson) obj;
				Map<String, List<String>> ps = this.getSelectedParentFromPermisson(permisson);

				// 微信通知
				sendWx(uid.toString(), param.getContent(), ps);

				// 发送短信,判断是否开启短信发送
				if (smsSendFlag && param.isSendMessageFlg()) {
					for (String key : ps.keySet()) {
						sendSms(param.getContent(), uid.toString(), ps.get(key));
					}
				}
			}

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存通知 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存通知 结束！");
		return ret;
	}

	private String editContent(String content) {
		StringBuilder sb = new StringBuilder();
		sb.append("【维睿教育社区】");
		sb.append(content);

		return sb.toString();
	}

	/**
	 * 获取选中家长，发送通知用
	 * 
	 * @param permisson
	 * @return
	 */
	private Map<String, List<String>> getSelectedParentFromPermisson(EcomPermisson permisson) {
		Map<String, List<String>> map = new HashMap<String, List<String>>();

		Map<String, Boolean> ps = permisson.getParentSelected();

		List<NoticeParentKey> npks = permisson.getOwnedParents();
		if (npks != null && ps != null) {
			for (NoticeParentKey key : npks) {
				if (ps.get(key.getParentKeyNo()) == null ? false : ps.get(key.getParentKeyNo())) {
					String schoolCode = key.getSchoolCode();
					List<String> parents = map.get(schoolCode);
					if (parents == null) {
						parents = new ArrayList<>();
					}

					parents.add(key.getParentPhone());
					map.put(schoolCode, parents);
				}
			}
		}
		return map;
	}

	@RequestMapping(value = "/saveNoticeTemp", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveNoticeTemp(@RequestBody NoticeAddParam param) {
		logger.info("临时保存通知 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			SecurityUtils.getSubject().getSession().setAttribute("tempNoticeInfo", param);

			ret.setData("");
		} catch (Exception e) {
			logger.error("临时保存通知 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("临时保存通知 结束！");
		return ret;
	}

	/**
	 * 获取通知公告权限
	 * 
	 * @return
	 */
	private EcomPermisson getParentAuth() {
		Object obj = SecurityUtils.getSubject().getSession().getAttribute(PARENT_AUTH);
		if (obj == null) {
			EcomPermisson p = parentAuthService.searchTeacherPermisson(this.getCurrentUser().getUserId());

			SecurityUtils.getSubject().getSession().setAttribute(PARENT_AUTH, p);
			return p;
		} else {
			EcomPermisson p = (EcomPermisson) obj;
			if (p.getOwnedSchools() == null || p.getOwnedParents() == null) {
				obj = parentAuthService.searchTeacherPermisson(this.getCurrentUser().getUserId());
			}
		}

		return (EcomPermisson) obj;

	}

	// --------------------------------页面选择状态查询------------------------------------------------------
	@RequestMapping(value = "/searchParentSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchParentSelectStatus() {
		logger.info("获取家长选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson permisson = this.getParentAuth();
			Map<String, Boolean> map = new HashMap<String, Boolean>();
			if (permisson != null && permisson.getParentSelected() == null) {
				for (NoticeParentKey key : permisson.getOwnedParents()) {
					map.put(key.getParentKeyNo(), false);
				}
				permisson.setParentSelected(map);
			}
			ret.setData(permisson.getParentSelected());
		} catch (Exception e) {
			logger.error("获取家长选择状态 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取家长选择状态 结束！");
		return ret;
	}

	@RequestMapping(value = "/searchGradeSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchGradeSelectStatus() {
		logger.info("获取通知年级选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson permisson = this.getParentAuth();
			Map<String, Boolean> map = new HashMap<String, Boolean>();
			if (permisson != null && permisson.getGradeSelected() == null) {
				for (NoticeGradeKey key : permisson.getOwnedGrades()) {
					map.put(key.getGradeKeyNo(), false);
				}
				permisson.setGradeSelected(map);
			}
			ret.setData(permisson.getGradeSelected());
		} catch (Exception e) {
			logger.error("获取通知年级选择状态 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取通知年级选择状态 结束！");
		return ret;
	}

	@RequestMapping(value = "/searchClassSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchClassSelectStatus() {
		logger.info("获取通知班级选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson permisson = this.getParentAuth();
			Map<String, Boolean> map = new HashMap<String, Boolean>();
			if (permisson != null && permisson.getClassSelected() == null) {
				for (NoticeClassKey key : permisson.getOwnedClasses()) {
					map.put(key.getClassKeyNo(), false);
				}
				permisson.setClassSelected(map);
			}
			ret.setData(permisson.getClassSelected());
		} catch (Exception e) {
			logger.error("获取家长选择状态 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取班级选择状态 结束！");
		return ret;
	}
}
