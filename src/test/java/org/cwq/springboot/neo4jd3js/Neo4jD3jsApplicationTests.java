package org.cwq.springboot.neo4jd3js;
import org.cwq.springboot.neo4jd3js.neo4j.Neo4jUtil;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import java.util.List;
@SpringBootTest
class Neo4jD3jsApplicationTests {
    @Resource
    private Neo4jUtil neo4jUtil;

    @Test
    void contextLoads() {
        String cql="MATCH (n:`事件类型`) RETURN n LIMIT 25";
        List xxx=neo4jUtil.queryList(cql);
        System.out.println(xxx);
        for (int i=0;i<xxx.size();i++){
            System.out.println(xxx.get(i));
        }
        neo4jUtil.isNeo4jOpen();
    }

}
