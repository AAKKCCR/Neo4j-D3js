package org.cwq.springboot.neo4jd3js.neo4j;

import javax.annotation.Resource;

import org.cwq.springboot.neo4jd3js.neo4j.Neo4jUtil;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class NeoTest1 {


    @Resource
    private Neo4jUtil neo4jUtil;


    @Test
    void test00000001() {

        String cql="MATCH (n:`事件类型`) RETURN n LIMIT 25";
        List xxx=neo4jUtil.queryList(cql);
        System.out.println(xxx);
        for (int i=0;i<xxx.size();i++){
            System.out.println(xxx.get(i));
        }

    }
}
