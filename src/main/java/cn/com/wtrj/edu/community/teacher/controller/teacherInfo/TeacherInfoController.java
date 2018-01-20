package cn.com.wtrj.edu.community.teacher.controller.teacherInfo;

import java.io.File;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.common.Constant.RetCode;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.jx.web.portal.model.entities.DictItem;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjTeacher;
import cn.com.wtrj.jx.web.portal.service.dict.IDictService;
import cn.com.wtrj.jx.web.portal.service.teacherInfo.ITeacherInfoService;

@Controller
@RequestMapping("/teacherInfo")
public class TeacherInfoController extends BaseController {
	private static Logger logger = Logger.getLogger(TeacherInfoController.class);
	@Autowired
	private ITeacherInfoService teacherInfoService;
	
	@Autowired
	private IDictService dictService;

	@Value("${upload.teacherPhoto.path}")
	String uploadStudentPhotoPath;
	@Value("${upload.path.base}")
	String uploadPathBase;
	@Value("${upload.url}")
	String uploadUrl;

	/**
	 * 查询教师信息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchTeacherInfo")
	public BaseRet<WtrjTeacher> searchTeacherInfo() {
		logger.info("通过id查询教师对象");
		BaseRet<WtrjTeacher> ret = new BaseRet<WtrjTeacher>();
		try {
			ShiroUser teacher = getCurrentUser();
			WtrjTeacher wtrjTeacher = teacherInfoService.searchParentsMeetingById(teacher.getUserId());
			wtrjTeacher.setPhoto(uploadUrl + wtrjTeacher.getPhoto());
			ret.setData(wtrjTeacher);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("通过id查询教师对象结束");
		return ret;
	}
	
	@ResponseBody
	@RequestMapping(value = "/searchCoursesInfo")
	public List<DictItem> findCoureses(){
		return dictService.findDictItemsByCode("subject");
	}

	/**
	 * 更新教师信息
	 * 
	 * @param wtrjTeacher
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateTeacherInfo")
	public BaseRet<String> updateTeacherInfo(WtrjTeacher wtrjTeacher) {
		logger.info("通过id更新教师对象");
		BaseRet<String> ret = new BaseRet<String>();
		try {
			wtrjTeacher.setPhoto(wtrjTeacher.getPhoto().replace(uploadUrl, ""));
			teacherInfoService.updateTeacherInfo(wtrjTeacher);
			ret.setMsg("通过id更新教师对象成功");
			ret.setCode(RetCode.SUCCESS);
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("通过id更新教师对象失败");
		}

		logger.info("通过id更新教师对象结束");
		return ret;
	}

	@RequestMapping(value = "/uploadHeadPhoto")
	public void uploadHeadPhoto(MultipartFile file, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		final String[] allowedExt = new String[] { "png", "psd", "bmp", "jpg", "jpeg", "gif", "txt", "doc", "docx",
				"mp3", "wma", "m4a", "exe", "zip", "rar", "pdf", "xls", "xlsx" };
		final String[] imagesExt = new String[] { "png", "psd", "bmp", "jpg", "jpeg", "gif" };
		response.setContentType("text/html;charset=utf-8");
		// 设置字符编码为UTF-8, 这样支持汉字显示
		response.setCharacterEncoding("UTF-8");

		String rootPath = uploadStudentPhotoPath;
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
			resultJson.addProperty("url", uploadUrl + uploadStudentPhotoPath + newFilePath);
			out.println(resultJson.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.flush();
		out.close();
	}

}
