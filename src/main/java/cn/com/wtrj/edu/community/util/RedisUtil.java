package cn.com.wtrj.edu.community.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.context.support.ServletContextPropertyPlaceholderConfigurer;

import cn.com.wtrj.jx.web.portal.model.entities.WtrjStudent;
import cn.com.wtrj.jx.web.portal.model.mt.entities.StudentDto;
import redis.clients.jedis.Jedis;

public class RedisUtil {
	private static Logger logger = Logger.getLogger(RedisUtil.class);
	
	private static final String TOKEN = "token";
	
	private static final String TOKEN_TIME = "tokenTime";
	
	public static void main(String[] args) {
		List<StudentDto>list=new ArrayList<>();
		list.add(new StudentDto(1,"潘志","锦江初中",2,3,"pz.jpg"));
		list.add(new StudentDto(2,"刘长平","锦江小学",1,5,"lcp.jpg"));
		list.add(new StudentDto(3,"覃川","锦江高中",3,2,"qc.jpg"));
		saveChildrenList("localhost", "15681902670", list);
		System.out.println(getChildrenList("localhost", "15681902670"));
		System.out.println(getCurrentStudent("localhost", "15681902670"));
		setCurrentStudent("localhost", "15681902670", 3);
		System.out.println(getCurrentStudent("localhost", "15681902670"));
	}
	
	/**
	 * 保存用户登录token
	 * @param redisServerIp
	 * @param token
	 * @param userId
	 * @param co 公司编码
	 * @param mendian 
	 */
	public static void saveToken(String redisServerIp, String token, String appId) {
		Jedis redis = new Jedis(redisServerIp);
		redis.hdel(appId, TOKEN, TOKEN_TIME);

		redis.hset(appId, TOKEN, token);
		redis.hset(appId, TOKEN_TIME,
				String.valueOf(Calendar.getInstance().getTimeInMillis()));
		
		redis.close();
	}

	/**
	 * 用户登录token验证
	 * 
	 * @param redisServerIp
	 * @param token
	 * @return token有效返回true,token无效返回false
	 */
	public static String getToken(String redisServerIp,String appId) {
		Jedis redis = new Jedis(redisServerIp);
		try {
		
			List<String> tokens = redis.hmget(appId, TOKEN);
			if (tokens != null && tokens.size() > 0) {
				
				List<String> times = redis.hmget(appId, TOKEN_TIME);
				
				if (times != null && times.size() > 0) {
					if (StringUtils.isEmpty(times.get(0))) {
						return null;
					}
					Long tokenTime = Long.valueOf(times.get(0));
					
					if ((Calendar.getInstance().getTimeInMillis() - tokenTime) < 6500000) {
						
						return tokens.get(0);
					}
				}
				return null;
			}
		} finally {
			redis.close();
		}
		
		return null;
	}
	
	/**
	 * 把家长和学生对应关系信息存入redis
	 * @param redisServerIp redis服务器IP
	 * @param phone 家长电话
	 * @param children 家长对应学生列表
	 */
	public static void saveChildrenList(String redisServerIp,String phone,List<StudentDto>children){
		Jedis jedis=new Jedis(redisServerIp);
		String childrenString=JsonUtils.objectToJson(children);
		jedis.set(phone, childrenString);
		jedis.close();
	}
	
	/**
	 * 根据手机号获取缓存中的学生列表信息
	 * @param redisServerIp redis服务器ip
	 * @param phone 家长电话
	 * @return 家长对应学生列表
	 */
	public static List<StudentDto> getChildrenList(String redisServerIp,String phone){
		Jedis jedis=new Jedis(redisServerIp);
		String childrenJsonArrayString=jedis.get(phone);
		List<StudentDto>children=JsonUtils.jsonToList(childrenJsonArrayString, StudentDto.class);
		jedis.close();
		return children;
	}
	
	/**
	 * 获取当前选择的学生信息,如果有学生列表，但未选则默认选中第一个，并写入缓存，如果该家长无学生列表，则返回null
	 * @param redisServerIp redis服务器ip
	 * @param phone 家长电话
	 * @return 学生Dto
	 */
	public static StudentDto getCurrentStudent(String redisServerIp,String phone){
		StudentDto stuSelected=null;
		List<StudentDto>children=getChildrenList(redisServerIp, phone);
		//如果学生列表为空，返回null
		if(children==null||children.isEmpty()){
			return null;
		}
		//学生列表不为空时,分两种情况，
		for (StudentDto studentDto : children) {
			if(studentDto.isSelected()){
				stuSelected=studentDto;
				break;
			}
		}
		
		//如果已经选择，则返回所选学生。
		if (stuSelected != null) {
			return stuSelected;
		}else{//初始时一个学生都未选择，默认选中第一个。
			children.get(0).setSelected(true);
			//写入缓存
			saveChildrenList(redisServerIp, phone, children);
			return children.get(0);
		}
	}
	
	/**
	 * 为指定手机号码的家长设置当前选择的学生信息
	 * @param redisServerIp redis服务器ip
	 * @param phone 家长电话
	 * @return studentId 学生ID
	 */
	public static void setCurrentStudent(String redisServerIp, String phone, int studentId) {
		// 获取当前家长在redis中缓存的学生列表
		List<StudentDto> children = getChildrenList(redisServerIp, phone);
		for (StudentDto studentDto : children) {
			if (studentDto.getId() == studentId) {
				studentDto.setSelected(true);
			} else {
				studentDto.setSelected(false);
			}
		}
		//重新写入缓存
		saveChildrenList(redisServerIp, phone, children);
	}
	
}
