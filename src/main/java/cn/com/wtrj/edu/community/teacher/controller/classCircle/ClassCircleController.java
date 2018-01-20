package cn.com.wtrj.edu.community.teacher.controller.classCircle;

import java.io.File;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;
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

import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomClass;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomClassCircle;
import cn.com.wtrj.jx.web.portal.service.classCircle.IClassCircleService;

@Controller
@RequestMapping("classCircle")
public class ClassCircleController extends BaseController {

	private static Logger logger = Logger.getLogger(ClassCircleController.class);
	private static String DELFLG_FALSE = "0";
	private static String DELFLG_TRUE = "1";

	@Value("${upload.classcircle.path}")
	String classCirclePath;
	@Value("${upload.path.base}")
	String uploadPathBase;
	@Value("${upload.url}")
	String uploadUrl;

	@Autowired
	private IClassCircleService classCircleService;

	@RequestMapping("/selectUserClass")
	@ResponseBody
	public List<WtrjEcomClass> selectUserClass() {
		logger.debug("开始查询教师关联的班级");
		Integer userId = this.getCurrentUser().getUserId();
		List<WtrjEcomClass> classList = null;
		try {
			classList = classCircleService.selectUserClass(51);
		} catch (Exception e) {
			logger.error("查询教师关联的班级出错：" + e);
			e.printStackTrace();
		}
		return classList;
	}

	@RequestMapping("/saveClassCircle")
	@ResponseBody
	public String saveClassCircle(String content, String attachFile, Integer classId, String type) {
		WtrjEcomClassCircle classCircle = new WtrjEcomClassCircle();
		Integer userId = this.getCurrentUser().getUserId();
		logger.info("userId:" + userId);

		classCircle.setContent(content);
		attachFile = attachFile.replace(uploadUrl, "");
		classCircle.setAttachFile(attachFile);
		classCircle.setDelFlg(DELFLG_FALSE);
		classCircle.setPublishUserId(userId);
		classCircle.setPublishTime(new Date());
		classCircle.setClassId(classId);
		classCircle.setType(type);
		try {
			int ccId = classCircleService.insertWtrjEcomClassCircle(classCircle);
			System.out.println(ccId);

		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
			return "error";
		}

		return "success";
	}

	@RequestMapping("/searchWtrjEcomClassCircle")
	@ResponseBody
	public List<WtrjEcomClassCircle> searchWtrjEcomClassCircle(Integer classId, String type) {
		logger.debug("开始查询班级圈");
		List<WtrjEcomClassCircle> ccList = null;
		try {
			Integer userId = this.getCurrentUser().getUserId();
			logger.info("userId:" + userId);

			ccList = classCircleService.selectWtrjEcomClassCircle(userId, classId, type);
			if (null != ccList && ccList.size() > 0) {
				for (WtrjEcomClassCircle cc : ccList) {
					String att = cc.getAttachFile();
					att = att.replace(classCirclePath, uploadUrl + classCirclePath);
					cc.setAttachFile(att);
				}
			}
		} catch (Exception e) {
			logger.error("班级圈查询异常");
			e.printStackTrace();
		}
		return ccList;
	}

	/**
	 * 上传图片
	 * 
	 * @param file
	 * @param request
	 * @param response
	 * @throws Exception
	 */

	@RequestMapping(value = "/uploadPhoto")
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
	}
}
