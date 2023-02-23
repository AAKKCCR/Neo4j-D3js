package org.cwq.springboot.neo4jd3js.neo4j;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import org.cwq.springboot.neo4jd3js.neo4j.Neo4jUtil;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    @Test
    void test00000002() {
        String cql;
        cql="MATCH (n:`"+"功能区下具体场所"+"`)  return n  ";
        Map<String, Object> map=neo4jUtil.queryMap(cql);
        List nodes=new ArrayList();
        List relationships=new ArrayList();
        String type;
        Map tempMap;
        for (String  key : map.keySet()) {
            //System.out.println("key = " + key);
            tempMap=(Map)map.get(key);
            //System.out.println("map = " +tempMap);
            type=""+tempMap.get("type");

            if("node".equals(type)){
                nodes.add(tempMap);
            }else if("relationship".equals(type)){
                relationships.add(tempMap);
            }
        }
        JSONObject jsondata=JSONObject.parseObject("{}");
        jsondata.put("node",nodes);
        jsondata.put("relationship",relationships);
        //model.addAttribute("jsondata",jsondata );
        System.out.println(nodes.size());
    }
    @Test
    void test00000003() {
        System.out.println(neo4jUtil.CountReserveNode());
    }
}
