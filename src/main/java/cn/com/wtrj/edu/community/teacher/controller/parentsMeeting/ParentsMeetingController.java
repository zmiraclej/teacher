package cn.com.wtrj.edu.community.teacher.controller.parentsMeeting;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.wtrj.edu.community.request.formBean.ParentMeetingForm;
import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.shiro.ShiroUser;
import cn.com.wtrj.edu.community.teacher.common.Constant.RetCode;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.util.DateUtil;
import cn.com.wtrj.edu.community.util.MD5Util;
import cn.com.wtrj.edu.community.util.QRCodeUtil;
import cn.com.wtrj.edu.community.util.RandomCodeUtil;
import cn.com.wtrj.edu.community.util.WeixinUtil;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomParentsMeeting;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjEcomPmtNotice;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjParent;
import cn.com.wtrj.jx.web.portal.model.mt.entities.PrentsMeetingRespDto;
import cn.com.wtrj.jx.web.portal.model.mt.entities.StudentRespWithClass;
import cn.com.wtrj.jx.web.portal.service.ParentsMeeting.IParentsMeetingService;
import cn.com.wtrj.jx.web.portal.service.parent.IWtrjEcomParentService;
import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.bean.WxCpMessage;

@Controller
@RequestMapping("/parentsMeeting")
public class ParentsMeetingController extends BaseController {

	private static Logger logger = Logger.getLogger(ParentsMeetingController.class);
	@Autowired
	private IParentsMeetingService parentsMeetingService;

	@Autowired
	private IWtrjEcomParentService wtrjEcomParentService;

	@Value("${upload.qcode.path}")
	private String qcodeUrl;
	@Value("${send_to_appid}")
	String appid;
	@Value("${send_to_secret}")
	String secret;
	@Value("${send_to_agent_id}")
	Integer agentId;

