package org.cwq.springboot.neo4jd3js;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.WebApplicationInitializer;

@SpringBootApplication(exclude= {DataSourceAutoConfiguration.class})
public class Neo4jD3jsApplication extends SpringBootServletInitializer{

    public static void main(String[] args) {
        SpringApplication.run(Neo4jD3jsApplication.class, args);
    }
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(Neo4jD3jsApplication.class);
    }
}

