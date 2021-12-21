package org.cwq.springboot.neo4jd3js.neo4j;

import org.cwq.springboot.neo4jd3js.utils.ConfigUtil;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnect {
    static Connection conn = null;

    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                try {
                    Class.forName("org.neo4j.jdbc.Driver").newInstance();
                    String url = ConfigUtil.getPropsValueByKey("neo4j.url");
                    String usr = ConfigUtil.getPropsValueByKey("neo4j.usr");
                    String pass = ConfigUtil.getPropsValueByKey("neo4j.pass");
                    conn = DriverManager.getConnection(url, usr, pass);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
