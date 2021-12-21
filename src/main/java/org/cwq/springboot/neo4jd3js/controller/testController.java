package org.cwq.springboot.neo4jd3js.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/test")
public class testController {
    @GetMapping("hello")
    public String sayHello(){
        return "neo/demo";
    }
}
