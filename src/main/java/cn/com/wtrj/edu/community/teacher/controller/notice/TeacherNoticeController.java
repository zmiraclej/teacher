package cn.com.wtrj.edu.community.teacher.controller.notice;

import java.io.File;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.dozer.DozerBeanMapper;
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
import cn.com.wtrj.edu.community.response.NoticeTeacherInfo;
import cn.com.wtrj.edu.community.response.NoticeTeacherSelGradeInfo;
import cn.com.wtrj.edu.community.teacher.bean.Sms;
import cn.com.wtrj.edu.community.teacher.common.Constant;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.teacher.job.SmsJob;
import cn.com.wtrj.edu.community.teacher.job.WxJob;
import cn.com.wtrj.edu.community.teacher.request.NoticeAddParam;
import cn.com.wtrj.edu.community.teacher.request.NoticeClassSelectParam;
import cn.com.wtrj.edu.community.teacher.request.NoticeCourseSelectParam;
import cn.com.wtrj.edu.community.teacher.request.NoticeGradeSelectParam;
import cn.com.wtrj.edu.community.teacher.request.NoticeGroupCode;
import cn.com.wtrj.edu.community.teacher.request.NoticeGroupParam;
import cn.com.wtrj.edu.community.teacher.request.NoticeRoleSelectParam;
import cn.com.wtrj.edu.community.teacher.request.TeacherSelectParam;
import cn.com.wtrj.edu.community.teacher.response.NoticeClassInfo;
import cn.com.wtrj.edu.community.teacher.response.NoticeGradeInfo;
import cn.com.wtrj.edu.community.teacher.response.NoticeSchoolInfo;
import cn.com.wtrj.edu.community.teacher.response.NoticeStatus;
import cn.com.wtrj.edu.community.teacher.response.NoticeTeacherRet;
import cn.com.wtrj.edu.community.teacher.response.TeacherNoticeGroup;
import cn.com.wtrj.edu.community.teacher.response.TeacherNoticeGroupMember;
import cn.com.wtrj.edu.community.util.NamesGenerationUtil;
import cn.com.wtrj.jx.web.portal.model.entities.DictItem;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomNotice;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomPermission;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomTeacherNoticeGroup;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtNoticeSendStatus;
import cn.com.wtrj.jx.web.portal.model.mt.entities.MtTeacherNoticeGroup;
import cn.com.wtrj.jx.web.portal.service.ITeacherNoticeGroupService;
import cn.com.wtrj.jx.web.portal.service.ITeacherService;
import cn.com.wtrj.jx.web.portal.service.dict.IDictService;
import cn.com.wtrj.jx.web.portal.service.dto.notice.AdminTeacher;
import cn.com.wtrj.jx.web.portal.service.dto.notice.EcomPermisson;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeClassKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeGradeKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeTeacherKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.TeacherBaseInfo;
import cn.com.wtrj.jx.web.portal.service.impl.SmsService;
import cn.com.wtrj.jx.web.portal.service.notice.IEcomNoticeService;
import cn.com.wtrj.jx.web.portal.service.notice.IEcomPermissionService;
import me.chanjar.weixin.common.exception.WxErrorException;

@Controller
@RequestMapping("/teacherNotice")
public class TeacherNoticeController extends BaseController {
	private static Logger logger = Logger.getLogger(TeacherNoticeController.class);

	private static final String TEACHER_AUTH = "teacherAuth";

	private static final String[] CLASS_NAMES = { "一班", "二班", "三班", "四班", "五班", "六班", "七班", "八班", "九班", "十班", "十一班",
			"十二班" };

	@Autowired
	IEcomNoticeService noticeService;

	@Autowired
	IEcomPermissionService permissionService;

	@Autowired
	IEcomPermissionService teacherAuthService;

	@Autowired
	ITeacherService teacherService;

	@Autowired
	private IDictService dictService;

	@Autowired
	private SmsService smsService;

	@Autowired
	ITeacherNoticeGroupService groupService;

	@Value("${send_to_appid}")
	private String sendAppid;
	@Value("${send_to_secret}")
	private String sendSecret;
	@Value("${send_to_agent_id}")
	private Integer agentId;

	@Value("${notice_default_pic_url}")
	private String noticeDefaultPic;

	/**
	 * 短信发送开关
	 */
	@Value("${sms_send_flag}")
	private Boolean smsSendFlag;

	@Value("${sms_wx_send_api}")
	private String sendWxUrl;

	@Value("${sms_shortmessage_send_api}")
	private String sendShortMsgUrl;

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

	@RequestMapping("/toAddTeacherNotice")
	public String toAddNotice(Map<String, Object> model) {
		logger.info("跳转到教师通知追加页面");
		try {
			Object auth = SecurityUtils.getSubject().getSession().getAttribute("wtrj_ecom_teacher_auth");
			int selectedNum = 0;
			if (auth != null) {
				EcomPermisson per = (EcomPermisson) auth;

				Map<Integer, Boolean> teacherSelectStatus = per.getTeacherSelectedMap();
				for (Integer key : teacherSelectStatus.keySet()) {
					if (teacherSelectStatus.get(key)) {
						selectedNum++;
					}
				}
			}
			model.put("selectedNum", selectedNum);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute("tempNoticeInfo");

			if (obj != null) {
				model.put("tempNoticeInfo", obj);
			}
		} catch (Exception e) {
			logger.error("跳转到教师通知页面 异常", e);
		}

		logger.info("跳转到教师通知追加页面");
		return "notice/addTeacherNotice";
	}

	@RequestMapping("/toAddTeacherNoticeFromGroup")
	public String toAddTeacherNoticeWithGroup(Map<String, Object> model) {
		logger.info("从分组选择跳转到教师通知追加页面");
		try {
			model.put("groupFlag", true);

			// TODO 常量定义
			Object auth = SecurityUtils.getSubject().getSession().getAttribute("teacher_notice_group_select");
			int selectedNum = 0;
			if (auth != null) {
				List<TeacherNoticeGroupMember> pers = (List<TeacherNoticeGroupMember>) auth;

				selectedNum = pers.size();
			}
			model.put("selectedNum", selectedNum);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute("tempNoticeInfo");

			if (obj != null) {
				model.put("tempNoticeInfo", obj);
			}

		} catch (Exception e) {
			logger.error("从分组选择跳转到教师通知页面 异常", e);
		}

		logger.info("从分组选择跳转到教师通知追加页面");
		return "notice/addTeacherNotice";
	}

