package org.cwq.springboot.neo4jd3js.utils;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;


public final class ConfigUtil {
    private static Properties props;

    private ConfigUtil() {
    }
    public static String getPropsValueByKey(String key) {
        if(props==null) {
            props=new Properties();
            InputStream resourceAsStream = ConfigUtil.class.getClassLoader().getSystemResourceAsStream("config.properties");
            try {
                props.load(resourceAsStream);
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
        return props.getProperty(key);

    }
}
