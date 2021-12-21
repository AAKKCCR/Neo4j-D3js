<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2021/12/20
  Time: 15:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>force</title>
    <script src="https://d3js.org/d3.v5.min.js"></script>
</head>
<body>
<svg height="400" width="500"></svg>

</body>

<script>

    //数据
    var nodes = [//节点集
        {name:"湖南邵阳"},
        {name:"山东莱州"},
        {name:"广东阳江"},
        {name:"山东枣庄"},
        {name:"赵丽泽"},
        {name:"王恒"},
        {name:"张欣鑫"},
        {name:"赵明山"},
        {name:"班长"}
    ];
    var edges = [//边集
        {source:0,target:4,relation:"籍贯",value:1.3},
        {source:4,target:5,relation:"舍友",value:1},
        {source:4,target:6,relation:"舍友",value:1},
        {source:4,target:7,relation:"舍友",value:1},
        {source:1,target:6,relation:"籍贯",value:2},
        {source:2,target:5,relation:"籍贯",value:0.9},
        {source:3,target:7,relation:"籍贯",value:1},
        {source:5,target:6,relation:"同学",value:1.6},
        {source:6,target:7,relation:"朋友",value:0.7},
        {source:6,target:8,relation:"职责",value:2}
    ];

    var margin = 30;//边距
    var svg = d3.select('svg');
    var width = svg.attr('width');
    var height = svg.attr('height');

    //创建一个分组 并设置偏移
    var g = svg.append('g').attr('transform','translate('+ margin +','+ margin +')');


    //新建一个颜色比例尺
    var scaleColor = d3.scaleOrdinal()
        .domain(d3.range(nodes.length))
        .range(d3.schemeCategory10);

    //新建一个力导向图
    var forceSimulation = d3.forceSimulation()
        .force("link",d3.forceLink())
        .force("charge",d3.forceManyBody())
        .force("center",d3.forceCenter());


    //生成节点数据
    forceSimulation.nodes(nodes)
        .on('tick',linksTick);//这个函数下面会讲解


    //生成边数据
    forceSimulation.force('link')
        .links(edges)
        .distance(function (d,i) {
            return d.value*100;//设置边长
        });

    //设置图形 中心点
    forceSimulation.force('center')
        .x(width/2)//设置x坐标
        .y(height/2)//设置y坐标

    //再来看下顶点数据 和 边数据
    console.log(nodes);
    console.log(edges);


    //绘制边  这里注意一下绘制顺序  在d3中  各元素是有层级关系的，先绘制的在下面
    var links = g.append('g')
        .selectAll('line')
        .data(edges)
        .enter()
        .append('line')
        .attr('stroke',function (d,i) {
            return scaleColor(i);//设置边线颜色
        })
        .attr('storke-width','1');//设置边线宽度


    //绘制边上的文字
    var linksText = g.append('g')
        .selectAll('text')
        .data(edges)
        .enter()
        .append('text')
        .text(function (d,i) {
            return d.relation;
        });


    //创建节点分组
    var gs = g.selectAll('.circle')
        .data(nodes)
        .enter()
        .append('g')
        .attr('transform',function (d,i) {
            return 'translate('+ d.x +','+ d.y +')'
        })
        .call(
            d3.drag()//相当于移动端的拖拽手势  分以下三个阶段
                .on('start',start)
                .on('drag',drag)
                .on('end',end)
        );

    //绘制节点
    gs.append('circle')
        .attr('r',10)
        .attr('fill',function (d,i) {
            return scaleColor(i);
        });

    //绘制文字
    gs.append('text')
        .text(function (d,i) {
            return d.name;
        });





    function linksTick(){
        links
            .attr("x1",function(d){return d.source.x;})
            .attr("y1",function(d){return d.source.y;})
            .attr("x2",function(d){return d.target.x;})
            .attr("y2",function(d){return d.target.y;});

        linksText
            .attr("x",function(d){
                return (d.source.x+d.target.x)/2;
            })
            .attr("y",function(d){
                return (d.source.y+d.target.y)/2;
            });

        gs && gs.attr('transform',function (d,i) {
            return 'translate('+ d.x +','+ d.y +')';
        })

    }


    function start(d){
        if(!d3.event.active){//event.active 属性对判断并发的拖拽手势序列中的 start 事件和 end 事件: 在拖拽手势开始时为0，在拖拽结束最后一个手势事件时为0
            //这里就是drag的过程中
            forceSimulation.alphaTarget(0.8).restart();//设置衰减系数，对节点位置移动过程的模拟，数值越高移动越快，数值范围[0，1]
        }
        d.fx = d.x;
        d.fy = d.y;
    }

    function drag(d){
        d.fx = d3.event.x;
        d.fy = d3.event.y;
    }

    function end(d) {
        if (!d3.event.active) {
            forceSimulation.alphaTarget(0);
        }
        d.fx = null;
        d.fy = null;
    }


</script>

</html>
