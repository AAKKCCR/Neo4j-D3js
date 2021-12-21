package org.cwq.springboot.neo4jd3js;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

@SpringBootApplication(exclude= {DataSourceAutoConfiguration.class})
public class Neo4jD3jsApplication {

    public static void main(String[] args) {
        SpringApplication.run(Neo4jD3jsApplication.class, args);
    }

}
