package cn.com.wtrj.edu.community.teacher.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.JsonObject;

import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.util.RedisUtil;
import cn.com.wtrj.edu.community.util.WeixinUtil;

@Controller
public class LoginController extends BaseController {
	private static Logger logger = Logger.getLogger(LoginController.class);

	@Autowired
	HttpSession session;

	@Value("${project.mode}")
	String projectMode;

	@Value("${appid}")
	String appid;

	@Value("${secret}")
	String secret;

	private static final String APP_ID = "wtrj-ecom-teacher";

	// private static final String REDIS_SERVER = "localhost";

	@RequestMapping("toShowLogin")
	public String showLogin(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "code") String code) {
		logger.debug("login：" + request.getRequestURL());

		try {

			this.doLogin(code);

		} catch (Exception e) {
			logger.error("登陆失败！", e);
			return "noauth";
		}
		return "showIndex";
	}

	@RequestMapping("toLogin")
	public String login(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "code") String code, Map<String, Object> model) {
		logger.debug("login：" + request.getRequestURL());

		try {
			super.setCxt(model, request);
			this.doLogin(code);

		} catch (Exception e) {
			logger.error("登陆失败！", e);
			return "noauth";
		}
		return "index";
	}

	@RequestMapping("toTestLogin")
	public String toTestLogin(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "code") String code, @RequestParam(value = "tel") String tel,
			Map<String, Object> model) {
		logger.debug("login：" + request.getRequestURL());

		try {
			if ("wtrj52189910".equals(code)) {
				super.setCxt(model, request);
				this.doLoginForTest(tel);
			} else {
				return "noauth";
			}

		} catch (Exception e) {
			logger.error("登陆失败！", e);
			return "noauth";
		}
		return "index";
	}

	@RequestMapping("toNcReport")
	public String toNcReport(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "code") String code, Model model) {
		logger.debug("login：" + request.getRequestURL());

		try {

			this.doLogin(code);

		} catch (Exception e) {
			logger.error("登陆失败！", e);
			return "noauth";
		}
		return "report";
	}

	@RequestMapping("toTeacherAddressBook")
	public String toTeacherAddressBook(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "code") String code, Model model) {
		logger.debug("toTeacherAddressBook：" + request.getRequestURL());

		try {

			this.doLogin(code);

		} catch (Exception e) {
			logger.error("登陆失败！", e);
			return "noauth";
		}
		return "report";
	}

	@RequestMapping("toZsReport")
	public String toZsReport(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "code") String code, Model model) {
		logger.debug("login：" + request.getRequestURL());

		try {

			this.doLogin(code);

		} catch (Exception e) {
			logger.error("登陆失败！", e);
			return "noauth";
		}
		return "zsHome";
	}

	@RequestMapping("toScoreReport")
	public String toScoreReport(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "code") String code, Model model) {
		logger.debug("login：" + request.getRequestURL());

		try {

			this.doLogin(code);

		} catch (Exception e) {
			logger.error("登陆失败！", e);
			return "noauth";
		}
		return "scoreHome";
	}

	private void doLoginForTest(String tel) {
		UsernamePasswordToken upToken = new UsernamePasswordToken(tel, "weixin_user");
		// UsernamePasswordToken upToken = new UsernamePasswordToken("15681902670",
		// "weixin_user");

		// UsernamePasswordToken upToken = new UsernamePasswordToken("13890113893",
		// "weixin_user");

		Subject user = SecurityUtils.getSubject();
		user.login(upToken);
	}

	private void doLogin(String code) {

		// 本地开发环境不对token进行缓存
		if ("development".equals(projectMode)) {
			UsernamePasswordToken upToken = new UsernamePasswordToken("13608059626", "weixin_user");
			// UsernamePasswordToken upToken = new UsernamePasswordToken("15681902670",
			// "weixin_user");

			// UsernamePasswordToken upToken = new UsernamePasswordToken("13890113893",
			// "weixin_user");

			Subject user = SecurityUtils.getSubject();
			user.login(upToken);
		} else {// 正式环境受限于微信端1天2000次的token获取次数，使用redis对token进行缓存
			String token = RedisUtil.getToken(redis_server_ip, APP_ID);
			if (StringUtils.isEmpty(token)) {
				logger.info("token超时,重新获取");
				token = WeixinUtil.getToken(appid, secret);
				RedisUtil.saveToken(redis_server_ip, token, APP_ID);
			}

			logger.info("token:" + token + " [code:" + code + "]");

			JsonObject userInfo = WeixinUtil.getUserInfo(token, code);

			logger.info(userInfo);

			String userId = userInfo.get("UserId").getAsString();
			logger.info(userInfo.toString());

			JsonObject userInfoDetail = WeixinUtil.getUserInfoByUserId(token, userId);

			UsernamePasswordToken upToken = new UsernamePasswordToken(userInfoDetail.get("mobile").getAsString(),
					"weixin_user");
			Subject user = SecurityUtils.getSubject();
			user.login(upToken);
		}
	}
}
