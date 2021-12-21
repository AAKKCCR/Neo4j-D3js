package org.cwq.springboot.neo4jd3js.neo4j;


import com.alibaba.fastjson.JSONObject;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Record;
import org.neo4j.driver.Session;
import org.neo4j.driver.Value;
import org.neo4j.driver.types.Node;
import org.neo4j.driver.types.Relationship;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class Neo4jUtil {

    protected Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private Driver neo4jDriver;

    public boolean isNeo4jOpen() {
        try (Session session = neo4jDriver.session()) {
            log.info("连接成功：" + session.isOpen());
            test(session);
            return session.isOpen();
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return false;
    }
    public void test(Session session)
    {
        System.out.println(session.run("MATCH (n:`事件类型`) RETURN n LIMIT 25"));
    }
    public List queryList(String cypherSql) {
        //List returnList=new ArrayList();

        System.out.println("excuteCypherSql---------------neo4jDriver:"+neo4jDriver);
        List returnList=new ArrayList();

        List<Record> records=null;
        try (Session session = neo4jDriver.session()) {
            System.out.println(session);
            System.out.println(session.run(cypherSql));
            records = session.run(cypherSql).list();
            //session.close();

            for (Record recordItem : records) {
                for (Value value : recordItem.values()) {
                    if (value.type().name().equals("NODE")) {// 结果里面只要类型为节点的值
                        System.out.println("NODE:"+value);
                        Node noe4jNode = value.asNode();
                        //String id=""+noe4jNode.id();
                        Map<String, Object> map = noe4jNode.asMap();
                        Map<String, Object> map2=new HashMap<String, Object>();
                        map2.put("type","node");
                        map2.put("id",noe4jNode.id());
                        map2.put("name",map.get("名字"));
                        map2.putAll(map);
                        returnList.add(map2);
                    }else if (value.type().name().equals("RELATIONSHIP") ){
                        Relationship relationship= value.asRelationship();
                        Map<String, Object> map2=new HashMap<String, Object>();
                        map2.put("type","relationship");
                        map2.put("startNodeId",relationship.startNodeId());
                        map2.put("endNodeId",relationship.endNodeId());
                        map2.put("name",relationship.type());
                        returnList.add(map2);
                    }else {
                        System.out.println("这是啥类型啊?"+value.type().name());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        return returnList;
    }

    public Map<String, Object> queryMap(String cypherSql) {
        //List returnList=new ArrayList();
        Map<String, Object> map1 = new HashMap<String, Object>();
        Map<String, Object> returnListMap = new HashMap<String, Object>();

        System.out.println("excuteCypherSql---------------neo4jDriver:"+neo4jDriver);
        //List returnList=new ArrayList();

        List<Record> records=null;
        try (Session session = neo4jDriver.session()) {
            records = session.run(cypherSql).list();
            session.close();



            for (Record recordItem : records) {
                for (Value value : recordItem.values()) {

                    if (value.type().name().equals("NODE")) {// 结果里面只要类型为节点的值
                        Node noe4jNode = value.asNode();
                        String id=""+noe4jNode.id();
                        //System.out.println("id------------"+id);
                        Map<String, Object> map = noe4jNode.asMap();
                        //System.out.println("map:"+map);
                        /*for (Map.Entry<String, Object> entry : map.entrySet()) {
                            String key = entry.getKey();
                            System.out.println("key:"+key);
                            if (map1.containsKey(key)) {
                                String oldValue = map1.get(key).toString();
                                String newValue = oldValue + "," + entry.getValue();
                                map1.replace(key, newValue);
                            } else {
                                map1.put(key, entry.getValue());
                            }
                        }*/
                        if (map1.containsKey(id)) {
                            Map map2=(Map)returnListMap.get(id);
                            map2.putAll(map);
                            returnListMap.put(id,map2);

                        }else{
                            Map<String, Object> map2=new HashMap<String, Object>();
                            map2.put("type","node");
                            map2.put("uuid",""+noe4jNode.id());
                            map2.put("showstyle","0");
                            map2.put("filter",new String[]{});
                            map2.put("entitytype","0");
                            map2.put("name",map.get("名字"));
                            map2.putAll(map);

                            returnListMap.put(id,map2);
                        }


                    }else if (value.type().name().equals("RELATIONSHIP") ){
                        Relationship relationship= value.asRelationship();
                        String id=""+relationship.id();

                        Map<String, Object> map2=new HashMap<String, Object>();
                        map2.put("type","relationship");
                        map2.put("sourceid",""+relationship.startNodeId());
                        map2.put("targetid",""+relationship.endNodeId());
                        map2.put("name",relationship.type());
                        map2.put("uuid",id);


                        returnListMap.put(id,map2);
                    }

                }
            }



            /*for (Record recordItem : records) {
                for (Value value : recordItem.values()) {
                    if (value.type().name().equals("NODE")) {// 结果里面只要类型为节点的值
                        System.out.println("NODE:"+value);
                        Node noe4jNode = value.asNode();
                        //String id=""+noe4jNode.id();
                        Map<String, Object> map = noe4jNode.asMap();
                        Map<String, Object> map2=new HashMap<String, Object>();
                        map2.put("type","node");
                        map2.put("uuid",""+noe4jNode.id());
                        map2.put("showstyle","0");
                        map2.put("filter",new String[]{});
                        map2.put("entitytype","0");
                        map2.put("name",map.get("名字"));
                        map2.putAll(map);
                        returnList.add(map2);
                    }else if (value.type().name().equals("RELATIONSHIP") ){
                        Relationship relationship= value.asRelationship();
                        Map<String, Object> map2=new HashMap<String, Object>();
                        map2.put("type","relationship");
                        map2.put("sourceid",""+relationship.startNodeId());
                        map2.put("targetid",""+relationship.endNodeId());
                        map2.put("name",relationship.type());
                        map2.put("uuid",""+relationship.id());
                        returnList.add(map2);
                    }else {
                        System.out.println("这是啥类型啊?"+value.type().name());
                    }
                }
            }*/
        } catch (Exception e) {
            e.printStackTrace();
        }


        return returnListMap;
    }

    public Map queryNodeMapByUuuid(String uuid) {
        String  cypherSql="match(n) where id(n)="+uuid+"  return  n";
        System.out.println(cypherSql);

        Map returnMap=new HashMap();

        List<Record> records=null;
        try (Session session = neo4jDriver.session()) {
            records = session.run(cypherSql).list();
            session.close();

            for (Record recordItem : records) {

                System.out.println(recordItem.asMap());


                for (Value value : recordItem.values()) {

                    System.out.println(value);
                    System.out.println(value.type().name());
                    if (value.type().name().equals("NODE")) {// 结果里面只要类型为节点的值
                        System.out.println("NODE:"+value);
                        Node noe4jNode = value.asNode();
                        //String id=""+noe4jNode.id();
                        Map<String, Object> map = noe4jNode.asMap();
                        System.out.println("----->"+map);
                        //return map;
                        returnMap.put("identity",noe4jNode.id());
                        returnMap.put("labels",noe4jNode.labels());
                        returnMap.put("properties",map);





                       /* if (map1.containsKey(id)) {
                            Map map2=(Map)returnListMap.get(id);
                            map2.putAll(map);
                            returnListMap.put(id,map2);

                        }else{
                            Map<String, Object> map2=new HashMap<String, Object>();
                            map2.put("type","node");
                            map2.put("uuid",""+noe4jNode.id());
                            map2.put("showstyle","0");
                            map2.put("filter",new String[]{});
                            map2.put("entitytype","0");
                            map2.put("name",map.get("名字"));
                            map2.putAll(map);

                            returnListMap.put(id,map2);
                        }*/


                    }else {
                        System.out.println("这是啥类型啊?"+value.type().name());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }



        return returnMap;
    }

    public List queryActions() {
        String cypherSql="MATCH (n:`动作库`)  RETURN n  ";


        //List returnList=new ArrayList();
        List actions=new ArrayList<Map>();

        Map<String, Object> map1 = new HashMap<String, Object>();
        Map<String, Object> returnListMap = new HashMap<String, Object>();

        System.out.println("queryActions---------------neo4jDriver:"+neo4jDriver);
        List<Record> records=null;
        try (Session session = neo4jDriver.session()) {
            records = session.run(cypherSql).list();
            session.close();

            for (Record recordItem : records) {
                for (Value value : recordItem.values()) {
                    if (value.type().name().equals("NODE")) {// 结果里面只要类型为节点的值
                        Node noe4jNode = value.asNode();
                        String id=""+noe4jNode.id();
                        Map<String, Object> map = noe4jNode.asMap();
                        if (map1.containsKey(id)) {
                            Map map2=(Map)returnListMap.get(id);
                            map2.putAll(map);
                            returnListMap.put(id,map2);
                        }else{
                            Map<String, Object> map2=new HashMap<String, Object>();
                            map2.put("name",map.get("名字"));
                            /*String namePY= ChineseToFirstCharUtil.toFirstChar(""+map.get("名字"));
                            map2.put("namePY",namePY);*/
                            map2.putAll(map);
                            returnListMap.put(id,map2);
                        }

                    }

                }
            }

            Map tempMap;
            for (String  key : returnListMap.keySet()) {
                tempMap=(Map)returnListMap.get(key);
                actions.add(tempMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return actions;
    }
    public List queryListForImport(String cypherSql) {
        //List returnList=new ArrayList();

        System.out.println("excuteCypherSql---------------neo4jDriver:"+neo4jDriver);
        List returnList=new ArrayList();

        List<Record> records=null;
        try (Session session = neo4jDriver.session()) {
            records = session.run(cypherSql).list();
            session.close();

            for (Record recordItem : records) {
                for (Value value : recordItem.values()) {
                    if (value.type().name().equals("NODE")) {// 结果里面只要类型为节点的值
                        //System.out.println("NODE:"+value);
                        Node noe4jNode = value.asNode();
                        //String id=""+noe4jNode.id();
                        Map<String, Object> map = noe4jNode.asMap();
                        Map<String, Object> map2=new HashMap<String, Object>();
                        map2.put("identity",(long)noe4jNode.id());
                        map2.put("name",map.get("名字"));
                        //map2.put("type","node");
                        map2.put("lables",noe4jNode.labels().toString());
                        map2.put("properties", JSONObject.toJSON(map).toString() );
                        returnList.add(map2);
                    }else if (value.type().name().equals("RELATIONSHIP") ){
                        Relationship relationship= value.asRelationship();

                        //System.out.println(relationship.type());
                        Map<String, Object> map2=new HashMap<String, Object>();

                        map2.put("identity",(long)relationship.id());
                        map2.put("type","relationship");
                        map2.put("start",relationship.startNodeId());
                        map2.put("end",relationship.endNodeId());
                        map2.put("name",relationship.type());
                        map2.put("properties",JSONObject.toJSON(relationship.asMap()).toString() );
                        returnList.add(map2);
                    }else if(value.type().name().equals("STRING") ) {
                        //System.out.println("...............?"+value.asString());
                        Map<String, Object> map2=new HashMap<String, Object>();
                        map2.put("name",value.asString());
                        returnList.add(map2);
                    }else{
                        System.out.println("这是啥类型啊?"+value.type().name());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        return returnList;
    }

}
