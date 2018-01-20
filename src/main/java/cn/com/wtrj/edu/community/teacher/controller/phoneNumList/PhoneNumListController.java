package cn.com.wtrj.edu.community.teacher.controller.phoneNumList;

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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.common.Constant.RetCode;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.teacher.response.ClassParentAdreeBook;
import cn.com.wtrj.edu.community.teacher.response.ParentAddressBook;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomDailyActivities;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjStudent;
import cn.com.wtrj.jx.web.portal.model.mt.entities.ParentsRespWithStudent;
import cn.com.wtrj.jx.web.portal.service.IWtrjEcomDailyActivitiesService;
import cn.com.wtrj.jx.web.portal.service.IWtrjStudentService;
import cn.com.wtrj.jx.web.portal.service.ParentsMeeting.IParentsMeetingService;
import cn.com.wtrj.jx.web.portal.service.dto.notice.EcomPermisson;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeParentKey;

@Controller
@RequestMapping("/phoneNumList")
public class PhoneNumListController extends BaseController {
	private static Logger logger = Logger.getLogger(PhoneNumListController.class);
	
	@Autowired
	IWtrjStudentService wtrjStudentService;
	
	@Autowired
	IWtrjEcomDailyActivitiesService ecomDailyActivitiesService;
	
	@Autowired
	private IParentsMeetingService parentsMeetingService;

	@Value("${upload.activities.path}")
	String uploadActivitiesPath;
	@Value("${upload.path.base}")
	String uploadPathBase;
	@Value("${upload.url}")
	String uploadUrl;

