package cn.com.wtrj.edu.community.util;

import java.util.Random;

/**
 * 随机数生成器
 * @author Administrator
 *
 */
public class RandomCodeUtil {
	/**
	 * 生成随机码
	 * @param num 指定位数
	 * @return
	 */
	public static String getRandomCode(int num) {
		String[] codeStore = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"};
		StringBuilder sb = new StringBuilder();
		Random r = new Random();
		for (int i = 0; i < num; i++) {
			int index = r.nextInt(16);
			sb.append(codeStore[index]);
		}
		return sb.toString();
	}
}
