package org.cwq.springboot.neo4jd3js.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.cwq.springboot.neo4jd3js.model.Result;
import org.cwq.springboot.neo4jd3js.neo4j.Neo4jUtil;
import org.neo4j.driver.Record;
import org.neo4j.driver.Value;
import org.neo4j.driver.types.Node;
import org.neo4j.driver.types.Relationship;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
@RequestMapping("/Neo")
public class NeoController {
    @Resource
    private Neo4jUtil neo4jUtil;

    @GetMapping("GetSubject/{label}")
    public String Get(@PathVariable String label,Model model)
    {
        String cql;
        cql="MATCH (n:`"+label+"`)  return n  ";
        Map<String, Object>   map=neo4jUtil.queryMap(cql);
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
        model.addAttribute("witdh",200);
        model.addAttribute("height",100 );
        model.addAttribute("jsondata",jsondata );
        model.addAttribute("labels",neo4jUtil.count().get("labels"));
        model.addAttribute("nums",neo4jUtil.count().get("nums"));
        return "neo/demo";
    }

    @ResponseBody
    @PostMapping("/getMoreRelationnode")
    public Result getMoreRelationnode(HttpServletRequest request){
        System.out.println("-------------getMoreRelationnode-------------");
        //System.out.println(""+request.getPart("id"));

        String nodeid=request.getParameter("nodeid");
        System.out.println("-------------getMoreRelationnode------------nodeid:"+nodeid);
        String cql;/*
        cql="MATCH (n:`公安机关组织架构`) RETURN n LIMIT 25";
        cql="match(m:`公安机关组织架构`{名字:\"支持部\"})-[r]-(n)  return n,r,m";*/
        cql="match(n) where id(n)="+nodeid+" match(n)-[r]-(m) return  n,r,m";
        Map<String, Object>   map=neo4jUtil.queryMap(cql);
        System.out.println(map);

        List nodes=new ArrayList();
        List relationships=new ArrayList();
        String type;
        Map tempMap;
        for (String  key : map.keySet()) {
            tempMap=(Map)map.get(key);
            type=""+tempMap.get("type");
            if("node".equals(type)){
                nodes.add(tempMap);
            }else if("relationship".equals(type)){
                relationships.add(tempMap);
            }
        }
        //printList(nodes);
        //printList(relationships);
        JSONObject jsondata=JSONObject.parseObject("{}");
        jsondata.put("node",nodes);
        jsondata.put("relationship",relationships);

        //jsondata.put("code",200);


        System.out.println(jsondata.toString());
        //return jsondata.toString();

        return Result.succeed(jsondata);

    }
    @ResponseBody
    @PostMapping("/SearchNode")
    public Result SearchNode(HttpServletRequest request){
        System.out.println("-------------SearchNode-------------");
        //System.out.println(""+request.getPart("id"));

        String nodename=request.getParameter("nodename");
        //nodename=nodename.replace("\"", "");
        System.out.println("-------------SearchNode-----------nodeid:"+nodename);
        String cql;
        cql="match(n{name:'"+nodename+"'}) return n";
        Map<String, Object>   map=neo4jUtil.queryMap(cql);
        System.out.println(map);

        List nodes=new ArrayList();
        List relationships=new ArrayList();
        String type;
        Map tempMap;
        for (String  key : map.keySet()) {
            tempMap=(Map)map.get(key);
            type=""+tempMap.get("type");
            if("node".equals(type)){
                nodes.add(tempMap);
            }else if("relationship".equals(type)){
                relationships.add(tempMap);
            }
        }
        //printList(nodes);
        //printList(relationships);
        JSONObject jsondata=JSONObject.parseObject("{}");
        jsondata.put("node",nodes);

        jsondata.put("code",200);
        System.out.println(jsondata.toString());
        //return jsondata.toString();
        if(nodes.size()>0)
        {
            return Result.succeed(jsondata,"ok");
        }
        else return Result.succeed(jsondata,"false");
    }
}
