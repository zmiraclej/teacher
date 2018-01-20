package cn.com.wtrj.edu.community.teacher.controller.uisel;

import cn.com.wtrj.edu.community.response.BaseRet;
import cn.com.wtrj.edu.community.teacher.bean.AddressQueryBean;
import cn.com.wtrj.edu.community.teacher.bean.UiSelectBean;
import cn.com.wtrj.edu.community.teacher.common.Constant.RetCode;
import cn.com.wtrj.edu.community.teacher.controller.base.BaseController;
import cn.com.wtrj.edu.community.teacher.response.ClassParentAdreeBook;
import cn.com.wtrj.edu.community.teacher.response.ParentAddressBook;
import cn.com.wtrj.edu.community.util.NamesGenerationUtil;
import cn.com.wtrj.jx.web.portal.model.entities.DictItem;
import cn.com.wtrj.jx.web.portal.model.entities.WtrjSchoolInfo;
import cn.com.wtrj.jx.web.portal.service.ITeacherService;
import cn.com.wtrj.jx.web.portal.service.dto.notice.EcomPermisson;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeClassKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeGradeKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeParentKey;
import cn.com.wtrj.jx.web.portal.service.dto.notice.NoticeTeacherKey;
import cn.com.wtrj.jx.web.portal.service.notice.IEcomNoticeService;
import cn.com.wtrj.jx.web.portal.service.notice.IEcomPermissionService;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/grade")
public class GradeController extends BaseController {

  private static Logger logger = Logger.getLogger(GradeController.class);


  @Autowired
  IEcomNoticeService noticeService;

  @Autowired
  IEcomPermissionService permissionService;

  @Autowired
  IEcomPermissionService teacherAuthService;

  @Autowired
  ITeacherService teacherService;

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
   * 查询教职工可以查看的所有学校
   *
   * @param model map
   */
  @RequestMapping("/querySchools")
  @ResponseBody
  public List<UiSelectBean> querySchools(Map<String, Object> model) {
    try {
      EcomPermisson permisson = this.getPermission();
      List<UiSelectBean> arry = new ArrayList<>();
      List<WtrjSchoolInfo> dtos = permisson.getOwnedSchoolInfos();

      //添加全部标签
      //addAll(arry);
      for (WtrjSchoolInfo dto : dtos) {
        UiSelectBean gi = new UiSelectBean();
        gi.setTitle(dto.getName());
        gi.setValue(dto.getCode());
        arry.add(gi);

      }
      sortUiSelectBean(arry);
      return arry;
    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      return null;
    }
  }

  /**
   * 查询教职工可以查看的所有学部
   */
  @RequestMapping("/queryStages")
  @ResponseBody
  public List<UiSelectBean> queryStages(String schoolCode) {
    try {
      EcomPermisson permisson = this.getPermission();
      List<UiSelectBean> arry = new ArrayList<>();
      //添加全部标签
      addAll(arry);
      List<NoticeGradeKey> dtos = permisson.getOwnedGrades();
      Map<Integer, String> map = new HashMap<>();
      for (NoticeGradeKey dto : dtos) {
        if (map.containsKey(dto.getStage())) {
          continue;
        }
        UiSelectBean gi = new UiSelectBean();
        gi.setTitle(NamesGenerationUtil.genStageName(dto.getStage()));
        gi.setValue(dto.getStage() + "");
        if (!StringUtils.isEmpty(schoolCode)) {
          if (schoolCode.equals(dto.getSchoolCode())) {
            arry.add(gi);
            map.put(dto.getStage(), dto.getSchoolCode());
          }
        } else {
          //schoolcode is null, 查看全部
          arry.add(gi);
          map.put(dto.getStage(), dto.getSchoolCode());
        }
      }
      sortUiSelectBean(arry);

      return arry;
    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      return null;
    }
  }

  private void sortUiSelectBean(List<UiSelectBean> arry) {
    // 排序处理
    Comparator<UiSelectBean> ct = new Comparator<UiSelectBean>() {
      @Override
      public int compare(UiSelectBean o1, UiSelectBean o2) {
        int rs = o1.getValue().compareTo(o2.getValue());
        if (rs < 0) {
          return -1;
        } else if (rs > 0) {
          return 1;
        }
        return 0;
      }
    };

    Collections.sort(arry, ct);
  }

