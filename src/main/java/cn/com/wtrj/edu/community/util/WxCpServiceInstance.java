package cn.com.wtrj.edu.community.util;

import com.google.gson.JsonObject;

import me.chanjar.weixin.cp.api.WxCpService;
import me.chanjar.weixin.cp.api.impl.WxCpServiceImpl;
import me.chanjar.weixin.cp.config.WxCpConfigStorage;
import me.chanjar.weixin.cp.config.WxCpInMemoryConfigStorage;
import me.chanjar.weixin.cp.message.WxCpMessageRouter;

public class WxCpServiceInstance {
	private WxCpService wxCpService;
	private WxCpInMemoryConfigStorage wxCpConfigStorage;
	private WxCpMessageRouter wxCpMessageRouter;

	private static WxCpServiceInstance instance = null;

	public static WxCpServiceInstance getInstance() {
		if (instance == null) {
			try {
				instance = new WxCpServiceInstance();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return instance;
	}

	private WxCpServiceInstance() throws Exception {
		wxCpService = new WxCpServiceImpl();
		wxCpConfigStorage = new WxCpInMemoryConfigStorage();
		wxCpConfigStorage.setCorpId(PropertiesUtil.getInstance().getValue(SampleConstants.WEIXIN_CP_APPID)); // 设置微信企业号的appid
		wxCpConfigStorage.setCorpSecret(PropertiesUtil.getInstance().getValue(SampleConstants.WEIXIN_CP_SECRET)); // 设置微信企业号的app
																													// corpSecret
		wxCpService.setWxCpConfigStorage(wxCpConfigStorage);
		wxCpMessageRouter = new WxCpMessageRouter(wxCpService);
	}

	public WxCpService getWxCpService() {
		return wxCpService;
	}

	public WxCpConfigStorage getWxCpConfigStorage() {
		return wxCpConfigStorage;
	}

	public WxCpMessageRouter getWxCpMessageRouter() {
		return wxCpMessageRouter;
	}

	public static void main(String[] args) {
		JsonObject tokenObj = HttpRequestUtils.httpGet("http://localhost:8081/token/get?appid=ecom&secret=ecom123");
		String token = tokenObj.get("access_token").getAsString();
		
		System.out.println(tokenObj);
		/*
		 * {"no":"18652352","type":"02",cardNo:"1212121","name":"wusm","remark":
		 * "123451241","start":"2017-10-10 10:10:10","end":"2017-10-11 12:12:12"}
		 */
		JsonObject json = new JsonObject();
		json.addProperty("no", "158285528");
		json.addProperty("type", "02");
		json.addProperty("cardNo", "125825");
		json.addProperty("name", "lzhp");
		json.addProperty("remark", "zhoooogn");
		json.addProperty("start", "2017-10-10 10:10:10");
		json.addProperty("end", "2017-10-10 10:10:10");

		HttpRequestUtils.httpPost("http://localhost:8081/sync/visit/insert?token=" + token, json);
	}
}