	@RequestMapping("/detail/{noticeNo}")
	public String toEcomNoticeDetail(@PathVariable("noticeNo") String noticeNo, Map<String, Object> model) {
		logger.info("跳转到通知明细页面 开始");
		WtrjEcomNotice dto = noticeService.searchNoticeDetailByNoticeNo(noticeNo);
		model.put("title", dto.getTitle());
		model.put("content", dto.getContent());

		Map<String, NoticeStatus> statusMap = new HashMap<String, NoticeStatus>();
		List<MtNoticeSendStatus> shortMsgs = noticeService.searchShortMsgNoticeSendStatus(noticeNo);
		if (shortMsgs != null) {
			for (MtNoticeSendStatus sm : shortMsgs) {
				NoticeStatus status = new NoticeStatus();
				String state = sm.getStatus();
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
				status.setTeacherName(sm.getTeacherName());
				status.setMobile(sm.getMobile());

				statusMap.put(sm.getMobile(), status);
			}
		}

		List<MtNoticeSendStatus> wxs = noticeService.searchWxNoticeSendStatus(noticeNo);
		if (wxs != null) {
			for (MtNoticeSendStatus sm : wxs) {
				NoticeStatus status = statusMap.get(sm.getMobile());
				if (status == null) {
					status = new NoticeStatus();
					status.setTeacherName(sm.getTeacherName());
					status.setMobile(sm.getMobile());
				}
				String state = sm.getStatus();
				if ("2".equals(state)) {
					status.setWxStatus("发送中");
				}
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

				statusMap.put(sm.getMobile(), status);
			}
		}

		List<NoticeStatus> ns = new ArrayList<NoticeStatus>();
		for (String key : statusMap.keySet()) {
			ns.add(statusMap.get(key));
		}

		model.put("sendDetails", ns);

		logger.info("跳转到通知明细页面 结束");
		return "notice/teacherNoticeDetail";
	}

	@RequestMapping("/toTeacherGradeSelect")
	public String toTeacherGradeSelect(Map<String, Object> model) {
		logger.info("跳转到教师选择页面 开始");
		try {
			Map<String, List<GradeInfo>> map = new HashMap<String, List<GradeInfo>>();

			EcomPermisson permisson = this.getPermission();
			List<NoticeGradeKey> dtos = permisson.getOwnedGrades();
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
				gi.setDispayName(NamesGenerationUtil.genGradeName(dto.getStage(), dto.getGrade()));
				gi.setGradeKeyNo(dto.getSchoolCode() + "_" + dto.getStage() + "_" + dto.getGrade());

				arry.add(gi);

				// 排序处理
				Comparator<GradeInfo> ct = new Comparator<GradeInfo>() {

					@Override
					public int compare(GradeInfo o1, GradeInfo o2) {
						if (o1.getGrade() < o2.getGrade()) {
							return -1;
						} else if (o1.getGrade() > o2.getGrade()) {
							return 1;
						}
						return 0;
					}
				};

				Collections.sort(arry, ct);
			}

			// ------------------做成页面显示用返回值----------------------------------
			List<NoticeTeacherSelGradeInfo> gradeInfos = new ArrayList<NoticeTeacherSelGradeInfo>();
			for (String key : map.keySet()) {
				NoticeTeacherSelGradeInfo info = new NoticeTeacherSelGradeInfo();
				info.setSchoolCode(key);
				info.setGrades(map.get(key));
				info.setSchoolName(teacherAuthService.getSchoolNameByCode(key));

				gradeInfos.add(info);
			}
			model.put("array", gradeInfos);

			// -----------------------科目选择-------------------------------------
			List<DictItem> dis = dictService.findDictItemsByCode("subject");
			model.put("courses", dis);

		} catch (Exception e) {
			logger.error("跳转到教师选择通知页面 异常", e);
		}