  /**
   * 查询教职工可以查看的所有年级
   *
   * @param bean  AddressQueryBean
   */
  @RequestMapping("/queryGradesByEmp")
  @ResponseBody
  public List<UiSelectBean> queryGradesByEmp(@ModelAttribute AddressQueryBean bean ) {
    try {
      EcomPermisson permisson = this.getPermission();
      List<UiSelectBean> arry = new ArrayList<>();
      //添加全部标签
      addAll(arry);
      List<NoticeGradeKey> dtos = permisson.getOwnedGrades();

      for (NoticeGradeKey dto : dtos) {
        System.out.println(" stage = " + dto.getStage() + " | " + bean.getStage());
        if(bean.getSchoolCode() != null && bean.getStage() != null) {
          if(  bean.getSchoolCode().equals(dto.getSchoolCode()) && bean.getStage() == dto.getStage()){
            assambleGradeUiBean(arry,dto);
          }
        }else if(bean.getSchoolCode() != null && bean.getStage() == null) {
          if(  bean.getSchoolCode().equals(dto.getSchoolCode())){
            assambleGradeUiBean(arry,dto);
          }
        }else if(bean.getSchoolCode() == null && bean.getStage() != null) {
          //in fact, if no schoolcode ,return null;
          if( bean.getStage() == dto.getStage()){
            assambleGradeUiBean(arry,dto);
          }
        }else if(bean.getSchoolCode() == null && bean.getStage() == null) {
          //administration
          assambleGradeUiBean(arry,dto);
        }

      }
      sortUiSelectBean(arry);
      return arry;
    } catch (Exception e) {
      logger.error(e.getMessage(), e);
      return null;
    }
  }
  private void assambleGradeUiBean(List<UiSelectBean> arry,NoticeGradeKey dto){
    UiSelectBean gi = new UiSelectBean();
    gi.setTitle(NamesGenerationUtil.genGradeName(dto.getStage(), dto.getGrade()));
    gi.setValue(dto.getSchoolCode() + "_" + dto.getStage() + "_" + dto.getGrade());
    arry.add(gi);
  }

  @ResponseBody
  @RequestMapping("/queryClasses")
  public List<UiSelectBean> searchTeacherClasses( @ModelAttribute AddressQueryBean bean ) {
    logger.info("跳转到教师班级选择页面 开始");
    List<UiSelectBean> arry = new ArrayList<>();
    //添加全部标签
    addAll(arry);

    try {
      EcomPermisson permisson = this.getPermission();
      List<NoticeClassKey> dtos = permisson.getOwnedClasses();
      for (NoticeClassKey dto : dtos) {
        if(bean.getStage() == null && bean.getGrade() != null){
          if (dto.getSchoolCode().equals(bean.getSchoolCode()) && dto.getGrade() == bean.getGrade()) {
            assambleNoticeUiselectBean(arry,dto);
          }
        }else if(bean.getStage() == null && bean.getGrade() == null){
          if (dto.getSchoolCode().equals(bean.getSchoolCode()) ) {
            assambleNoticeUiselectBean(arry,dto);
          }
        }else if(bean.getStage() != null && bean.getGrade() == null){
          if (dto.getSchoolCode().equals(bean.getSchoolCode()) && dto.getStage() == bean.getStage() ) {
            assambleNoticeUiselectBean(arry,dto);
          }
        }else{
          if (dto.getSchoolCode().equals(bean.getSchoolCode()) && dto.getStage() == bean.getStage() && dto.getGrade() == bean.getGrade() ) {
            assambleNoticeUiselectBean(arry,dto);
          }
        }

      }
      sortUiSelectBean(arry);
      return arry;
    } catch (Exception e) {
      logger.error("跳转到教师班级选择页面 异常", e);
    }

    logger.info("跳转到教师班级选择页面 结束");
    return null;
  }
  private void assambleNoticeUiselectBean(List<UiSelectBean> arry,NoticeClassKey dto){
    UiSelectBean gi = new UiSelectBean();
    gi.setTitle(dto.getClassName());
    gi.setValue(dto.getSchoolCode() + "_" + dto.getStage() + "_" + dto.getGrade() + "_" + dto .getClassNo());
    arry.add(gi);
  }

