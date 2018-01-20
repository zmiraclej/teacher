package cn.com.wtrj.edu.community.teacher.controller.base;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.common.Constant;
import cn.com.wtrj.jx.web.portal.service.common.IPermissionService;
import cn.com.wtrj.jx.web.portal.service.dto.notice.EcomPermisson;
import cn.com.wtrj.jx.web.portal.service.notice.IEcomPermissionService;
import cn.com.wtrj.jx.web.portal.service.setting.IRoleSchoolRelationshipService;

@Controller
@RequestMapping("/")
public class BaseController {

	@Autowired
	ServletContext servletContext;

	@Autowired
	IRoleSchoolRelationshipService roleSchoolService;
	
	@Value("${redis.server.ip}")
	protected String redis_server_ip;
	
	@Autowired
	protected IPermissionService permissionService;
	
	@Autowired
	IEcomPermissionService teacherAuthService;
	
	/**
	 * 获取Session用户
	 * 
	 * @return
	 */
	protected ShiroUser getCurrentUser() {
		return (ShiroUser) SecurityUtils.getSubject().getSession().getAttribute("wtrj_ecom_teacher_user");
	}
	
	/**
	 * 获取当前登录用户权限
	 * 
	 * @return
	 */
	protected EcomPermisson getPermission(){

		Object obj = SecurityUtils.getSubject().getSession().getAttribute("wtrj_ecom_teacher_auth");
		if (obj == null) {
			EcomPermisson p = teacherAuthService.searchTeacherPermisson(this.getCurrentUser().getUserId());

			SecurityUtils.getSubject().getSession().setAttribute("wtrj_ecom_teacher_auth", p);
			return p;
		} else {
			EcomPermisson p = (EcomPermisson) obj;
			if (p.getOwnedSchools() == null || p.getOwnedTeachers() == null) {
				p = teacherAuthService.searchTeacherPermisson(this.getCurrentUser().getUserId());
				SecurityUtils.getSubject().getSession().setAttribute("wtrj_ecom_teacher_auth", p);
			}
		}

		return (EcomPermisson) obj;
	} 
	
	protected void clearPermission(){
		SecurityUtils.getSubject().getSession().removeAttribute("wtrj_ecom_teacher_auth");
		SecurityUtils.getSubject().getSession().removeAttribute(Constant.NoticeSelectKey.ROLE_SELECT);
		SecurityUtils.getSubject().getSession().removeAttribute(Constant.NoticeSelectKey.COURSE_SELECT);
	}
	protected void setCxt(Map<String,Object> model, HttpServletRequest request){
		String contextPath = request.getContextPath();
		model.put("cxt", contextPath);
	}
}