	@ResponseBody
	@RequestMapping(value = "/searchParentsPhoneByTeacherId")
	public BaseRet<List<ClassParentAdreeBook>> searchParentsPhoneByTeacherId() {
		logger.info("查询班主任对应下的学生家长通讯录集合");
		BaseRet<List<ClassParentAdreeBook>> ret = new BaseRet<List<ClassParentAdreeBook>>();
		try {
//			ShiroUser teacher = getCurrentUser();
//			List<ParentsRespWithStudent> list = parentsMeetingService
//					.searchParentsPhoneByTeacherId(teacher.getUserId());
			
			EcomPermisson permission = this.getPermission();
			List<NoticeParentKey> list = permission.getOwnedParents();
			
			
			Map<String, List<NoticeParentKey>> map = new HashMap<String, List<NoticeParentKey>>();

			for (NoticeParentKey r : list) {
				List<NoticeParentKey> ps = map.get(r.getClassName());
				if (ps == null) {
					ps = new ArrayList<NoticeParentKey>();
				}

				ps.add(r);

				map.put(r.getClassName(), ps);
			}

			List<ClassParentAdreeBook> ads = new ArrayList<ClassParentAdreeBook>();
			for (String key : map.keySet()) {
				ClassParentAdreeBook ad = new ClassParentAdreeBook();
				ad.setClassName(key);

				List<ParentAddressBook> parents = new ArrayList<ParentAddressBook>();
				List<NoticeParentKey> ps = map.get(key);
				for (NoticeParentKey p : ps) {
					ParentAddressBook address = new ParentAddressBook();
					address.setParentName(StringUtils.isEmpty(p.getParentName()) ? "家长" : p.getParentName());
					address.setPhone(p.getParentPhone());
					address.setStudentName(p.getStudentName());

					parents.add(address);
					
					ad.setClassNo(p.getClassNo());
					ad.setGrade(p.getGrade());
					ad.setStage(p.getStage());
					ad.setSchoolCode(p.getSchoolCode());
				}

				ad.setParents(parents);
				
				ads.add(ad);
			}
			
			Comparator<ClassParentAdreeBook> ct = new Comparator<ClassParentAdreeBook>(){

				@Override
				public int compare(ClassParentAdreeBook o1, ClassParentAdreeBook o2) {
					if (o1.getSchoolCode().compareTo(o2.getSchoolCode()) > 0) {
						return 1;
					}
					if(o1.getStage() > o2.getStage()){
						return 1;
					} 
					if(o1.getGrade() > o2.getGrade()){
						return 1;
					}
					if(o1.getClassNo() > o2.getClassNo()){
						return 1;
					}
					return -1;
				}
				
			};

			Collections.sort(ads, ct);
			ret.setData(ads);
			ret.setMsg("查询成功");
			ret.setCode(RetCode.SUCCESS);
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		logger.info("查询班主任对应下的学生家长通讯录集合结束");
		return ret;
	}

	/**
	 * 查询班级通过班主任id
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchClassByTeacherId")
	public BaseRet<String> searchClassByTeacherId() {
		logger.info("查询班级通过班主任id");
		BaseRet<String> ret = new BaseRet<String>();
		try {
			ShiroUser teacher = getCurrentUser();
			String className = parentsMeetingService.searchClassByTeacherId(teacher.getUserId());
			ret.setData(className);
			ret.setMsg("查询成功");
			ret.setCode(RetCode.SUCCESS);
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		logger.info("查询班级通过班主任id结束");
		return ret;
	}

	/**
	 * 查询学生参加的日常活动
	 * 
	 * @param stuIdCard
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchDailyActivities", method = RequestMethod.GET)
	public BaseRet<List<WtrjEcomDailyActivities>> searchDailyActivities(String stuIdCard) {
		logger.info("通过stuIdCard查询学生个人作品对象" + stuIdCard);
		BaseRet<List<WtrjEcomDailyActivities>> ret = new BaseRet<List<WtrjEcomDailyActivities>>();
		List<WtrjEcomDailyActivities> list = new ArrayList<WtrjEcomDailyActivities>();
		try {
			List<WtrjEcomDailyActivities> dailyActivitiesList = ecomDailyActivitiesService
					.searchDailyActivities(stuIdCard);

			if (dailyActivitiesList != null && dailyActivitiesList.size() > 0) {
				for (WtrjEcomDailyActivities wtrjEcomDailyActivities : dailyActivitiesList) {
					WtrjEcomDailyActivities dailyActivities = new WtrjEcomDailyActivities();
					dailyActivities.setActivityDate(wtrjEcomDailyActivities.getActivityDate());
					dailyActivities.setContent(wtrjEcomDailyActivities.getContent());
					String imgurl = "";
					// 说明包含多张图片
					if (wtrjEcomDailyActivities.getAttachFile().indexOf(",") != -1) {

						String[] strs = wtrjEcomDailyActivities.getAttachFile().split(",");
						for (int i = 0; i < strs.length; i++) {
							imgurl += uploadUrl + strs[i] + ",";
						}
						dailyActivities.setAttachFile(imgurl.substring(0, imgurl.length() - 1));
					}
					if (wtrjEcomDailyActivities.getAttachFile().indexOf(",") == -1
							&& wtrjEcomDailyActivities.getAttachFile() != null
							&& !"".equals(wtrjEcomDailyActivities.getAttachFile())) {
						imgurl = uploadUrl + wtrjEcomDailyActivities.getAttachFile();
						dailyActivities.setAttachFile(imgurl);
					}
					if (wtrjEcomDailyActivities.getAttachFile() == null
							&& "".equals(wtrjEcomDailyActivities.getAttachFile())) {
						dailyActivities.setAttachFile(null);
					}

					list.add(dailyActivities);
				}

				ret.setData(list);
				ret.setMsg("查询学生参加公益活动成功");
				ret.setCode(RetCode.SUCCESS);
			}

		} catch (Exception e) {
			logger.error("查询学生参加公益活动失败！", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询学生参加公益活动失败");

		}
		logger.info("查询学生参加公益活动结束");
		return ret;

	}

	/**
	 * 查询单个学生对象
	 * 
	 * @param stuIdCard
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchWtrjStudent")
	public BaseRet<WtrjStudent> searchWtrjStudent(String studentNo) {
		logger.info("通过studentNo查询学生对象" + studentNo);
		BaseRet<WtrjStudent> ret = new BaseRet<WtrjStudent>();
		try {
			WtrjStudent wtrjStudent = parentsMeetingService.searchWtrjStudent(studentNo);
			wtrjStudent.setPhoto(uploadUrl + wtrjStudent.getPhoto());
			ret.setData(wtrjStudent);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("查询学生对象失败！", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询学生对象失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("查询学生对象结束");
		return ret;
	}

	@RequestMapping(value = "/photo")
	public void uploadPhoto(MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		final String[] allowedExt = new String[] { "png", "psd", "bmp", "jpg", "jpeg", "gif", "txt", "doc", "docx",
				"mp3", "wma", "m4a", "exe", "zip", "rar", "pdf", "xls", "xlsx" };
		final String[] imagesExt = new String[] { "png", "psd", "bmp", "jpg", "jpeg", "gif" };
		response.setContentType("text/html;charset=utf-8");
		// 设置字符编码为UTF-8, 这样支持汉字显示
		response.setCharacterEncoding("UTF-8");

		System.out.println("开始");
		String rootPath = request.getSession().getServletContext().getRealPath("/");
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
		// 根据系统时间生成上传后保存的文件名
		// long now = System.currentTimeMillis();
		String uid = UUID.randomUUID().toString();
		String prefix = uid.replace("-", "");
		StringBuffer sb = new StringBuffer();
		sb.append("/");
		sb.append("upload");
		sb.append("/");
		sb.append(year);
		sb.append("/");
		sb.append(month);
		sb.append("/");
		sb.append(day);
		sb.append("/");
		// 保存的最终文件完整路径,保存在web根目录下的upload目录下
		String filePath = sb.toString();

		File targetFile = new File(rootPath + filePath);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		targetFile = new File(rootPath + filePath + prefix + "." + t_ext);

		System.out.println(targetFile);
		// 保存
		try {
			file.transferTo(targetFile);
			JsonObject resultJson = new JsonObject();
			resultJson.addProperty("error", 0);
			resultJson.addProperty("url", filePath.replaceAll("\\\\", "/") + prefix + "." + t_ext);
			out.println(resultJson.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.flush();
		out.close();
	}

}
