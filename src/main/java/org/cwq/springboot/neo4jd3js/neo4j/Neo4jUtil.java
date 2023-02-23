package org.cwq.springboot.neo4jd3js.neo4j;


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
import com.alibaba.fastjson.JSONObject;

import java.util.*;

@Component
public class Neo4jUtil {

    protected Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private Driver neo4jDriver;

    public boolean isNeo4jOpen() {
        try (Session session = neo4jDriver.session()) {
            log.info("连接成功：" + session.isOpen());
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
            //System.out.println(session);
            //System.out.println(session.run(cypherSql));
            records = session.run(cypherSql).list();
            System.out.println(records);
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
    public Value  CountNum(String cql)
    {
        String test;
        test="test";
        Value num = null;
        /*String cql="MATCH (n) RETURN count(*)";*/
        List<Record> records=null;
        List<Record> tmp=null;
        List<String> labels=new ArrayList();
        List<Value> nums=new ArrayList();
        Map<String,List>returnMap=new HashMap<String,List>();
        String label;
        Record Item;
        try (Session session = neo4jDriver.session()) {
            records = session.run(cql).list();
            System.out.println(records);
            for (Record recordItem : records) {
                num=recordItem.values().get(0);
            }session.close();
        }
        return num;
    }
    public Map<String,List> count(){
        List<Record> records=null;
        List<Record> tmp=null;
        List<String> labels=new ArrayList();
        List<Value> nums=new ArrayList();
        Map<String,List>returnMap=new HashMap<String,List>();
        String cql;
        String label;
        Value num;
        Record Item;
        try (Session session = neo4jDriver.session()) {
            records = session.run("call db.labels();").list();

            for (Record recordItem : records) {
                label=String.valueOf(recordItem.values().get(0));
                label= label.replace("\"", "");
                if(label.equals("id")||label.equals("观众")||label.equals("国家越野滑雪中心观众"))
                {
                    continue;
                }
                cql="MATCH (n:`"+label+"`) RETURN count(*)";
                label="'"+label+"'";
                labels.add(label);
                tmp= session.run(cql).list();
                Item= tmp.get(0);
                num=Item.values().get(0);
                nums.add(num);
            }session.close();
        }
        returnMap.put("labels",labels);
        returnMap.put("nums",nums);
        return returnMap;
    }
    public List Count4View(){
        List<Record> records=null;
        List<Record> tmp=null;
        List<String>returnlist=new ArrayList();
        String cql;
        String label;
        Value num;
        Record Item;
        String str;
        try (Session session = neo4jDriver.session()) {
            records = session.run("call db.labels();").list();

            for (Record recordItem : records) {
                label=String.valueOf(recordItem.values().get(0));
                label= label.replace("\"", "");
                if(label.equals("id")||label.equals("观众")||label.equals("国家越野滑雪中心观众"))
                {
                    continue;
                }
                cql="MATCH (n:`"+label+"`) RETURN count(*)";
                /*label="'"+label+"'";*/
                tmp= session.run(cql).list();
                Item= tmp.get(0);
                num=Item.values().get(0);
                str="{ value: "+num+", name: '"+label+"' }";
                returnlist.add(str);
            }session.close();
        }
        return returnlist;
    }
    public Map<String,List> CountReservePlan()
    {
        List<Record> records=null;
        List<Record> tmp=null;
        Map<String,List>returnMap=new HashMap<String,List>();
        List<String> names =new ArrayList();
        List<Value> nums=new ArrayList();
        String cql;
        String name;
        Value num;
        Record Item;
        String str;
        try (Session session = neo4jDriver.session()) {
            cql="MATCH (n:`事件类型`) RETURN n.name";
            records = session.run(cql).list();
            /*System.out.println(records.get(0).values().get(0));*/
            for (Record recordItem : records) {
                name =String.valueOf(recordItem.values().get(0));
                name= name.replace("\"", "");
                cql="MATCH(n{name:'"+name+"'})with n,size((n)-[:hasScene]->()) as s return s";
                name ="'"+ name +"'";
                names.add(name);
                tmp= session.run(cql).list();
                Item= tmp.get(0);
                num=Item.values().get(0);
                nums.add(tmp.get(0).values().get(0));
            }
            session.close();
        }
        returnMap.put("ReserveName", names);
        returnMap.put("ReserveNums",nums);
        return returnMap;
    }
    public Map<String,List> CountReserveNode()
    {
        List<Record> records=null;
        List<Record> tmp=null;
        Map<String,List>returnMap=new HashMap<String,List>();
        List<String> names =new ArrayList();
        List<Value> nums=new ArrayList();
        List<Integer>count=new ArrayList();
        String cql;
        Value num;
        Record Item;
        String str;
        int sum = 0;
        List<String> labels= Arrays.asList("事件类型", "情形", "指令","方法","岗位");
        try (Session session = neo4jDriver.session()) {
            /*System.out.println(records.get(0).values().get(0));*/
            for (String name: labels) {
                cql="MATCH (n:`"+name+"`) RETURN count(*)";
                name ="'"+ name +"'";
                names.add(name);
                tmp= session.run(cql).list();
                Item= tmp.get(0);
                num=Item.values().get(0);
                nums.add(tmp.get(0).values().get(0));
                sum = sum + num.asInt();
            }
            session.close();
        }
        System.out.println(sum);
        int m;
        for(Value n:nums) {
            m = (n.asInt() *100)/ sum;
            count.add(m);
        }
        returnMap.put("ReserveNode", names);
        returnMap.put("NodeNum",nums);
        returnMap.put("NodeCount",count);
        return returnMap;
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

                        Node neo4jNode = value.asNode();
                        String id=""+neo4jNode.id();
                        //System.out.println("id------------"+id);
                        Map<String, Object> map = neo4jNode.asMap();
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
                            System.out.println(map);
                            Map<String, Object> map2=new HashMap<String, Object>();
                            map2.put("type","node");
                            map2.put("uuid",""+neo4jNode.id());
                            map2.put("showstyle","0");
                            map2.put("filter",new String[]{});
                            map2.put("entitytype","0");
                            map2.put("name",map.get("名字"));
                            map2.put("label",JSONObject.toJSON(neo4jNode.labels()).toString());
                            map2.put("properties",map);
                            String p=JSONObject.toJSON(map).toString();
                            p=p+",labels:"+JSONObject.toJSON(JSONObject.toJSON(neo4jNode.labels()).toString());
                            map2.put("p",p);
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
