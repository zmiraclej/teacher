package cn.com.wtrj.edu.community.util;

import java.security.MessageDigest;


/**
 * 
 * MD5工具类
 *
 */
public class MD5Util {
    public final static String MD5(String s) {
        char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

        try {
            byte[] btInput = s.getBytes();
            // 获得MD5摘要算法的 MessageDigest对象,该对象实现指定的摘要算法功能
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节数组更新摘要
            mdInst.update(btInput);
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 
     * @param s 源串
     * @param isShort 是否短字符串
     * @param isUpper 是否大写
     * @return
     */
    public static String MD5(String s,Boolean isShort,Boolean isUpper){
    	String md5Str = MD5(s);
    	if(!isUpper){
    		if(!isShort){
    			return md5Str;
    		}else{
    			return md5Str.substring(8, 24);
    		}
    	}else{
    		if(!isShort){
    			return md5Str.toUpperCase();
    		}else{
    			return md5Str.substring(16).toUpperCase();
    		}
    	}
    }

    public static void main(String[] args) {
//        System.out.println(MD5("123456", true, true));
        System.out.println(MD5("123456", false, false));
//        System.out.println(MD5("123456", true, false));
//        System.out.println(MD5("123456", false, true));
//      System.out.println(MD5("wtrj1688"));
    }
}
