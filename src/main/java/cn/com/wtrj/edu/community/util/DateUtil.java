package cn.com.wtrj.edu.community.util;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 时间工具类 
 */
public class DateUtil{

	//默认显示日期的格式
	public static final String DATAFORMAT_STR = "yyyy-MM-dd";
	
	public static final String DATAFORMAT_HM_STR = "yyyy-MM-dd HH:mm";
	
	public static final String DATAFORMAT_LOCAL_STR = "yyyy年M月d日 H时m分";
	
	//默认显示日期的格式
	public static final String DATAFORMAT_FULL_STR = "yyyy-MM-dd HH:mm:ss";
	public static final String DATAFORMAT_LOCAL_FULL_STR = "yyyy/MM/dd HH:mm:ss";
		
    /**
     * 时间字符串转换成Date类型
    * @param dateStr
    * @param format
    * @return
     */
    public static Date dateStrToDate(String dateStr,String format){
    	SimpleDateFormat sdf = new SimpleDateFormat(format);
    	try {
			return sdf.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
    } 
    
    public static String dateTodateStr(Date date,String format){
    	SimpleDateFormat sdf = new SimpleDateFormat(format);
    	try {
			return sdf.format(date);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    } 
}