	/**
	 * 通过教师找到对应的班级学生
	 * 
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/searchStudentsByTeacherId")
	public BaseRet<List<StudentRespWithClass>> searchStudentsByTeacherId() {
		logger.info("查询班主任对应下的学生集合");
		BaseRet<List<StudentRespWithClass>> ret = new BaseRet<List<StudentRespWithClass>>();
		try {
			ShiroUser teacher = getCurrentUser();
			List<StudentRespWithClass> list = parentsMeetingService.searchStudentsByTeacherId(teacher.getUserId());
			ret.setData(list);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("查询班主任对应下的学生集合结束");
		return ret;
	}

	/**
	 * 查询教师对应的家长会
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchPrentsMeetingByTeacherId")
	public BaseRet<List<PrentsMeetingRespDto>> searchPrentsMeetingByTeacherId() {
		logger.info("查询教师对应的家长会集合");
		BaseRet<List<PrentsMeetingRespDto>> ret = new BaseRet<List<PrentsMeetingRespDto>>();
		try {
			ShiroUser teacher = getCurrentUser();
			List<PrentsMeetingRespDto> list = parentsMeetingService.searchPrentsMeetingByTeacherId(teacher.getUserId());
			ret.setData(list);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("查询教师对应的家长会集合结束");
		return ret;
	}

	/**
	 * 通过教师id查询班级id
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchClassIdByTeacherId")
	public BaseRet<Integer> searchClassIdByTeacherId(Integer id) {
		logger.info("通过教师id查询班级id");
		BaseRet<Integer> ret = new BaseRet<Integer>();
		try {

			Integer classId = parentsMeetingService.searchClassIdByTeacherId(id);
			ret.setData(classId);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("通过教师id查询班级id结束");
		return ret;
	}

	/**
	 * 查看家长会详情List
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchParentsMeetingDetail")
	public BaseRet<List<WtrjEcomPmtNotice>> searchParentsMeetingDetail(Integer id) {
		logger.info("通过MeetingId查询家长会详情");
		BaseRet<List<WtrjEcomPmtNotice>> ret = new BaseRet<List<WtrjEcomPmtNotice>>();
		try {

			List<WtrjEcomPmtNotice> list = parentsMeetingService.searchParentsMeetingDetail(id);
			ret.setData(list);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("通过MeetingId查询家长会详情结束");
		return ret;
	}

	/**
	 * 查看单个家长会对象
	 * 
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchParentsMeetingById")
	public BaseRet<PrentsMeetingRespDto> searchParentsMeetingById(Integer id) {
		logger.info("通过id查询家长会对象");
		BaseRet<PrentsMeetingRespDto> ret = new BaseRet<PrentsMeetingRespDto>();
		try {

			PrentsMeetingRespDto prentsMeeting = parentsMeetingService.searchParentsMeetingById(id);
			ret.setData(prentsMeeting);
			ret.setMsg("查询成功");
		} catch (Exception e) {
			logger.error("异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("查询失败");
		}
		ret.setCode(RetCode.SUCCESS);
		logger.info("通过id查询家长会对象结束");
		return ret;
	}

	/**
	 * 发布家长会
	 * 
	 * @param parentMeetingForm
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/publishPt")
	public BaseRet<String> publishPt(ParentMeetingForm parentMeetingForm) {
		logger.info("发布家长会");
		BaseRet<String> ret = new BaseRet<String>();
		try {
			ShiroUser teacher = getCurrentUser();
			// 家长会记录
			Integer classId = parentsMeetingService.searchClassIdByTeacherId(teacher.getUserId());
			DateUtil.dateStrToDate(parentMeetingForm.getStartTime(), DateUtil.DATAFORMAT_HM_STR);
			WtrjEcomParentsMeeting pmt = new WtrjEcomParentsMeeting();
			pmt.setClassId(classId);
			pmt.setTheme(parentMeetingForm.getTheme());
			pmt.setCreateTime(new Date());
			pmt.setMettingDate(DateUtil.dateStrToDate(parentMeetingForm.getStartTime(), DateUtil.DATAFORMAT_HM_STR));
			pmt.setPlace(parentMeetingForm.getPlace());
			pmt.setStartTime(DateUtil.dateStrToDate(parentMeetingForm.getStartTime(), DateUtil.DATAFORMAT_HM_STR));
			pmt.setEndTime(DateUtil.dateStrToDate(parentMeetingForm.getEndTime(), DateUtil.DATAFORMAT_HM_STR));
			pmt.setTeacherId(teacher.getUserId());
			pmt.setUpdateTime(new Date());
			// 保存家长会记录
			// 生成唯一卡号
			String cardNo = RandomCodeUtil.getRandomCode(8);
			// 生成二维码
			String text = cardNo + QRCodeUtil.SUF_CODE;
			String qtext = QRCodeUtil.PRE_CODE + text.substring(0, text.length() - 16) + MD5Util.MD5(text, true, true);
			String fileUrl = qcodeUrl + cardNo + ".jpg";
			String codeUrl = qcodeUrl;
			String appId = appid;
			String seCret = secret;
			Integer agentid = agentId;
			WxCpService wxCpService = WeixinUtil.getWxCpService(appid, secret);
			String mediaId = WeixinUtil.uploadMedia(wxCpService.getAccessToken(), "image", fileUrl);
			parentsMeetingService.publishPt(pmt, cardNo, qtext, wxCpService, mediaId, codeUrl, appId, seCret, fileUrl,
					agentid);

			// parentsMeetingService.savePm(pmt);
			// 通过班级id查询学生
			/*
			 * List<StudentRespWithClass>
			 * sList=parentsMeetingService.searchStudentByClassId(classId);
			 * if(sList!=null && sList.size()>0){ for(int
			 * i=0;i<sList.size();i++){ List<WtrjParent> parentsList =
			 * wtrjEcomParentService.findWtrjParentsByStudentNo(sList.get(i).
			 * getStudentNo()); WtrjEcomPmtNotice pmtNotice=new
			 * WtrjEcomPmtNotice(); pmtNotice.setCreateTime(new Date());
			 * pmtNotice.setMettingId(pmt.getId()-1);
			 * pmtNotice.setStudentName(sList.get(i).getName());
			 * pmtNotice.setStudentNo(sList.get(i).getStudentNo());
			 * pmtNotice.setUpdateTime(new Date()); if(parentsList!=null&&
			 * parentsList.size()>0){ for(WtrjParent parent:parentsList){ //
			 * 生成唯一卡号 String cardNo = RandomCodeUtil.getRandomCode(8); // 生成二维码
			 * String text = cardNo + QRCodeUtil.SUF_CODE; String qtext =
			 * QRCodeUtil.PRE_CODE + text.substring(0, text.length() - 16) +
			 * MD5Util.MD5(text, true, true); try { // 生成二维码并保存到指定盘符(以卡号命名)
			 * QRCodeUtil.encode(qtext, "", qcodeUrl + cardNo + ".jpg", true); }
			 * catch (Exception e) { logger.error("生成二维码失败："+e); } // 将二维码发送给家长
			 * String fileUrl = qcodeUrl + cardNo + ".jpg"; WxCpService
			 * wxCpService = WeixinUtil.getWxCpService(appid,secret); String
			 * mediaId = WeixinUtil.uploadMedia(wxCpService.getAccessToken(),
			 * "image", fileUrl); WxCpMessage wxTextMessage =
			 * WxCpMessage.TEXT().agentId(agentId).toUser(parent.getPhone())//
			 * parent.getPhone()
			 * .content("亲爱的家长：你好，我是你孩子的班主任。请准时参加于"+DateUtil.dateTodateStr(pmt.
			 * getStartTime(),
			 * DateUtil.DATAFORMAT_FULL_STR)+"举行的家长会，到校时请用下面的二维码在学校门口扫码进校。").
			 * build(); //parent.getPhone() WxCpMessage wxImageMessage =
			 * WxCpMessage.IMAGE().agentId(agentId).toUser(parent.getPhone()).
			 * mediaId(mediaId).build(); wxCpService.messageSend(wxTextMessage);
			 * wxCpService.messageSend(wxImageMessage); }
			 * pmtNotice.setNoticeStatus("02");
			 * parentsMeetingService.savePmtNotice(pmtNotice); }else{
			 * pmtNotice.setNoticeStatus("01");
			 * parentsMeetingService.savePmtNotice(pmtNotice); } }
			 * 
			 * }
			 */
			ret.setCode(RetCode.SUCCESS);
		} catch (Exception e) {
			logger.error("发布家长会异常中止!", e);
			ret.setCode(RetCode.ERROR);
			ret.setMsg("发布家长会失败");
		}
		ret.setMsg("发布家长会成功");
		logger.info("发布家长会结束");
		return ret;
	}

}