		logger.info("跳转到教师选择页面 结束");
		return "notice/teacherGradeSelect";
	}

	@RequestMapping("//toTeacherGroup")
	public String toTeacherGroup(Map<String, Object> model) {
		logger.info("跳转到自定义分组选择页面 开始");
		try {
			Map<String, List<GradeInfo>> map = new HashMap<String, List<GradeInfo>>();

			// -------------------------分组-------------------------------------------
			List<TeacherNoticeGroup> records = new ArrayList<TeacherNoticeGroup>();

			List<MtTeacherNoticeGroup> recs = groupService.searchByTeacherId(this.getCurrentUser().getUserId());
			if (recs != null) {
				DozerBeanMapper mapper = new DozerBeanMapper();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				for (MtTeacherNoticeGroup group : recs) {
					TeacherNoticeGroup tng = new TeacherNoticeGroup();
					mapper.map(group, tng);
					tng.setCreateTime(sdf.format(group.getCreateTime()));
					records.add(tng);
				}
			}
			model.put("groups", records);

		} catch (Exception e) {
			logger.error("跳转到自定义分组页面 异常", e);
		}

		logger.info("跳转到自定义分组选择页面 结束");
		return "notice/teacherGroup";
	}

	@RequestMapping("/toTeacherClassSelect")
	public String toTeacherClassSelect(@RequestParam(value = "schoolCode") String schoolCode,
			@RequestParam(value = "stage") Integer stage, @RequestParam(value = "grade") Integer grade,
			Map<String, Object> model) {
		logger.info("跳转到教师班级选择页面 开始");

		try {
			EcomPermisson permisson = this.getPermission();
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
			logger.error("跳转到教师班级选择页面 异常", e);
		}

		logger.info("跳转到教师班级选择页面 结束");
		return "notice/teacherClassSelect";
	}

	@RequestMapping("/toTeacherSelect")
	public String toTeacherSelect(@RequestParam(value = "schoolCode") String schoolCode,
			@RequestParam(value = "stage") Integer stage, @RequestParam(value = "grade") Integer grade,
			@RequestParam(value = "classNo") Integer classNo, Map<String, Object> model) {
		logger.info("跳转到教师选择页面 开始");
		try {
			EcomPermisson permisson = this.getPermission();
			List<NoticeTeacherKey> dtos = permisson.getOwnedTeachers();
			List<NoticeTeacherInfo> classInfos = new ArrayList<NoticeTeacherInfo>();
			for (NoticeTeacherKey dto : dtos) {

				if (dto.getSchoolCode().equals(schoolCode) && dto.getStage() == stage && dto.getGrade() == grade
						&& dto.getClassNo() == classNo) {
					NoticeTeacherInfo gi = new NoticeTeacherInfo();
					gi.setSchoolCode(dto.getSchoolCode());
					gi.setStage(dto.getStage());
					gi.setGrade(dto.getGrade());
					gi.setClassNo(dto.getClassNo());
					gi.setTeacherName(dto.getTeacherName());
					gi.setTeacherPhone(dto.getTeacherPhone());
					gi.setTeacherKeyNo(dto.getTeacherKeyNo());
					Map<String, Boolean> selectedMap = permisson.getTeacherSelected();
					gi.setSelected(selectedMap == null ? false
							: (selectedMap.get(dto.getTeacherKeyNo()) == null ? false : true));

					classInfos.add(gi);
				}

			}

			model.put("array", classInfos);

			model.put("schoolCode", schoolCode);
			model.put("stage", stage);
			model.put("grade", grade);
		} catch (Exception e) {
			logger.error("跳转到教师班级选择页面 异常", e);
		}

		logger.info("跳转到教师选择页面 结束");
		return "notice/teacherSelect";
	}

	@ResponseBody
	@RequestMapping("/searchTeacherClasses")
	public List<ClassInfo> searchTeacherClasses(@RequestParam(value = "schoolCode") String schoolCode,
			@RequestParam(value = "stage") Integer stage, @RequestParam(value = "grade") Integer grade,
			Map<String, Object> model) {
		logger.info("跳转到教师班级选择页面 开始");

		try {
			EcomPermisson permisson = this.getPermission();
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

			return classInfos;
		} catch (Exception e) {
			logger.error("跳转到教师班级选择页面 异常", e);
		}

		logger.info("跳转到教师班级选择页面 结束");
		return null;
	}

	/**
	 * 根据权限，角色和科目查询教师信息
	 * 
	 * @param schoolCode
	 * @param stage
	 * @param grade
	 * @param classNo
	 * @param courseCode
	 * @param role
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/searchTeachers")
	public List<NoticeTeacherInfo> searchTeachers(@RequestParam(value = "schoolCode") String schoolCode,
			@RequestParam(value = "stage") Integer stage, @RequestParam(value = "grade") Integer grade,
			@RequestParam(value = "classNo") Integer classNo, @RequestParam(value = "courseCode") String courseCode,
			@RequestParam(value = "role") String role, Map<String, Object> model) {
		logger.info("跳转到教师选择页面 开始");
		try {
			EcomPermisson permisson = this.getPermission();
			List<NoticeTeacherKey> dtos = permisson.getOwnedTeachers();
			List<NoticeTeacherInfo> classInfos = new ArrayList<NoticeTeacherInfo>();

			if (StringUtils.isNotBlank(schoolCode) && stage != null && stage > 0) {

				NoticeTeacherInfo gi = null;

				for (NoticeTeacherKey dto : dtos) {

					if (!schoolCode.equals(dto.getSchoolCode())) {
						continue;
					}

					if (!stage.equals(dto.getStage())) {
						continue;
					}

					if (grade != null && grade > 0) {

						if (!grade.equals(dto.getGrade())) {
							continue;
						}

					}

					if (classNo != null && classNo > 0) {

						if (!classNo.equals(dto.getClassNo())) {
							continue;
						}

					}

					if (StringUtils.isNotBlank(courseCode)) {

						if (!courseCode.equals(dto.getCourseCode())) {
							continue;
						}

					}

					if (StringUtils.isNotBlank(role)) {

						if (!role.equals(dto.getRole())) {
							continue;
						}

					}

					gi = new NoticeTeacherInfo();

					BeanUtils.copyProperties(gi, dto);

					Map<String, Boolean> selectedMap = permisson.getTeacherSelected();
					gi.setSelected(selectedMap == null ? false
							: (selectedMap.get(dto.getTeacherKeyNo()) == null ? false : true));
					classInfos.add(gi);

				}
			}

			return classInfos;
		} catch (Exception e) {
			logger.error("跳转到教师班级选择页面 异常", e);
		}

		logger.info("跳转到教师选择页面 结束");
		return null;
	}

	/**
	 * 编辑发送内容--追加发送人：**老师
	 * 
	 * @param content
	 * @return
	 */
	private String editContent(String content) {
		String sender = this.getCurrentUser().getName();
		StringBuilder sb = new StringBuilder();
		sb.append(content);
		if (!StringUtils.isEmpty(sender)) {
			sb.append("[");
			sb.append(StringUtils.isEmpty(sender) ? "" : sender);
			sb.append("老师]");
		}

		return sb.toString();
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
			 * String rootPath = request.getSession().getServletContext() .getRealPath("/");
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
	 * 保存教师选择数据
	 * 
	 * @param teachers
	 * @return
	 */
	@RequestMapping(value = "/saveTeacherSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveTeacherSelect(@RequestBody List<TeacherSelectParam> teachers) {
		logger.info("保存教师选择 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getPermission();
			Map<String, Boolean> map = p.getTeacherSelected();
			if (map == null) {
				map = new HashMap<String, Boolean>();
			}
			for (TeacherSelectParam sp : teachers) {
				map.put(sp.getTeacherKeyNo(), sp.getSelected());
				for (NoticeTeacherKey key : p.getOwnedTeachers()) {
					if (key.getTeacherKeyNo().equals(sp.getTeacherKeyNo())) {
						Integer teacherId = key.getTeacherId();
						if (p.getTeacherSelectedMap() != null) {
							Map<Integer, Boolean> teacherMap = p.getTeacherSelectedMap();
							teacherMap.put(teacherId, sp.getSelected());

							p.setTeacherSelectedMap(teacherMap);
						}
					}
				}
			}

			p.setTeacherSelected(map);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存教师选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存教师选择 结束！");
		return ret;
	}

	@RequestMapping(value = "/saveTeacherGradeSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveTeacherGradeSelect(@RequestBody List<NoticeGradeSelectParam> grades) {
		logger.info("保存通知年级选择 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getPermission();
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

			refreshTeacherSelectStatus(p);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存通知年级选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存通知年级选择 结束！");
		return ret;
	}

	@RequestMapping(value = "/saveTeacherCourseSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveTeacherCourseSelect(@RequestBody List<NoticeCourseSelectParam> courses) {
		logger.info("保存通知科目选择 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getPermission();

			// -------------------获取科目选择状态---------------------
			Object obj = SecurityUtils.getSubject().getSession().getAttribute(Constant.NoticeSelectKey.COURSE_SELECT);
			Map<String, Boolean> courseMap = null;
			if (obj == null) {
				courseMap = new HashMap<String, Boolean>();
			} else {
				courseMap = (Map<String, Boolean>) obj;
			}

			for (NoticeCourseSelectParam param : courses) {
				courseMap.put(param.getCourseCode(), param.getSelected());
			}

			// ------------科目选择------------------------
			SecurityUtils.getSubject().getSession().setAttribute(Constant.NoticeSelectKey.COURSE_SELECT, courseMap);

			refreshTeacherSelectStatus(p);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存通知科目选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存通知科目选择 结束！");
		return ret;
	}

	@RequestMapping(value = "/saveTeacherRoleSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveTeacherRoleSelect(@RequestBody List<NoticeRoleSelectParam> roles) {
		logger.info("保存通知角色选择 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getPermission();

			// -------------------获取角色选择状态---------------------
			Object obj = SecurityUtils.getSubject().getSession().getAttribute(Constant.NoticeSelectKey.ROLE_SELECT);
			Map<String, Boolean> roleMap = null;
			if (obj == null) {
				roleMap = new HashMap<String, Boolean>();
			} else {
				roleMap = (Map<String, Boolean>) obj;
			}

			for (NoticeRoleSelectParam param : roles) {
				roleMap.put(param.getRole(), param.getSelected());
			}

			// ------------角色选择------------------------
			SecurityUtils.getSubject().getSession().setAttribute(Constant.NoticeSelectKey.ROLE_SELECT, roleMap);

			refreshTeacherSelectStatus(p);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存通知角色选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存通知角色选择 结束！");
		return ret;
	}

	@RequestMapping(value = "/saveTeacherClassSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveTeacherClassSelect(@RequestBody List<NoticeClassSelectParam> grades) {
		logger.info("保存教师班级选择 开始！" + grades);

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson p = this.getPermission();
			Map<String, Boolean> map = p.getClassSelected();
			if (map == null) {
				map = new HashMap<String, Boolean>();
			}
			for (NoticeClassSelectParam sp : grades) {
				map.put(sp.getClassKeyNo(), sp.getSelected());
			}

			p.setClassSelected(map);

			// ------------更新班级状态------------------------
			List<NoticeClassKey> classKeys = p.getOwnedClasses();
			Map<String, Boolean> classSelectedMap = p.getClassSelected();
			if (classSelectedMap == null) {
				classSelectedMap = new HashMap<String, Boolean>();
			}

			for (NoticeClassSelectParam grade : grades) {
				String[] keys = grade.getClassKeyNo().split("_");

				for (NoticeClassKey noticeClassKey : classKeys) {
					if (keys.length > 3 && noticeClassKey.getSchoolCode().equals(keys[0])
							&& noticeClassKey.getStage() == Integer.valueOf(keys[1])
							&& noticeClassKey.getGrade() == Integer.valueOf(keys[2])
							&& noticeClassKey.getClassNo() == Integer.valueOf(keys[3])) {
						classSelectedMap.put(noticeClassKey.getClassKeyNo(), grade.getSelected());
					}
				}
			}
			p.setClassSelected(classSelectedMap);

			refreshTeacherSelectStatus(p);

			ret.setData("");
		} catch (Exception e) {
			logger.error("保存教师班级选择 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存教师班级选择 结束！");
		return ret;
	}

	@RequestMapping(value = "/saveNoticeGroup", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<Map<String, Object>> saveNoticeGroup(@RequestBody NoticeGroupParam param) {
		logger.info("创建自定义分组 开始");
		BaseRet<Map<String, Object>> rs = new BaseRet<Map<String, Object>>();

		try {
			rs.setCode(Constant.RetCode.SUCCESS);

			List<WtrjEcomTeacherNoticeGroup> records = new ArrayList<WtrjEcomTeacherNoticeGroup>();

			EcomPermisson permisson = this.getPermission();

			Map<Integer, Boolean> teacherSelectStatus = permisson.getTeacherSelectedMap();
			Map<Integer, TeacherBaseInfo> baseMap = permisson.getOwnedTeachersBaseInfo();
			String groupCode = UUID.randomUUID().toString();
			Date createTime = Calendar.getInstance().getTime();
			for (Integer key : teacherSelectStatus.keySet()) {
				if (teacherSelectStatus.get(key)) {
					WtrjEcomTeacherNoticeGroup record = new WtrjEcomTeacherNoticeGroup();
					record.setId(UUID.randomUUID().toString());
					record.setBelongTeacherId(this.getCurrentUser().getUserId());
					record.setGroupName(param.getName());
					record.setFlag("1");
					record.setCreateTime(createTime);
					record.setUpdateTime(createTime);
					record.setGroupCode(groupCode);

					TeacherBaseInfo teacher = baseMap.get(key);
					record.setMemberName(teacher.getTeacherName());
					record.setMemberTeacherId(teacher.getTeacherId());
					record.setMemberMobile(teacher.getMobile());
					records.add(record);
				}
			}

			groupService.saveGroupList(records);

		} catch (Exception e) {
			logger.error("创建自定义分组数据 失败", e);
			rs.setCode(Constant.RetCode.ERROR);
		}

		logger.info("创建自定义分组数据 结束");
		return rs;
	}

	/**
	 * 更新状态
	 * 
	 * @param p
	 *            EcomPermisson
	 */
	private void refreshTeacherSelectStatus(EcomPermisson p) {

		List<NoticeTeacherKey> teachers = p.getOwnedTeachers();
		List<AdminTeacher> adminTeachers = p.getOwnedAdminTeachers();

		// ---------------------------学校权限---------------------------------------
		List<String> schoolCodes = p.getOwnedSchools();

		// -----------------------年级选择状态-----------------------------------------
		List<String[]> selectedGrades = new ArrayList<String[]>();
		List<String[]> allGrades = new ArrayList<String[]>();
		Map<String, Boolean> gradeSelectedMap = p.getGradeSelected();
		if (gradeSelectedMap != null) {
			for (String key : gradeSelectedMap.keySet()) {
				if (gradeSelectedMap.get(key)) {
					selectedGrades.add(key.split("_"));
				}
			}
		}
		// TODO
		// for (NoticeTeacherKey strings : p.getOwnedGrades()) {
		//
		// }

		// -----------------班级关联教师（教师）选择状态---------------------
		Map<String, Boolean> teacherSelectedMap = p.getTeacherSelected();
		if (teacherSelectedMap == null) {
			teacherSelectedMap = new HashMap<String, Boolean>();
		}
		Map<Integer, Boolean> teacherSelectStatusMap = p.getTeacherSelectedMap();

		// 科目选择状态
		Object courseStore = SecurityUtils.getSubject().getSession()
				.getAttribute(Constant.NoticeSelectKey.COURSE_SELECT);
		List<String> selectedCourses = new ArrayList<String>();
		if (courseStore != null) {
			Map<String, Boolean> courseMap = (Map<String, Boolean>) courseStore;
			for (String key : courseMap.keySet()) {
				if (courseMap.get(key)) {
					selectedCourses.add(key);
				}
			}
		}

		// 角色选择状态
		Object roleStore = SecurityUtils.getSubject().getSession().getAttribute(Constant.NoticeSelectKey.ROLE_SELECT);
		List<String> selectedRoles = new ArrayList<String>();
		if (roleStore != null) {
			Map<String, Boolean> roleMap = (Map<String, Boolean>) roleStore;
			for (String key : roleMap.keySet()) {
				if (roleMap.get(key)) {
					selectedRoles.add(key);
				}
			}
		}
		// 班级选中状态
		Map<String, Boolean> selectedClassesStore = p.getClassSelected();
		List<String> selectedClasses = new ArrayList<String>();
		if (selectedClassesStore != null) {
			for (String key : selectedClassesStore.keySet()) {
				if (selectedClassesStore.get(key)) {
					selectedClasses.add(key);
				}
			}
		}

		if (selectedCourses.size() == 0 && selectedClasses.size() == 0 && selectedRoles.size() == 0) {
			for (String key : teacherSelectedMap.keySet()) {
				teacherSelectedMap.put(key, Boolean.FALSE);
			}
			for (Integer key : teacherSelectStatusMap.keySet()) {
				teacherSelectStatusMap.put(key, Boolean.FALSE);
			}
			p.setTeacherSelected(teacherSelectedMap);
			p.setTeacherSelectedMap(teacherSelectStatusMap);
		}

		// ----------------------------------班级关联教师过滤--------------------------------------------------------
		Set<Integer> teacherIds = new HashSet<Integer>();
		for (NoticeTeacherKey noticeTeacherKey : teachers) {
			teacherSelectedMap.put(noticeTeacherKey.getTeacherKeyNo(), false);
			teacherSelectStatusMap.put(noticeTeacherKey.getTeacherId(), false);
		}
		
		for (NoticeTeacherKey noticeTeacherKey : teachers) {
			Integer teacherId = noticeTeacherKey.getTeacherId();

			if (selectedClasses.size() > 0) {
				for (String classKeyNo : selectedClasses) {
					String[] keys = classKeyNo.split("_");

					if (keys.length > 3 && noticeTeacherKey.getSchoolCode().equals(keys[0])
							&& noticeTeacherKey.getStage() == Integer.valueOf(keys[1]).intValue()
							&& noticeTeacherKey.getGrade() == Integer.valueOf(keys[2]).intValue()
							&& noticeTeacherKey.getClassNo() == Integer.valueOf(keys[3]).intValue()) {
						teacherIds.add(teacherId);

						teacherSelectedMap.put(noticeTeacherKey.getTeacherKeyNo(), true);
						teacherSelectStatusMap.put(noticeTeacherKey.getTeacherId(), true);
					}
				}
			} else {
				teacherIds.add(teacherId);
			}
		}
		if (adminTeachers != null) {
			for (AdminTeacher t : adminTeachers) {
				teacherIds.add(t.getTeacherId());
			}
		}

		// 在班级选定的基础上进一步筛选
		// 以角色为基础
		if (selectedRoles.size() > 0) {
			// 任课老师,备课组长
			List<String> courseAndGradeRoles = new ArrayList<String>();
			// 教研组长
			List<String> courseRoles = new ArrayList<String>();
			// 班主任,年级组长
			List<String> gradeRoles = new ArrayList<String>();

			// 科目年级无关人员
			List<String> otherRoles = new ArrayList<String>();

			for (String role : selectedRoles) {
				switch (role) {
				case "1": // 班主任
					gradeRoles.add(role);
					break;
				case "2": // 课任老师
					courseAndGradeRoles.add(role);
					break;
				case "3": // 生辅老师
					gradeRoles.add(role);
					break;
				case "4": // 备课组长
					courseAndGradeRoles.add(role);
					break;
				case "5": // 年级组长
					gradeRoles.add(role);
					break;
				case "6": // 教研组长
					courseRoles.add(role);
					break;
				case "7": // 德育老师
					otherRoles.add(role);
					break;
				case "99": // 其他（行政）
					otherRoles.add(role);
					break;
				case "101": // 学部领导
					otherRoles.add(role);
					break;

				default:
					break;
				}

			}

			List<Integer> includeTeachers = new ArrayList<Integer>();
			// 任课老师,备课组长
			if (courseAndGradeRoles.size() > 0) {
				if (selectedGrades.size() == 0) {
					List<WtrjEcomPermission> ps = permissionService.searchTeacherByCourseAndRole(
							new ArrayList<Integer>(teacherIds), selectedCourses, null, courseAndGradeRoles);
					for (WtrjEcomPermission tp : ps) {
						includeTeachers.add(tp.getTeacherId());
					}
				}
				for (String[] gs : selectedGrades) {
					List<WtrjEcomPermission> ps = permissionService.searchTeacherByCourseAndRole(
							new ArrayList<Integer>(teacherIds), selectedCourses, gs, courseAndGradeRoles);
					for (WtrjEcomPermission tp : ps) {
						includeTeachers.add(tp.getTeacherId());
					}
				}

			}

			// 教研组长
			if (courseRoles.size() > 0) {
				List<WtrjEcomPermission> ps = permissionService.searchTeacherByCourseAndRole(
						new ArrayList<Integer>(teacherIds), selectedCourses, null, courseRoles);
				for (WtrjEcomPermission tp : ps) {
					includeTeachers.add(tp.getTeacherId());
				}
			}

			// 班主任,年级组长
			if (gradeRoles.size() > 0) {
				if (selectedGrades.size() == 0) {
					List<WtrjEcomPermission> ps = permissionService
							.searchTeacherByCourseAndRole(new ArrayList<Integer>(teacherIds), null, null, gradeRoles);
					for (WtrjEcomPermission tp : ps) {
						includeTeachers.add(tp.getTeacherId());
					}
				}
				for (String[] gs : selectedGrades) {
					List<WtrjEcomPermission> ps = permissionService
							.searchTeacherByCourseAndRole(new ArrayList<Integer>(teacherIds), null, gs, gradeRoles);
					for (WtrjEcomPermission tp : ps) {
						includeTeachers.add(tp.getTeacherId());
					}
				}
			}

			// 其他人员
			if (otherRoles.size() > 0) {
				List<WtrjEcomPermission> ps = permissionService
						.searchTeacherForStageRoles(new ArrayList<Integer>(teacherIds), schoolCodes, otherRoles);
				for (WtrjEcomPermission tp : ps) {
					includeTeachers.add(tp.getTeacherId());
				}
			}

			for (NoticeTeacherKey noticeTeacherKey : teachers) {
				Boolean selected = false;

				Integer teacherId = noticeTeacherKey.getTeacherId();
				if (includeTeachers.contains(teacherId)) {
					selected = true;
				} else {
					selected = false;
				}

				teacherSelectedMap.put(noticeTeacherKey.getTeacherKeyNo(), selected);
				teacherSelectStatusMap.put(noticeTeacherKey.getTeacherId(), selected);
			}
			for (Integer teacherId : teacherSelectStatusMap.keySet()) {
				Boolean selected = false;

				if (includeTeachers.contains(teacherId)) {
					selected = true;
				} else {
					selected = false;
				}
				teacherSelectStatusMap.put(teacherId, selected);
			}
		}

		p.setTeacherSelected(teacherSelectedMap);
		p.setTeacherSelectedMap(teacherSelectStatusMap);

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

	private void sendWx(String uid, String content, List<String> mobiles) throws WxErrorException {

		List<String> jobNos = teacherService.findTeacherInfoByPhones(mobiles);
		// 微信通知
		msScheduler.schedule(
				new WxJob(sendWxUrl, "2", sendAppid, sendSecret, agentId, content, uid, smsService, jobNos), 1,
				TimeUnit.SECONDS);

	}

	@RequestMapping(value = "/saveNotice", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveNotice(@RequestBody NoticeAddParam param) {
		logger.info("保存通知 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);
			// 通知单号
			UUID uid = UUID.randomUUID();
			String content = editSendContent(param, uid);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute("wtrj_ecom_teacher_auth");
			if (obj != null) {
				EcomPermisson permisson = (EcomPermisson) obj;
				List<String> ps = this.getSelectedTeacherFromPermisson(permisson);

				// 微信通知
				sendWx(uid.toString(), content, ps);

				// 发送短信,判断是否开启短信发送
				if (smsSendFlag && param.isSendMessageFlg()) {
					sendSms(content, uid.toString(), ps);
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

	@RequestMapping(value = "/saveNoticeWithGroup", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> saveNoticeWithGroup(@RequestBody NoticeAddParam param) {
		logger.info("（自定义分组人员选择后）保存通知 开始！");

		BaseRet<String> ret = new BaseRet<String>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);
			// 通知单号
			UUID uid = UUID.randomUUID();
			String content = editSendContent(param, uid);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute("teacher_notice_group_select");
			if (obj != null) {
				List<TeacherNoticeGroupMember> pers = (List<TeacherNoticeGroupMember>) obj;
				List<String> ps = new ArrayList<String>();
				for (TeacherNoticeGroupMember p : pers) {
					ps.add(p.getMobile());
				}
				
				// 微信通知
				sendWx(uid.toString(), content, ps);

				// 发送短信,判断是否开启短信发送
				if (smsSendFlag && param.isSendMessageFlg()) {
					sendSms(content, uid.toString(), ps);
				}

			}

			ret.setData("");
		} catch (Exception e) {
			logger.error("（自定义分组人员选择后）保存通知 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("（自定义分组人员选择后）保存通知 结束！");
		return ret;
	}

	/**
	 * 发送内容编辑并保存得到数据库
	 * 
	 * @param param
	 * @param uid
	 * @return
	 */
	private String editSendContent(NoticeAddParam param, UUID uid) {
		// 发送内容编辑
		String content = editContent(param.getContent());

		WtrjEcomNotice record = new WtrjEcomNotice();
		record.setTitle(param.getTitle());
		record.setContent(content);
		record.setPulishTime(Calendar.getInstance().getTime());
		record.setTeacherId(this.getCurrentUser().getUserId());
		// 通知公告类型
		record.setType(Constant.NoticeType.TEAHCER_NOTICE);

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
		return content;
	}

	/**
	 * 获取选中教师，发送通知用
	 * 
	 * @param permisson
	 * @return
	 */
	private List<String> getSelectedTeacherFromPermisson(EcomPermisson permisson) {
		List<String> teachers = new ArrayList<>();

		Map<Integer, Boolean> ps = permisson.getTeacherSelectedMap();

		Map<Integer, TeacherBaseInfo> npks = permisson.getOwnedTeachersBaseInfo();
		if (npks != null && ps != null) {
			for (Integer key : ps.keySet()) {
				if (ps.get(key)) {
					teachers.add(npks.get(key).getMobile());
				}
			}
		}
		return teachers;
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

	// --------------------------------页面选择状态查询------------------------------------------------------
	@RequestMapping(value = "/searchTeacherSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchTeacherSelectStatus() {
		logger.info("获取教师选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson permisson = this.getPermission();
			Map<String, Boolean> map = new HashMap<String, Boolean>();
			if (permisson != null && permisson.getTeacherSelected() == null) {
				for (NoticeTeacherKey key : permisson.getOwnedTeachers()) {
					map.put(key.getTeacherKeyNo(), false);
				}
				permisson.setTeacherSelected(map);
			}
			ret.setData(permisson.getTeacherSelected());
		} catch (Exception e) {
			logger.error("获取教师选择状态 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取教师选择状态 结束！");
		return ret;
	}

	@RequestMapping(value = "/searchGradeSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchGradeSelectStatus() {
		logger.info("获取通知年级选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson permisson = this.getPermission();
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

	@RequestMapping(value = "/searchRoleSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchRoleSelectStatus() {
		logger.info("获取通知角色选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute(Constant.NoticeSelectKey.ROLE_SELECT);
			Map<String, Boolean> courseMap = null;
			if (obj == null) {
				courseMap = new HashMap<String, Boolean>();
			} else {
				courseMap = (Map<String, Boolean>) obj;
			}
			ret.setData(courseMap);
		} catch (Exception e) {
			logger.error("获取通知角色选择状态 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取通知角色选择状态 结束！");
		return ret;
	}

	@RequestMapping(value = "/searchCourseSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchCourseSelectStatus() {
		logger.info("获取通知科目选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			Object obj = SecurityUtils.getSubject().getSession().getAttribute(Constant.NoticeSelectKey.COURSE_SELECT);
			Map<String, Boolean> courseMap = null;
			if (obj == null) {
				courseMap = new HashMap<String, Boolean>();
			} else {
				courseMap = (Map<String, Boolean>) obj;
			}
			ret.setData(courseMap);
		} catch (Exception e) {
			logger.error("获取通知科目选择状态 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取通知科目选择状态 结束！");
		return ret;
	}

	@RequestMapping(value = "/searchClassSelectStatus", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<Map<String, Boolean>> searchClassSelectStatus() {
		logger.info("获取通知班级选择状态 开始！");

		BaseRet<Map<String, Boolean>> ret = new BaseRet<Map<String, Boolean>>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson permisson = this.getPermission();
			Map<String, Boolean> map = new HashMap<String, Boolean>();
			if (permisson != null && permisson.getClassSelected() == null) {
				for (NoticeClassKey key : permisson.getOwnedClasses()) {
					map.put(key.getClassKeyNo(), false);
				}
				permisson.setClassSelected(map);
			}
			ret.setData(permisson.getClassSelected());
		} catch (Exception e) {
			logger.error("获取教师选择状态 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取班级选择状态 结束！");
		return ret;
	}

	@RequestMapping(value = "/getTeacherPermission", method = RequestMethod.GET)
	@ResponseBody
	public BaseRet<NoticeTeacherRet> getTeacherPermission() {
		logger.info("获取教师权限 开始！");

		BaseRet<NoticeTeacherRet> ret = new BaseRet<NoticeTeacherRet>();
		try {
			ret.setCode(Constant.RetCode.SUCCESS);

			NoticeTeacherRet tr = new NoticeTeacherRet();

			EcomPermisson p = teacherAuthService.searchTeacherPermisson(this.getCurrentUser().getUserId());
			List<NoticeTeacherKey> teachers = p.getOwnedTeachers();
			for (NoticeTeacherKey teacher : teachers) {
				addNewSchool(tr, teacher);
			}

			ret.setData(tr);
		} catch (Exception e) {
			logger.error("获取教师权限 异常！", e);

			ret.setCode(Constant.RetCode.ERROR);
		}

		logger.info("获取教师权限 结束！");
		return ret;
	}

	@RequestMapping(value = "/searchSelectedInfo")
	@ResponseBody
	public BaseRet<Map<String, Object>> searchSelectedInfo() {
		logger.info("查询选择数据");
		BaseRet<Map<String, Object>> rs = new BaseRet<Map<String, Object>>();

		try {
			rs.setCode(Constant.RetCode.SUCCESS);

			EcomPermisson permisson = this.getPermission();

			int selected = 0;

			List<String> teachers = new ArrayList<String>();

			Map<Integer, Boolean> teacherSelectStatus = permisson.getTeacherSelectedMap();
			Map<Integer, TeacherBaseInfo> baseMap = permisson.getOwnedTeachersBaseInfo();
			for (Integer key : teacherSelectStatus.keySet()) {
				if (teacherSelectStatus.get(key)) {
					selected++;
					teachers.add(baseMap.get(key).getTeacherName());
				}
			}

			Map<String, Object> ret = new HashMap<String, Object>();
			ret.put("total", teacherSelectStatus == null ? 0 : teacherSelectStatus.size());
			ret.put("selected", selected);
			ret.put("selectedTeachers", teachers);

			rs.setData(ret);
		} catch (Exception e) {
			logger.error("查询教师选择数据 失败");
			rs.setCode(Constant.RetCode.ERROR);
		}

		return rs;
	}

	@RequestMapping(value = "/searchGroupMembers", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<List<TeacherNoticeGroupMember>> searchGroupMembers(@RequestBody List<NoticeGroupCode> groupCode) {
		logger.info("查询自定义分组成员 开始");
		BaseRet<List<TeacherNoticeGroupMember>> rs = new BaseRet<List<TeacherNoticeGroupMember>>();

		try {
			rs.setCode(Constant.RetCode.SUCCESS);

			List<TeacherNoticeGroupMember> records = new ArrayList<TeacherNoticeGroupMember>();
			List<String> codes = new ArrayList<String>();
			for (NoticeGroupCode gc : groupCode) {
				codes.add(gc.getCode());
			}
			List<WtrjEcomTeacherNoticeGroup> recs = groupService.searchByGroupBodes(codes);
			if (recs != null) {
				for (WtrjEcomTeacherNoticeGroup group : recs) {
					TeacherNoticeGroupMember member = new TeacherNoticeGroupMember();
					member.setMobile(group.getMemberMobile());
					member.setName(group.getMemberName());
					member.setTeacherId(group.getMemberTeacherId());
					records.add(member);
				}
			}
			rs.setData(records);

		} catch (Exception e) {
			logger.error("查询自定义分组成员 失败", e);
			rs.setCode(Constant.RetCode.ERROR);
		}

		logger.info("查询自定义分组成员 结束");
		return rs;
	}

	@RequestMapping(value = "/commitGroupSelect", method = RequestMethod.POST)
	@ResponseBody
	public BaseRet<String> commitGroupSelect(@RequestBody List<NoticeGroupCode> groupCode) {
		logger.info("保存选择自定义分组成员 开始");
		BaseRet<String> rs = new BaseRet<String>();

		try {
			rs.setCode(Constant.RetCode.SUCCESS);

			List<TeacherNoticeGroupMember> records = new ArrayList<TeacherNoticeGroupMember>();
			List<String> codes = new ArrayList<String>();
			for (NoticeGroupCode gc : groupCode) {
				codes.add(gc.getCode());
			}
			List<WtrjEcomTeacherNoticeGroup> recs = groupService.searchByGroupBodes(codes);
			if (recs != null) {
				for (WtrjEcomTeacherNoticeGroup group : recs) {
					TeacherNoticeGroupMember member = new TeacherNoticeGroupMember();
					member.setMobile(group.getMemberMobile());
					member.setName(group.getMemberName());
					member.setTeacherId(group.getMemberTeacherId());
					records.add(member);
				}
			}

			// TODO
			SecurityUtils.getSubject().getSession().setAttribute("teacher_notice_group_select", records);

		} catch (Exception e) {
			logger.error("保存自定义分组成员 失败", e);
			rs.setCode(Constant.RetCode.ERROR);
		}

		logger.info("保存选择自定义分组成员 结束");
		return rs;
	}

	/**
	 * 获取教师数量
	 * 
	 * @param teacherKeys
	 * @return
	 */
	private int countOwnTeachers(List<NoticeTeacherKey> teacherKeys) {
		// ---------------------过滤重复教师-----------------------------
		List<String> teacherNames = new ArrayList<String>();
		for (NoticeTeacherKey key : teacherKeys) {
			if (!teacherNames.contains(key.getTeacherName())) {
				teacherNames.add(key.getTeacherName());
			}
		}
		return teacherNames.size();
	}

	private void addNewSchool(NoticeTeacherRet tr, NoticeTeacherKey teacher) {
		List<NoticeSchoolInfo> schools = tr.getSchools();

		if (schools == null) {
			schools = new ArrayList<NoticeSchoolInfo>();
		}

		NoticeSchoolInfo newSchool = null;
		for (NoticeSchoolInfo school : schools) {
			if (teacher.getSchoolCode().equals(school.getSchoolCode())) {
				newSchool = school;
				break;
			}
		}
		if (newSchool == null) {
			newSchool = new NoticeSchoolInfo();
			newSchool.setSchoolCode(teacher.getSchoolCode());
			newSchool.setSchoolName(teacher.getSchoolName());
			schools.add(newSchool);
		}

		tr.setSchools(schools);

		this.addNewGrade(newSchool, teacher);

	}

	private void addNewGrade(NoticeSchoolInfo school, NoticeTeacherKey teacher) {
		List<NoticeGradeInfo> grades = school.getGrades();
		if (grades == null) {
			grades = new ArrayList<NoticeGradeInfo>();
		}

		NoticeGradeInfo newGrade = null;
		for (NoticeGradeInfo og : grades) {
			if (og.getGrade() == teacher.getGrade()) {
				newGrade = og;
				break;
			}
		}

		if (newGrade == null) {
			newGrade = new NoticeGradeInfo();
			newGrade.setGrade(teacher.getGrade());
			newGrade.setGradeName("");
			grades.add(newGrade);
		}

		school.setGrades(grades);

		this.addNewClass(newGrade, teacher);

	}

	private void addNewClass(NoticeGradeInfo newGrade, NoticeTeacherKey teacher) {
		List<NoticeClassInfo> classes = newGrade.getClasses();
		if (classes == null) {
			classes = new ArrayList<NoticeClassInfo>();
		}

		NoticeClassInfo newClass = null;
		for (NoticeClassInfo oc : classes) {
			if (oc.getClassNo() == teacher.getGrade()) {
				newClass = oc;
				break;
			}
		}

		if (newClass == null) {
			newClass = new NoticeClassInfo();
			newClass.setClassId(0);
			newClass.setClassNo(teacher.getClassNo());
			classes.add(newClass);
		}

		newGrade.setClasses(classes);

		this.addNewTeacher(newClass, teacher);
	}

	private void addNewTeacher(NoticeClassInfo newClass, NoticeTeacherKey teacher) {
		List<cn.com.wtrj.edu.community.teacher.response.NoticeTeacherInfo> tes = newClass.getTeachers();
		if (tes == null) {
			tes = new ArrayList<cn.com.wtrj.edu.community.teacher.response.NoticeTeacherInfo>();
		}

		// 教师
		cn.com.wtrj.edu.community.teacher.response.NoticeTeacherInfo teacherInfo = new cn.com.wtrj.edu.community.teacher.response.NoticeTeacherInfo();
		teacherInfo.setName(teacher.getTeacherName());
		teacherInfo.setMobile(teacher.getTeacherPhone());
		tes.add(teacherInfo);

		newClass.setTeachers(tes);
	}
}
