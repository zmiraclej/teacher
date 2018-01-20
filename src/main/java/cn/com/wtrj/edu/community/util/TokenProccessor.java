package cn.com.wtrj.edu.community.util;

import java.util.Random;

public class TokenProccessor {
	/*
     *单例设计模式（保证类的对象在内存中只有一个）
     *1、把类的构造函数私有
     *2、自己创建一个类的对象
     *3、对外提供一个公共的方法，返回类的对象
     */
    private TokenProccessor(){}
    
    private static final TokenProccessor instance = new TokenProccessor();
    
    /**
     * 返回类的对象
     * @return
     */
    public static TokenProccessor getInstance(){
        return instance;
    }
    
    /**
     * 生成Token
     * Token：Nv6RRuGEVvmGjB+jimI/gw==
     * @return
     */
    public String makeToken(){ 
        String token = (System.currentTimeMillis() + new Random().nextInt(999999999)) + "";
        return Base64Utils.encode(token);
    }
    
/*    public static void main(String[] args) {
		System.out.println(TokenProccessor.getInstance().makeToken());
	}*/
}
