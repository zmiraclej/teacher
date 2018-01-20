package cn.com.wtrj.edu.community.teacher.bean;

/**
 * ${DESCRIPTION}
 *
 * @author
 * @create 2017-11-04 18:11
 **/
public class AddressQueryBean {

  private  String schoolCode;
  private Integer stage;
  private Integer grade;
  private Integer classNo;

  public String getSchoolCode() {
    return schoolCode;
  }

  public void setSchoolCode(String schoolCode) {
    this.schoolCode = schoolCode;
  }

  public Integer getStage() {
    return stage;
  }

  public void setStage(Integer stage) {
    this.stage = stage;
  }

  public Integer getGrade() {
    return grade;
  }

  public void setGrade(Integer grade) {
    this.grade = grade;
  }

  public Integer getClassNo() {
    return classNo;
  }

  public void setClassNo(Integer classNo) {
    this.classNo = classNo;
  }
}
