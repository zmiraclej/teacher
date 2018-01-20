package cn.com.wtrj.edu.community.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class PropertiesUtil {


	    private static PropertiesUtil instance = null;

	    private Properties props = null;

	    private PropertiesUtil(){

	        this.props = new Properties();
	        try {
	            this.props.load(PropertiesUtil.class.getResourceAsStream(SampleConstants.PROPERTIES_FILENAME));
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	    }

	    public static synchronized PropertiesUtil getInstance(){
	        if (instance == null)
	            instance = new PropertiesUtil();
	        return instance;
	    }

	    public String getValue(String propKey){
	        return this.props.getProperty(propKey);
	    }

	    public static Map<String, String> getQueryMap(String query)
	    {
	        String[] params = query.split("&");
	        Map<String, String> map = new HashMap<String, String>();
	        for (String param : params)
	        {  String [] p=param.split("=");
	            String name = p[0];
	            if(p.length>1)  {String value = p[1];
	                map.put(name, value);
	            }
	        }
	        return map;
	    }

	    public static Date convertStringtoDate(String startDateString){

	        DateFormat df = new SimpleDateFormat("yyyyMMddHHmm");
	        Date startDate = null;
	        try {
	            startDate = df.parse(startDateString);
	            String newDateString = df.format(startDate);
	            System.out.println(newDateString);
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }

	        if (startDate == null){
	            startDate = new Date();
	        }

	        return startDate;
	    }


	    public static void main(String[] args) throws Exception {

	        Logger logger = LoggerFactory.getLogger(PropertiesUtil.class);
	        String queryString = "when=201608261430&userId=002&userName=李鹏&Phone=18628286845";

	        Map<String, String> params= PropertiesUtil.getQueryMap(queryString);

	        for ( Map.Entry<String, String> entry: params.entrySet()) {
	            logger.debug("param.getName()= [{}],param.getValue()= [{}] ",entry.getKey(),entry.getValue());
	        }

	        logger.debug("params.get(\"userName\") = [{}] ",params.get("userName"));

	        Date aDate = PropertiesUtil.convertStringtoDate("201608221430");
	        logger.debug(" Convert Str to Date  = [{}] ", aDate.toString());

	        String SeverNameForURI = PropertiesUtil.getInstance().getValue( "SeverNameForURI" ) ;
	        logger.debug(" SeverNameForURI  = [{}] ", SeverNameForURI );


	    }

}
