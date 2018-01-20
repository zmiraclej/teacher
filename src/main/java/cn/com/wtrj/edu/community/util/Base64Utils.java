package cn.com.wtrj.edu.community.util;

import java.util.Scanner;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

/**
 * base64工具类
 * @author zhongdt
 * @date 2015-2-2
 *
 */
 public class Base64Utils{
	/**
	 * base64编码
	 * @param 字符串
	 * @return 编码串
	 */
	public static String encode(String str){
		if(StringUtils.isEmpty(str)){
			return null;
		}
		return new String(Base64.encodeBase64(str.getBytes()));
	}
	
	
	/**
	 * base64解码
	 * @param 编码串
	 * @return 解码后的串
	 */
	public static String decode(String str){
		if(StringUtils.isEmpty(str)){
			return null;
		}
		return new String(Base64.decodeBase64(str));
	}
	
	public static void main(String[] args) {
		Scanner input=new Scanner(System.in);
		System.out.println("加密1/解密2");
		int choice=input.nextInt();
		if(choice==1){
			System.out.println("输入待加密的字符串");
			String source=input.next();
			System.out.println("加密后:"+encode(source));
		}
		if(choice==2){
			System.out.println("输入待解密的字符串");//hjkahsd2312.///asd'[1` aasd
			String source=input.next();
			System.out.println("解密后:"+decode(source));
			
		}
	}
}
