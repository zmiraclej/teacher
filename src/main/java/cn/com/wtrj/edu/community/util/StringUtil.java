package cn.com.wtrj.edu.community.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class StringUtil {
	 public static String  getValueByKey(String key){
	        Properties pro=new Properties();
	        InputStream in=Thread.currentThread().getContextClassLoader().getResourceAsStream("classpath:production/setting.properties");
	        try {
	            pro.load(in);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	       return (String)pro.get(key);
	    }
}
