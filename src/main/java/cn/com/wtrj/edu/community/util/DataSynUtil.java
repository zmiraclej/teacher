package cn.com.wtrj.edu.community.util;

import com.google.gson.JsonObject;

public class DataSynUtil {
	/**
	 * 获取token
	 * @param baseUrl  protocol://ip:port
	 * @param appid
	 * @param secret
	 * @return
	 */
	public static String getToken(String baseUrl,String appid,String secret) {
		String url = baseUrl+"/token/get?appid="+appid+"&secret="+secret;
		JsonObject tokenRet = HttpRequestUtils.httpGet(url);
		return tokenRet.get("access_token").getAsString();
	}
	
	/**
	 * 新增来访数据
	 * @param baseUrl  protocol://ip:port
	 * @param token
	 * @param json
	 * @return
	 */
	public static JsonObject insertVisit(String baseUrl,String token,JsonObject json) {
		String url = baseUrl+"/sync/visit/insert?token=" + token;
		return HttpRequestUtils.httpPost(url, json);
	}
	
	/**
	 * 删除来访数据
	 * @param baseUrl  protocol://ip:port
	 * @param token
	 * @param json
	 * @return
	 */
	public static JsonObject deleteVisit(String baseUrl,String token,JsonObject json) {
		String url = baseUrl+"/sync/visit/delete?token=" + token;
		return HttpRequestUtils.httpPost(url, json);
	}
	
	/**
	 * 新增请假数据
	 * @param baseUrl
	 * @param token
	 * @param json
	 * @return
	 */
	public static JsonObject updateLeave(String baseUrl,String token,JsonObject json) {
		String url = baseUrl+"/sync/leave?token="+token;
		return HttpRequestUtils.httpPost(url, json);
	}
	/**
	 * 删除请假数据
	 * @param baseUrl
	 * @param token
	 * @param json
	 * @return
	 */
	public static JsonObject deleteLeave(String baseUrl,String token,JsonObject json) {
		String url = baseUrl+"/leave/delete?token="+token;
		return HttpRequestUtils.httpPost(url, json);
	}
}