  @ResponseBody
  @RequestMapping("/scoreManage/stages")
  public List<DictItem> findStageBySchoolCode(String schoolCode) {
    EcomPermisson permisson = this.getPermission();
    //List<Integer> stages = scoreManageService.findTeacherStages(schoolCode, this.getCurrentUser().getTeacherId());

    List<DictItem> items = null;
    /*if (stages != null && stages.size() > 0) {
      items = Lists.newArrayList();
      for (Integer stage : stages) {
        String code = stage.toString();
        String name = "小学";
        if (stage == 2) {
          name = "初中";
        }
        if (stage == 3) {
          name = "高中";
        }
        DictItem item = new DictItem(code, name);
        items.add(item);
      }
      items.get(0).setSelected(true);*/
    //}
    return items;

  }

  /**
   * 根据权限，角色和科目查询教师信息
   */
  @ResponseBody
  @RequestMapping("/searchTeachers")
  public List<UiSelectBean> searchTeachers(@ModelAttribute AddressQueryBean bean) {
    logger.info("跳转到教师选择页面 开始");
    try {
      String value = "";
      Map<String,String> map = new HashMap<>();
      EcomPermisson permisson = this.getPermission();
      List<NoticeTeacherKey> dtos = permisson.getOwnedTeachers();
      List<UiSelectBean> classInfos = new ArrayList<>();
      if (StringUtils.isNotBlank(bean.getSchoolCode()) ) {
        UiSelectBean gi = null;
        for (NoticeTeacherKey dto : dtos) {
          if (!bean.getSchoolCode().equals(dto.getSchoolCode())) {
            continue;
          }
          if (bean.getStage() != null && !bean.getStage().equals(dto.getStage())) {
            continue;
          }
          if (bean.getGrade() != null && bean.getGrade() > 0) {
            if (!bean.getGrade().equals(dto.getGrade())) {
              continue;
            }
          }
          if (bean.getClassNo() != null && bean.getClassNo() > 0) {
            if (!bean.getClassNo().equals(dto.getClassNo())) {
              continue;
            }
          }
          /*if (StringUtils.isNotBlank(role)) {
            if (!role.equals(dto.getRole())) {
              continue;
            }
          }*/
          //根据手机号码排重
          if(map.containsKey(dto.getTeacherPhone())){
            continue;
          }else{
            map.put(dto.getTeacherPhone(),value);
          }
          gi = new UiSelectBean();
          gi.setTitle(dto.getTeacherName());
          gi.setValue(dto.getTeacherPhone());
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
   * 新增一个select
   * @param arry
   */
  private void addAll(List<UiSelectBean> arry){

    UiSelectBean gi = new UiSelectBean();
    gi.setTitle("全部");
    gi.setValue("");
    arry.add(gi);
  }

  /**
   * 查询家长联系信息
   * @return baseret
   */
  @ResponseBody
  @RequestMapping(value = "/searchParentsPhone")
  public BaseRet<List<ClassParentAdreeBook>> searchParentsPhone(@ModelAttribute AddressQueryBean bean) {
    logger.info("查询班主任对应下的学生家长通讯录集合");
    BaseRet<List<ClassParentAdreeBook>> ret = new BaseRet<>();
    try {
      EcomPermisson permission = this.getPermission();
      List<NoticeParentKey> list = permission.getOwnedParents();
      Map<String, List<NoticeParentKey>> map = new HashMap<>();

      for (NoticeParentKey r : list) {
        List<NoticeParentKey> ps = map.get(r.getClassName());
        if (ps == null) {
          ps = new ArrayList<>();
        }
        ps.add(r);

        map.put(r.getClassName(), ps);
      }

      String value = "";
      Map<String,String> phoneMap = new HashMap<>();
      List<ClassParentAdreeBook> ads = new ArrayList<>();
      for (String key : map.keySet()) {
        ClassParentAdreeBook ad = new ClassParentAdreeBook();
        ad.setClassName(key);

        List<ParentAddressBook> parents = new ArrayList<>();
        List<NoticeParentKey> ps = map.get(key);
        for (NoticeParentKey p : ps) {
          if (!bean.getSchoolCode().equals(p.getSchoolCode())) {
            continue;
          }
          if (bean.getStage() != null && !bean.getStage().equals(p.getStage())) {
            continue;
          }
          if (bean.getGrade() != null && bean.getGrade() > 0) {
            if (!bean.getGrade().equals(p.getGrade())) {
              continue;
            }
          }
          if (bean.getClassNo() != null && bean.getClassNo() > 0) {
            if (!bean.getClassNo().equals(p.getClassNo())) {
              continue;
            }
          }
          //根据手机号码排重
          if(phoneMap.containsKey(p.getParentPhone())){
            continue;
          }else{
            phoneMap.put(p.getParentPhone(),value);
          }
          ParentAddressBook address = new ParentAddressBook();
          address.setParentName(StringUtils.isEmpty(p.getParentName()) ? "家长": p.getParentName());
          address.setPhone(p.getParentPhone());
          address.setStudentName(p.getStudentName());
          parents.add(address);

          ad.setClassNo(p.getClassNo());
          ad.setGrade(p.getGrade());
          ad.setStage(p.getStage());
          ad.setSchoolCode(p.getSchoolCode());
        }
        if(parents.size() > 0) {
          ad.setParents(parents);
          ads.add(ad);
        }

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
   * 根据手机号码查询教师信息
   */
  @ResponseBody
  @RequestMapping("/queryTeacherByPhone")
  public List<UiSelectBean> queryTeacherByPhone(String phone) {
    logger.info("queryTeacherByPhone 开始");
    if (StringUtils.isEmpty(phone)) {
      return new ArrayList<>();
    }
    try {
      EcomPermisson permisson = this.getPermission();
      List<NoticeTeacherKey> dtos = permisson.getOwnedTeachers();
      List<UiSelectBean> classInfos = new ArrayList<>();
      UiSelectBean gi;
      String value = "";
      Map<String,String> phoneMap = new HashMap<>();
      for (NoticeTeacherKey dto : dtos) {
        if (dto.getTeacherPhone().equals(phone)) {

          //根据手机号码排重
          if(phoneMap.containsKey(dto.getTeacherPhone())){
            continue;
          }else{
            phoneMap.put(dto.getTeacherPhone(),value);
          }
          gi = new UiSelectBean();
          gi.setTitle(dto.getTeacherName());
          gi.setValue(dto.getTeacherPhone());
          classInfos.add(gi);
          break;//list中可能有同一老师多条记录，而只需返回一条
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
   * 根据教师姓名查询教师信息
   */
  @ResponseBody
  @RequestMapping("/queryTeacherByName")
  public List<UiSelectBean> queryTeacherByName(String name) {
    logger.info("queryTeacherByName 开始");
    if (StringUtils.isEmpty(name)) {
      return new ArrayList<>();
    }
    String value = "";
    Map<String,String> phoneMap = new HashMap<>();
    try {
      EcomPermisson permisson = this.getPermission();
      List<NoticeTeacherKey> dtos = permisson.getOwnedTeachers();
      List<UiSelectBean> classInfos = new ArrayList<>();
      UiSelectBean gi;
      for (NoticeTeacherKey dto : dtos) {
        if (!dto.getTeacherName().equals(name)) {
          continue;
        }

        //根据手机号码排重
        if(phoneMap.containsKey(dto.getTeacherPhone())){
          continue;
        }else{
          phoneMap.put(dto.getTeacherPhone(),value);
        }
        gi = new UiSelectBean();
        gi.setTitle(dto.getTeacherName());
        gi.setValue(dto.getTeacherPhone());
        classInfos.add(gi);
      }

      return classInfos;
    } catch (Exception e) {
      logger.error("跳转到教师班级选择页面 异常", e);
    }

    logger.info("跳转到教师选择页面 结束");
    return null;
  }
  /**
   * 根据手机号查询家长联系信息
   * @return baseret
   */
  @ResponseBody
  @RequestMapping(value = "/queryParentsByPhone")
  public BaseRet<List<ClassParentAdreeBook>> queryParentsByPhone(String phone) {
    logger.info("queryParentsByPhone ");
    BaseRet<List<ClassParentAdreeBook>> ret = new BaseRet<>();
    try {
      EcomPermisson permission = this.getPermission();
      List<NoticeParentKey> list = permission.getOwnedParents();
      Map<String, List<NoticeParentKey>> map = new HashMap<>();

      for (NoticeParentKey r : list) {
        List<NoticeParentKey> ps = map.get(r.getClassName());
        if (ps == null) {
          ps = new ArrayList<>();
        }
        ps.add(r);
        map.put(r.getClassName(), ps);
      }
      String value = "";
      Map<String, String> phoneMap = new HashMap<>();
      List<ClassParentAdreeBook> ads = new ArrayList<>();
      for (String key : map.keySet()) {
        ClassParentAdreeBook ad = new ClassParentAdreeBook();
        ad.setClassName(key);

        List<ParentAddressBook> parents = new ArrayList<>();
        List<NoticeParentKey> ps = map.get(key);
        for (NoticeParentKey p : ps) {
          if(!p.getParentPhone().equals(phone)) continue;
          //根据手机号码排重
          if(phoneMap.containsKey(p.getParentPhone())){
            continue;
          }else{
            phoneMap.put(p.getParentPhone(),value);
          }
          ParentAddressBook address = new ParentAddressBook();
          address.setParentName(StringUtils.isEmpty(p.getParentName()) ? "家长": p.getParentName());
          address.setPhone(p.getParentPhone());
          address.setStudentName(p.getStudentName());
          parents.add(address);

          ad.setClassNo(p.getClassNo());
          ad.setGrade(p.getGrade());
          ad.setStage(p.getStage());
          ad.setSchoolCode(p.getSchoolCode());
        }
        if(parents.size() > 0) {
          ad.setParents(parents);
          ads.add(ad);
        }

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
   * 根据姓名查询家长联系信息
   * @return baseret
   */
  @ResponseBody
  @RequestMapping(value = "/queryParentsByName")
  public BaseRet<List<ClassParentAdreeBook>> queryParentsByName(String name) {
    logger.info("queryParentsByName ");
    BaseRet<List<ClassParentAdreeBook>> ret = new BaseRet<>();
    try {
      EcomPermisson permission = this.getPermission();
      List<NoticeParentKey> list = permission.getOwnedParents();
      Map<String, List<NoticeParentKey>> map = new HashMap<>();

      for (NoticeParentKey r : list) {
        List<NoticeParentKey> ps = map.get(r.getClassName());
        if (ps == null) {
          ps = new ArrayList<>();
        }
        ps.add(r);
        map.put(r.getClassName(), ps);
      }
      String value = "";
      Map<String, String> phoneMap = new HashMap<>();
      List<ClassParentAdreeBook> ads = new ArrayList<>();
      for (String key : map.keySet()) {
        ClassParentAdreeBook ad = new ClassParentAdreeBook();
        ad.setClassName(key);

        List<ParentAddressBook> parents = new ArrayList<>();
        List<NoticeParentKey> ps = map.get(key);
        for (NoticeParentKey p : ps) {
          if(p == null || p.getStudentName() == null) continue;
          if(!p.getStudentName().equals(name)) continue;
          //根据手机号码排重
          if(phoneMap.containsKey(p.getParentPhone())){
            continue;
          }else{
            phoneMap.put(p.getParentPhone(),value);
          }
          ParentAddressBook address = new ParentAddressBook();
          address.setParentName(StringUtils.isEmpty(p.getParentName()) ? "家长": p.getParentName());
          address.setPhone(p.getParentPhone());
          address.setStudentName(p.getStudentName());
          parents.add(address);

          ad.setClassNo(p.getClassNo());
          ad.setGrade(p.getGrade());
          ad.setStage(p.getStage());
          ad.setSchoolCode(p.getSchoolCode());
        }
        if(parents.size() > 0) {
          ad.setParents(parents);
          ads.add(ad);
        }

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
}
