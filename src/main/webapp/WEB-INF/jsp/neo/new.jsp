<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML>
<html xmlns:th="http://www.thymeleaf.org" xmlns:layout="http://www.ultraq.net.nz/web/thymeleaf/layout">

<head>
    <title>图谱可视化界面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <META    HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META    HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META    HTTP-EQUIV="Expires" CONTENT="0">
    <!-- import iView -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, minimal-ui">
    <script src="/static/js/sChart.min.js"></script>
    <script src="/static/js/echarts.js"></script>
    <script src="/static/js/jquery/3.3.1/jquery.min.js"></script>
    <script src="/static/js/vue/2.2.2/vue.min.js"></script>
    <script src="/static/js/lodash/3.5.0/lodash.min.js"></script>
    <script src="/static/js/d3/d3.v4.min.js"></script>
    <script src="/static/js/view-design4.6.1/dist/iview.min.js"></script>
    <script src="/static/js/flexible.js"></script>
    <script src="/static/js/echarts.min.js"></script>
    <script src="/static/js/jquery.js"></script>
    <!-- 引入china.js 完成地图模块 -->
    <script src="/static/js/china.js"></script>
    <%--<script src="js/index.js"></script>--%>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        li {
            list-style: none;
        }
        @font-face {
            font-family: electronicFont;
            src: url(/static/font/DS-DIGIT.TTF);
        }
        body {
            background: url(/static/images/bg.jpg) no-repeat top center;
            line-height: 1.15;
            overflow: hidden;
        }
        header {
            position: relative;
            height: 1.25rem;
            background: url(/static/images/head_bg.png) no-repeat;
            background-size: 100% 100%;
        }
        header h1 {
            font-size: 0.475rem;
            color: rgba(255, 255, 255, 0.87);
            text-align: center;
            line-height: 1rem;
        }
        header .show-time {
            position: absolute;
            top: 0;
            right: 0.375rem;
            line-height: 0.9375rem;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.25rem;
        }
        .mainbox {
            display: flex;
            min-width: 1024px;
            max-height: 1720px;
            margin: 0 auto;
            padding: 0.125rem 0.125rem 0;
        }
        .mainbox .column {
            flex: 3;
        }
        .mainbox .column:nth-child(2) {
            flex: 5;
            margin: 0 0.125rem 0.1875rem;
            overflow: hidden;
        }
        .mainbox .panel {
            position: relative;
            height: 3.875rem;
            padding: 0 0.1875rem 0.5rem;
            margin-bottom: 0.1875rem;
            border: 1px solid rgba(25, 186, 139, 0.17);
            background: url(/static/images/line.png) rgba(255, 255, 255, 0.03);
        }
        .mainbox .panel::before {
            position: absolute;
            top: 0;
            left: 0;
            width: 10px;
            height: 10px;
            border-left: 2px solid #02a6b5;
            border-top: 2px solid #02a6b5;
            content: '';
        }
        .mainbox .panel::after {
            position: absolute;
            top: 0;
            right: 0;
            width: 10px;
            height: 10px;
            border-right: 2px solid #02a6b5;
            border-top: 2px solid #02a6b5;
            content: '';
        }
        .mainbox .panel .panel-footer {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
        }
        .mainbox .panel .panel-footer::before {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 10px;
            height: 10px;
            border-left: 2px solid #02a6b5;
            border-bottom: 2px solid #02a6b5;
            content: '';
        }
        .mainbox .panel .panel-footer::after {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 10px;
            height: 10px;
            border-right: 2px solid #02a6b5;
            border-bottom: 2px solid #02a6b5;
            content: '';
        }
        .mainbox .panel h2 {
            height: 0.6rem;
            color: #fff;
            line-height: 0.6rem;
            text-align: center;
            font-size: 0.25rem;
            font-weight: 400;
        }
        .mainbox .panel h2 a {
            color: #a7a7a7;
            text-decoration: none;
            margin: 0 0.125rem;
        }
        .mainbox .panel h2 .a-active {
            color: #fff;
        }
        .mainbox .panel .chart {
            height: 3rem;
        }
        .no {
            background-color: rgba(101, 132, 226, 0.1);
            padding: 0.1875rem;
        }
        .no .no-hd {
            position: relative;
            border: 1px solid rgba(25, 186, 139, 0.17);
        }
        .no .no-hd::before {
            position: absolute;
            top: 0;
            left: 0;
            width: 0.375rem;
            height: 0.125rem;
            border-top: 2px solid #02a6b5;
            border-left: 2px solid #02a6b5;
            content: '';
        }
        .no .no-hd::after {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 0.375rem;
            height: 0.125rem;
            border-bottom: 2px solid #02a6b5;
            border-right: 2px solid #02a6b5;
            content: '';
        }
        .no .no-hd ul {
            display: flex;
        }
        .no .no-hd ul li {
            position: relative;
            flex: 1;
            line-height: 1rem;
            font-size: 0.875rem;
            color: #ffeb7b;
            text-align: center;
            font-family: electronicFont;
        }
        .no .no-hd ul li:first-child::after {
            content: '';
            position: absolute;
            top: 25%;
            right: 0;
            height: 50%;
            width: 1px;
            background-color: rgba(255, 255, 255, 0.3);
        }
        .no .no-bd ul {
            display: flex;
        }
        .no .no-bd ul li {
            flex: 1;
            text-align: center;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.225rem;
            height: 0.5rem;
            line-height: 0.5rem;
            padding-top: 0.125rem;
        }
        .map {
            position: relative;
            height: 10.125rem;
        }
        .map .map1 {
            width: 6.475rem;
            height: 6.475rem;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: url(/static/images/map.png);
            background-size: 100% 100%;
            opacity: 0.3;
        }
        .map .map2 {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 8.0375rem;
            height: 8.0375rem;
            background: url(/static/images/lbx.png);
            background-size: 100% 100%;
            animation: rotate1 15s linear infinite;
            opacity: 0.6;
        }
        .map .map3 {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 7.075rem;
            height: 7.075rem;
            background: url(/static/images/jt.png);
            background-size: 100% 100%;
            animation: rotate2 15s linear infinite;
        }
        .map .chart {
            position: absolute;
            top: 0;
            left: 0;
            height: 10.125rem;
            width: 100%;
        }
        @keyframes rotate1 {
            from {
                transform: translate(-50%, -50%) rotate(0deg);
            }
            to {
                transform: translate(-50%, -50%) rotate(360deg);
            }
        }
        @keyframes rotate2 {
            from {
                transform: translate(-50%, -50%) rotate(360deg);
            }
            to {
                transform: translate(-50%, -50%) rotate(0deg);
            }
        }
        /* 约束屏幕尺寸 */
        @media screen and (max-width: 1024px) {
            html {
                font-size: 42px !important;
            }
        }
        @media screen and (min-width: 1920px) {
            html {
                font-size: 80px !important;
            }
        }

    </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>数据可视化</title>
</head>

<body>

<header>
    <h1>图谱可视化系统</h1>
    <div class="show-time"></div>
    <script>
        var t = null;
        t = setTimeout(time, 1000); //开始运行
        function time() {
            clearTimeout(t); //清除定时器
            dt = new Date();
            var y = dt.getFullYear();
            var mt = dt.getMonth() + 1;
            var day = dt.getDate();
            var h = dt.getHours(); //获取时
            var m = dt.getMinutes(); //获取分
            var s = dt.getSeconds(); //获取秒
            document.querySelector(".show-time").innerHTML =
                "当前时间：" +
                y +
                "年" +
                mt +
                "月" +
                day +
                "日-" +
                h +
                "时" +
                m +
                "分" +
                s +
                "秒";
            t = setTimeout(time, 1000); //设定定时器，循环运行
        }
    </script>
</header>

<!-- 页面主体 -->
<section class="mainbox" >
    <!-- 左侧盒子 -->
    <div class="column">
        <div class="panel bar">
            <h2>柱形图-除观众外各类节点个数</h2>
            <!-- 图表放置盒子 -->
            <div class="chart" id="main"></div>
            <!-- 伪元素绘制盒子下边角 -->
            <div class="panel-footer"></div>
        </div>
        <div class="panel pie">
            <h2>饼状图-节点类型分布</h2>
            <div class="chart"></div>
            <div class="panel-footer"></div>
        </div>
    </div>
    <!-- 中间盒子 -->
    <div class="column">
        <!-- 头部 no模块 -->
        <div class="no">
            <div class="no-hd">
                <ul>
                    <li>${nodenum}</li>
                    <li>${linknum}</li>
                </ul>
            </div>
            <div class="no-bd">
                <ul>
                    <li>图谱节点个数</li>
                    <li>图谱关系个数</li>
                </ul>
            </div>
        </div>
        <!-- map模块 -->
        <div class="map" id="app">
            <div id="graphcontainer"  class="graphcontainer" <%--style="display: inline-block;vertical-align: middle"--%> ></div>
        </div>
    </div>
    <!-- 右侧盒子 -->
    <div class="column">
        <div class="panel line">
            <h2>折线图-各类型预案数量</h2>>
            <div class="chart"></div>
            <div class="panel-footer"></div>
        </div>
        <div class="panel bar2">
            <h2>柱形图-预案相关节点</h2>
            <div class="chart"></div>
            <div class="panel-footer"></div>
        </div>
    </div>
</section>



</body>
<script th:inline="javascript" type="text/javascript" >
    var contextRoot='/';
    var jsondata=${jsondata};

    var iframeId='${iframeId}';
    var inputId1='${inputId1}';
    var inputId2='${inputId2}';
    var witdh=${witdh};
    var height=${height};

    var labelName='${labelName}';
    var labels=${labels};
    var nums=${nums};

    //随机颜色
    var colorScale = d3.scaleOrdinal().domain(d3.range(labels.length)).range(d3.schemeCategory10);

    (function () {
        // 1.实例化对象
        var myChart = echarts.init(document.querySelector(".bar .chart"));
        // 2.指定配置项和数据
        var option = {
            color: ['#2f89cf'],
            // 提示框组件
            tooltip: {
                trigger: 'axis',
                axisPointer: { // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            // 修改图表位置大小
            grid: {
                left: '0%',
                top: '10px',
                right: '0%',
                bottom: '4%',
                containLabel: true
            },
            // x轴相关配置
            xAxis: [{
                type: 'category',
                data: ${labels},
                axisTick: {
                    alignWithLabel: true
                },
                // 修改刻度标签，相关样式
                axisLabel: {
                    color: "rgba(255,255,255,0.8)",
                    fontSize: 10
                },
                // x轴样式不显示
                axisLine: {
                    show: false
                }
            }],
            // y轴相关配置
            yAxis: [{
                type: 'value',
                // 修改刻度标签，相关样式
                axisLabel: {
                    color: "rgba(255,255,255,0.6)",
                    fontSize: 12
                },
                // y轴样式修改
                axisLine: {
                    lineStyle: {
                        color: "rgba(255,255,255,0.6)",
                        width: 2
                    }
                },
                // y轴分割线的颜色
                splitLine: {
                    lineStyle: {
                        color: "rgba(255,255,255,0.1)"
                    }
                }
            }],
            // 系列列表配置
            series: [{
                name: '直接访问',
                type: 'bar',
                barWidth: '35%',
                // ajax传动态数据
                data: ${nums},
                itemStyle: {
                    // 修改柱子圆角
                    barBorderRadius: 5
                }
            }]
        };
        // 3.把配置项给实例对象
        myChart.setOption(option);

        // 4.让图表随屏幕自适应
        window.addEventListener('resize', function () {
            myChart.resize();
        })
    })();

    (function () {
        var myChart = echarts.init(document.querySelector('.pie .chart'));
        var option = {
            color: ['#60cda0', '#ed8884', '#ff9f7f', '#0096ff', '#9fe6b8', '#32c5e9', '#1d9dff'],
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b} : {c} ({d}%)'
            },
            legend: {
                type: 'scroll',
                orient: 'vertical',
                right: 0,
                top: 20,
                bottom: 20,
                data: ${labels},
                borderColor: '#5b6270',
                formatter: (params) => {
                    let tip1 = "";
                    let tip = "";
                    let le = params.length  //图例文本的长度
                    if (le > 5) {   //几个字换行大于几就可以了
                        let l = Math.ceil(le / 5)  //有些不能整除，会有余数，向上取整
                        for (let i = 1; i <= l; i++) { //循环
                            if (i < l) { //最后一段字符不能有\n
                                tip1 += params.slice(i * 5 - 5, i * 5) + '\n'; //字符串拼接
                            } else if (i === l) {  //最后一段字符不一定够9个
                                tip = tip1 + params.slice((l - 1) * 5, le) //最后的拼接在最后
                            }
                        }
                        return tip;
                    } else {
                        tip = params  //前面定义了tip为空，这里要重新赋值，不然会替换为空
                        return tip;
                    }
                },
                textStyle: {
                    color: "rgba(255,255,255,.5)",
                    fontSize: 10
                }
            },
            series: [{
                name: '节点类型',
                type: 'pie',
                radius: ["10%", "65%"],
                center: ['35%', '50%'],
                // 半径模式  area面积模式
                roseType: 'radius',
                // 图形的文字标签
                label: {
                    fontsize: 5
                },
                // 引导线调整
                labelLine: {
                    // 连接扇形图线长(斜线)
                    length: 2,
                    // 连接文字线长(横线)
                    length2: 6
                },
                data: ${Count}
            }]
        };

        myChart.setOption(option);
        window.addEventListener('resize', function () {
            myChart.resize();
        })
    })();
    (function () {
        // 年份对应数据

        var myChart = echarts.init(document.querySelector(".line .chart"));

        var option = {
            // 修改两条线的颜色
            color: ['#00f2f1', '#ed3f35'],
            tooltip: {
                trigger: 'axis'
            },
            // 图例组件
            legend: {
                // 当serise 有name值时， legend 不需要写data
                // 修改图例组件文字颜色
                textStyle: {
                    color: '#4c9bfd'
                },
                right: '10%',
            },
            grid: {
                top: "20%",
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true,
                show: true, // 显示边框
                borderColor: '#012f4a' // 边框颜色
            },
            xAxis: {
                type: 'category',
                boundaryGap: false, // 去除轴间距
                data: ${ReserveName},
                // 去除刻度线
                axisTick: {
                    show: false
                },
                axisLabel: {
                    color: "#4c9bfb" // x轴文本颜色
                },
                axisLine: {
                    show: false // 去除轴线
                }
            },
            yAxis: {
                type: 'value',
                // 去除刻度线
                axisTick: {
                    show: false
                },
                axisLabel: {
                    color: "#4c9bfb" // x轴文本颜色
                },
                axisLine: {
                    show: false // 去除轴线
                },
                splitLine: {
                    lineStyle: {
                        color: "#012f4a"
                    }
                }
            },
            series: [{
                type: 'line',
                smooth: true, // 圆滑的线
                name: '预案类型',
                data: ${ReserveNums}
            },
            ]
        };

        myChart.setOption(option);

        // 4.让图表随屏幕自适应
        window.addEventListener('resize', function () {
            myChart.resize();
        })
    })();

    (function () {
        // 1.实例化对象
        var myChart = echarts.init(document.querySelector(".bar2 .chart"));

        // 声明颜色数组
        var myColor = ["#1089E7", "#F57474", "#56D0E3", "#F8B448", "#8B78F6"];
        // 2.指定配置项和数据
        var option = {
            grid: {
                top: "10%",
                left: '22%',
                bottom: '10%',
                // containLabel: true
            },
            xAxis: {
                // 不显示x轴相关信息
                show: false
            },
            yAxis: [{
                type: 'category',
                // y轴数据反转，与数组的顺序一致
                inverse: true,
                // 不显示y轴线和刻度
                axisLine: {
                    show: false
                },
                axisTick: {
                    show: false
                },
                // 将刻度标签文字设置为白色
                axisLabel: {
                    color: "#fff"
                },
                data: ${ReserveNode}
            }, {
                // y轴数据反转，与数组的顺序一致
                inverse: true,
                show: true,
                // 不显示y轴线和刻度
                axisLine: {
                    show: false
                },
                axisTick: {
                    show: false
                },
                // 将刻度标签文字设置为白色
                axisLabel: {
                    color: "#fff"
                },
                data: ${NodeNum}
            }],
            series: [{
                // 第一组柱子（条状）
                name: '条',
                type: 'bar',
                // 柱子之间的距离
                barCategoryGap: 50,
                // 柱子的宽度
                barWidth: 10,
                // 层级 相当于z-index
                yAxisIndex: 0,
                // 柱子更改样式
                itemStyle: {
                    barBorderRadius: 20,
                    // 此时的color可以修改柱子的颜色
                    color: function (params) {
                        // params 传进来的是柱子的对象
                        // dataIndex 是当前柱子的索引号
                        // console.log(params);
                        return myColor[params.dataIndex];
                    }
                },
                data:${NodeCount},
                // 显示柱子内的百分比文字
                label: {
                    show: true,
                    position: "inside",
                    // {c} 会自动解析为数据（data内的数据）
                    formatter: "{c}%"
                }
            },
                {
                    // 第二组柱子（框状 border）
                    name: '框',
                    type: 'bar',
                    // 柱子之间的距离
                    barCategoryGap: 50,
                    // 柱子的宽度
                    barWidth: 14,
                    // 层级 相当于z-index
                    yAxisIndex: 1,
                    // 柱子修改样式
                    itemStyle: {
                        color: "none",
                        borderColor: "#00c1de",
                        borderWidth: 2,
                        barBorderRadius: 15,
                    },
                    data: [100, 100, 100, 100, 100]
                }
            ]
        };
        // 3.把配置项给实例对象
        myChart.setOption(option);

        // 4.让图表随屏幕自适应
        window.addEventListener('resize', function () {
            myChart.resize();
        })
    })();

    function Color(l)
    {
        console.log("color---------------------")
        console.log(l)
        for (var i = 0; i < labels.length; i++) {
            if (labels[i]==l) {
                return i;
            }
        }

        return 1;
    }
    var app = new Vue({
        el: '#app',
        data: {
            nodename:'',
            Details:' ',
            svg:null,
            timer:null,
            editor:null,
            simulation:null,
            linkGroup:null,
            linktextGroup:null,
            nodeGroup:null,
            nodetextGroup:null,
            nodesymbolGroup:null,
            nodebuttonGroup:null,
            nodebuttonAction:'',
            txx:{},
            tyy:{},
            colorList: ["#ff8373", "#f9c62c", "#a5ca34", "#6fce7a", "#70d3bd", "#ea91b0"],
            color5: '#ff4500',
            predefineColors: ['#ff4500', '#ff8c00', '#90ee90', '#00ced1', '#1e90ff', '#c71585'],
            defaultcr: 30,
            selectnodeid: 0,
            selectnodename: '',
            selectsourcenodeid: 0,
            selecttargetnodeid: 0,
            graph: {
                nodes: [],
                links: []
            },
            graphEntity: {
                uuid: 0,
                name: '',
                color: 'ff4500',
                r: 30,
                x: "",
                y: ""
            },

            dialogFormVisible: false,
            headers: {},
        },
        mounted() {
            var token = $("meta[name='_csrf']").attr("content");
            var header = $("meta[name='_csrf_header']").attr("content");
            var str = '{ "' + header + '": "' + token + '"}';
            this.headers = eval('(' + str + ')');
            this.initgraph();
            this.updategraph();
            this.init()
        },
        created() {
            this.graph.nodes = jsondata.node;
            this.graph.links = jsondata.relationship;
            console.log("--------------created");
        },
        methods: {
            $message(msgObj){
                console.log('$message')
                console.log(msgObj)
                alert(msgObj.message);
                //alert(xx);
            },
            $confirm(msgObj){
                console.log('$confirm')
                console.log(msgObj)
                //alert(xx);
            },
            $prompt(msgObj){
                console.log('$prompt')
                console.log(msgObj)
            },
            init() {
                //2.初始化
                console.log(document.getElementById('main'))
                /*var myChart = this.$echarts.init(document.getElementById('main'));
                // 2.指定配置项和数据
                var option = {
                    color: ['#2f89cf'],
                    // 提示框组件
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: { // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    // 修改图表位置大小
                    grid: {
                        left: '0%',
                        top: '10px',
                        right: '0%',
                        bottom: '4%',
                        containLabel: true
                    },
                    // x轴相关配置
                    xAxis: [{
                        type: 'category',
                        data: ${labels},
                        axisTick: {
                            alignWithLabel: true
                        },
                        // 修改刻度标签，相关样式
                        axisLabel: {
                            color: "rgba(255,255,255,0.8)",
                            fontSize: 10
                        },
                        // x轴样式不显示
                        axisLine: {
                            show: false
                        }
                    }],
                    // y轴相关配置
                    yAxis: [{
                        type: 'value',
                        // 修改刻度标签，相关样式
                        axisLabel: {
                            color: "rgba(255,255,255,0.6)",
                            fontSize: 12
                        },
                        // y轴样式修改
                        axisLine: {
                            lineStyle: {
                                color: "rgba(255,255,255,0.6)",
                                width: 2
                            }
                        },
                        // y轴分割线的颜色
                        splitLine: {
                            lineStyle: {
                                color: "rgba(255,255,255,0.1)"
                            }
                        }
                    }],
                    // 系列列表配置
                    series: [{
                        name: '直接访问',
                        type: 'bar',
                        barWidth: '35%',
                        // ajax传动态数据
                        data: ${nums},
                        itemStyle: {
                            // 修改柱子圆角
                            barBorderRadius: 5
                        }
                    }]
                };
                // 3.把配置项给实例对象
                myChart.setOption(option);

                // 4.让图表随屏幕自适应
                window.addEventListener('resize', function () {
                    myChart.resize();
                })*/

                console.log(labels);

                /*const data = genData(50);
                let option1 = {
                    title: {
                        text: '节点个数统计',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{a} <br/>{b} : {c} ({d}%)'
                    },
                    legend: {
                        type: 'scroll',
                        orient: 'vertical',
                        right: 10,
                        top: 20,
                        bottom: 20,
                        data: ${labels},
                        borderColor: '#5b6270'
                    },
                    /!*grid:{
                        show:true,
                        borderColor: '#ccc',
                        borderWidth: 1
                    },*!/
                    series: [
                        {
                            name: '节点',
                            type: 'pie',
                            radius: '40%',
                            center: ['30%', '50%'],
                            data: ${Count},
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                    /!*title: {
                        text: '各类型节点占比示意图',
                        left: 'center'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                        data: ${labels}
                    },
                    series: [
                        {
                            name: '数量',
                            type: 'pie',
                            radius: '55%',
                            center: ['50%', '60%'],
                            data:
                            ${Count}
                            ,
                        }
                    ]*!/
                };
                var myChart1 = this.$echarts.init(document.getElementById('main1'),'dark');
                myChart1.setOption(option1);
                console.log(${labels});*/
            },
            test()
            {
                this.nodename="11111";
            },
            update()
            {
                console.log("-----------------test")
                this.graph.links.splice(0,this.graph.links.length);
                this.graph.nodes.splice(0,this.graph.nodes.length);
                this.updategraph();
            },
            Search(){
                console.log("----------------Search");
                var _this = this;
                var data = {domain: _this.domain, nodename: _this.nodename};
                data.domain = _this.domain;
                $.ajax({
                    data: data,
                    type: "POST",
                    traditional: true,
                    url: contextRoot+"Neo/SearchNode",
                    success: function (result) {
                        console.log("successssssssssssssssss");
                        console.log(result)
                        if (result.resp_msg=="ok") {
                            console.log(result.msg);
                            d3.select('.graphcontainer').style("cursor", "");
                            if (_this.graphEntity.uuid != 0) {
                                for (var i = 0; i < _this.graph.nodes.length; i++) {
                                    if (_this.graph.nodes[i].uuid == _this.graphEntity.uuid) {
                                        _this.graph.nodes.splice(i, 1);
                                    }
                                }
                            }
                            var newnode = result.datas.node[0];
                            /*newnode.fx=100;
                            newnode.fy=100;*/
                            _this.update();
                            var graphcontainer = d3.select(".graphcontainer");
                            var width = graphcontainer._groups[0][0].offsetWidth;
                            console.log(width);
                            var height =600;
                            _this.simulation = d3.forceSimulation()
                                //线长
                                .force("link", d3.forceLink().distance(200).id(function (d) {
                                    return d.uuid
                                }))
                                .force("charge", d3.forceManyBody().strength(-400))
                                .force("collide", d3.forceCollide().strength(-30))
                                .force("center", d3.forceCenter(width / 2, (height - 200) / 2));
                            _this.graph.nodes.push(newnode);
                            _this.svg.x=0;
                            _this.svg.y=0;
                            _this.updategraph();
                            _this.isedit = false;
                        }
                        else{
                            alert("未找到该节点！");
                        }
                    },
                    error: function () {
                        alert("未找到该节点！");
                    }
                });
                /*console.log(this.nodename);
                this.initgraph();*/
            },
            SearchNode(name)
            {
                console.log("----------------SearchNode");
                var _this = this;
                var data = {nodename: name};
                $.ajax({
                    data: data,
                    type: "POST",
                    traditional: true,
                    url: contextRoot + "Neo/SearchNode",
                    success: function (result) {
                        console.log("successssssssssssssssss");
                        console.log(result)
                        if (result.resp_msg=="ok") {
                            console.log(result.msg);
                            d3.select('.graphcontainer').style("cursor", "");
                            if (_this.graphEntity.uuid != 0) {
                                for (var i = 0; i < _this.graph.nodes.length; i++) {
                                    if (_this.graph.nodes[i].uuid == _this.graphEntity.uuid) {
                                        _this.graph.nodes.splice(i, 1);
                                    }
                                }
                            }
                            var newnode = result.datas.node[0];
                            /*newnode.x = _this.txx;
                            newnode.y = _this.tyy;
                            newnode.fx = _this.txx;
                            newnode.fy = _this.tyy;*/
                            _this.update();
                            var graphcontainer = d3.select(".graphcontainer");
                            var width = graphcontainer._groups[0][0].offsetWidth;
                            console.log(width);
                            var height =600;
                            _this.simulation = d3.forceSimulation()
                                //线长
                                .force("link", d3.forceLink().distance(200).id(function (d) {
                                    return d.uuid
                                }))
                                .force("charge", d3.forceManyBody().strength(-400))
                                .force("collide", d3.forceCollide().strength(-30))
                                .force("center", d3.forceCenter(width / 2, (height - 200) / 2));
                            _this.graph.nodes.push(newnode);
                            _this.updategraph();
                            _this.isedit = false;
                        }
                        else{
                            alert("未找到该节点！");
                        }
                    },
                    error: function () {
                        alert("未找到该节点！");
                    }
                });
            },
            SearchLabel(la)
            {
                console.log("----------------SearchNode");
                var _this = this;
                var data = {label: la};
                $.ajax({
                    data: data,
                    type: "POST",
                    traditional: true,
                    url: contextRoot + "Neo/SearchLabel",
                    success: function (result) {
                        console.log("successssssssssssssssss");
                        console.log(result)
                        if (result.resp_msg=="ok") {
                            console.log(result.msg);
                            d3.select('.graphcontainer').style("cursor", "");
                            /*if (_this.graphEntity.uuid != 0) {
                                for (var i = 0; i < _this.graph.nodes.length; i++) {
                                    if (_this.graph.nodes[i].uuid == _this.graphEntity.uuid) {
                                        _this.graph.nodes.splice(i, 1);
                                    }
                                }
                            }*/
                            _this.update();
                            var newnode;
                            var newlink;
                            for(var i=0;i<result.datas.node.length;i++)
                            {
                                newnode = result.datas.node[i];
                                _this.graph.nodes.push(newnode);
                            }
                            for(var i=0;i<result.datas.relationship.length;i++)
                            {
                                newlink=result.datas.relationship[i];
                                _this.graph.links.push(newlink);
                            }
                            var graphcontainer = d3.select(".graphcontainer");
                            var width = graphcontainer._groups[0][0].offsetWidth;
                            console.log(width);
                            var height =600;
                            _this.simulation = d3.forceSimulation()
                                //线长
                                .force("link", d3.forceLink().distance(200).id(function (d) {
                                    return d.uuid
                                }))
                                .force("charge", d3.forceManyBody().strength(-400))
                                .force("collide", d3.forceCollide().strength(-30))
                                .force("center", d3.forceCenter(width / 2, (height - 200) / 2));
                            _this.updategraph();
                            _this.isedit = false;
                        }
                        else{
                            alert("未找到该节点！");
                        }
                    },
                    error: function () {
                        alert("未找到该节点！");
                    }
                });
            },
            getNodeDetail(_uuid){
                console.log("detailllllllllllllllll");
                console.log(_uuid)
            },
            getcurrentnodeinfo(_d){
                console.log(_d)
            },
            btnaddsingle(){
                d3.select('.graphcontainer').style("cursor", "crosshair");//进入新增模式，鼠标变成＋
            },
            btndeletelink() {
                this.isdeletelink = true;
                d3.select('.link').attr("class", "link linkdelete"); // 修改鼠标样式为"+"
            },
            selectTheNode(_d){
                console.log('selectTheNode---');
                var _this = this;
                console.log(this)
                console.log(_d)
                var _uuid=_d.uuid;
                //var data = {uuid:_uuid};
                $.ajax({
                    data: "uuid="+_uuid,
                    type: "GET",
                    url: contextRoot + "NEO/getNodeByUuid",
                    success: function (result) {
                        //result=JSON.parse(resultStr)
                        console.log(result)
                        if (result.resp_code == 0) {
                            //neoBackData(iframeId,inputId1,inputId1Data,inputId2,inputId2Data)
                            parent.neoBackData(iframeId,inputId1,result.resp_msg,inputId2,result.datas);

                        }
                    },
                    error: function (data) {
                    }
                });


            },
            showTheNodeDtlInfo(_d){
                /*var str1=_d.p.slice(0,25);
                var str2=_d.p.slice(26,50);
                var str3=_d.p.slice(50,_d.p.length);

                this.$Modal.info({title:"节点详情",content:str1+'</br>'+str2+'</br>'+str3});*/
                this.$message({
                    type: 'info',
                    message: _d.p
                });
            },
            getmorenode(_d) {
                console.log('getmorenode---');
                var _this = this;
                var data = {domain: _this.domain, nodeid: _d.uuid};
                console.log(_d);
                $.ajax({
                    data: data,
                    type: "POST",
                    url: contextRoot + "Neo/getMoreRelationnode",
                    success: function (result) {
                        //result=JSON.parse(resultStr)
                        //console.log(result)
                        if (result.resp_code == 0) {
                            var newnodes = result.datas.node;
                            var newships = result.datas.relationship;
                            var oldnodescount = _this.graph.nodes.length;
                            newnodes.forEach(function (m) {
                                var sobj = _this.graph.nodes.find(function (x) {
                                    return x.uuid === m.uuid
                                })
                                if (typeof(sobj) == "undefined") {
                                    _this.graph.nodes.push(m);
                                }
                            })
                            var newnodescount = _this.graph.nodes.length;
                            if (newnodescount <= oldnodescount) {
                                /*_this.$message({
                                    message: '没有更多节点信息',
                                    type: 'success'
                                });*/
                                parent.alert('没有更多节点信息');
                                return;
                            }
                            newships.forEach(function (m) {
                                var sobj = _this.graph.links.find(function (x) {
                                    return x.uuid === m.uuid
                                })
                                if (typeof(sobj) == "undefined") {
                                    _this.graph.links.push(m);
                                }
                            })
                            _this.updategraph();
                        }
                    },
                    error: function (data) {
                    }
                });
            },
            initgraph(){
                console.log(nums);
                console.log(labels);
                var graphcontainer = d3.select(".graphcontainer");
                var width = graphcontainer._groups[0][0].offsetWidth;
                console.log(width);
                var height =window.screen.height/2;// window.screen.height - 154;//
                console.log('---------------initgraph()')
                console.log(graphcontainer)
                this.svg = graphcontainer.append("svg");
                /*width=1000;*/
                this.svg.x=0;
                this.svg.y=0;
                this.svg.attr("width", width);
                this.svg.attr("height", height);
                this.simulation = d3.forceSimulation()
                    //线长
                    .force("link", d3.forceLink().distance(200).id(function (d) {
                        return d.uuid
                    }))
                    .force("charge", d3.forceManyBody().strength(-400))
                    .force("collide", d3.forceCollide().strength(-30))
                    .force("center", d3.forceCenter(width / 2, (height - 200) / 2));

                this.linkGroup = this.svg.append("g").attr("class", "line");
                this.linktextGroup = this.svg.append("g").attr("class", "linetext");

                this.nodeGroup = this.svg.append("g").attr("class", "node");
                this.nodetextGroup = this.svg.append("g").attr("class", "nodetext");

                this.nodesymbolGroup = this.svg.append("g").attr("class", "nodesymbol");
                this.nodebuttonGroup = this.svg.append("g").attr("class", "nodebutton");
                this.addmaker();
                this.addnodebutton();
                this.svg.on('click',function(){
                    d3.selectAll("use").classed("circle_opreate", true);
                }, 'false');

            },
            updategraph() {
                var _this = this;
                var lks = this.graph.links;
                var nodes = this.graph.nodes;
                var links = [];
                this.svg.x=0;
                this.svg.y=0;
                lks.forEach(function (m) {
                    var sourceNode = nodes.filter(function (n) {
                        return n.uuid === m.sourceid;
                    })[0];
                    if (typeof(sourceNode) == 'undefined') return;
                    var targetNode = nodes.filter(function (n) {
                        return n.uuid === m.targetid;
                    })[0];
                    if (typeof(targetNode) == 'undefined') return;
                    links.push({source: sourceNode.uuid, target: targetNode.uuid, lk: m});
                });
                if(links.length>0){
                    _.each(links, function(link) {
                        var same = _.where(links, {
                            'source': link.source,
                            'target': link.target
                        });
                        var sameAlt = _.where(links, {
                            'source': link.target,
                            'target': link.source
                        });
                        var sameAll = same.concat(sameAlt);
                        _.each(sameAll, function(s, i) {
                            s.sameIndex = (i + 1);
                            s.sameTotal = sameAll.length;
                            s.sameTotalHalf = (s.sameTotal / 2);
                            s.sameUneven = ((s.sameTotal % 2) !== 0);
                            s.sameMiddleLink = ((s.sameUneven === true) &&(Math.ceil(s.sameTotalHalf) === s.sameIndex));
                            s.sameLowerHalf = (s.sameIndex <= s.sameTotalHalf);
                            s.sameArcDirection = 1;
                            //s.sameArcDirection = s.sameLowerHalf ? 0 : 1;
                            s.sameIndexCorrected = s.sameLowerHalf ? s.sameIndex : (s.sameIndex - Math.ceil(s.sameTotalHalf));
                        });
                    });
                    var maxSame = _.chain(links)
                        .sortBy(function(x) {
                            return x.sameTotal;
                        })
                        .last()
                        .value().sameTotal;

                    _.each(links, function(link) {
                        link.maxSameHalf = Math.round(maxSame / 2);
                    });
                }
                // 更新连线 links
                var link = _this.linkGroup.selectAll(".line >path").data(links, function (d) {
                    return d.uuid;
                });
                link.exit().remove();
                var linkEnter = _this.drawlink(link);
                link = linkEnter.merge(link);
                // 更新连线文字
                var linktext = _this.linktextGroup.selectAll("text").data(links, function (d) {
                    return d.uuid;
                });
                linktext.exit().remove();
                var linktextEnter = _this.drawlinktext(linktext);
                linktext = linktextEnter.merge(linktext).text(function (d) {
                    return d.lk.name;
                });
                // 更新节点按钮组
                d3.selectAll(".nodebutton  >g").remove();
                var nodebutton = _this.nodebuttonGroup.selectAll(".nodebutton").data(nodes, function (d) {
                    return d
                });
                nodebutton.exit().remove();
                var nodebuttonEnter = _this.drawnodebutton(nodebutton);
                nodebutton = nodebuttonEnter.merge(nodebutton);
                // 更新节点
                var node = _this.nodeGroup.selectAll("circle").data(nodes, function (d) {
                    return d
                });
                node.exit().remove();
                var nodeEnter = _this.drawnode(node);
                node = nodeEnter.merge(node).text(function (d) {
                    return d.name;
                });
                // 更新节点文字
                var nodetext = _this.nodetextGroup.selectAll("text").data(nodes, function (d) {
                    return d.uuid
                });
                nodetext.exit().remove();
                var nodetextEnter = _this.drawnodetext(nodetext);
                nodetext = nodetextEnter.merge(nodetext).text(function (d) {
                    return d.name;
                });
                nodetext.append("title")// 为每个节点设置title
                    .text(function (d) {
                        return d.name;
                    });
                // 更新节点标识
                var nodesymbol = _this.nodesymbolGroup.selectAll("path").data(nodes, function (d) {
                    return d.uuid;
                });
                nodesymbol.exit().remove();
                var nodesymbolEnter = _this.drawnodesymbol(nodesymbol);
                nodesymbol = nodesymbolEnter.merge(nodesymbol);
                nodesymbol.attr("fill", "#e15500");
                nodesymbol.attr("display", function (d) {
                    if (typeof(d.hasfile) != "undefined" && d.hasfile > 0) {
                        return "block";
                    }
                    return "none";
                })
                _this.simulation.nodes(nodes).on("tick", ticked);
                _this.simulation.force("link").links(links);
                _this.simulation.alphaTarget(0).restart();
                function linkArc(d) {
                    var dx = (d.target.x - d.source.x),
                        dy = (d.target.y - d.source.y),
                        dr = Math.sqrt(dx * dx + dy * dy),
                        unevenCorrection = (d.sameUneven ? 0 : 0.5);
                    var curvature = 2,
                        arc = (1.0/curvature)*((dr * d.maxSameHalf) / (d.sameIndexCorrected - unevenCorrection));
                    if (d.sameMiddleLink) {
                        arc = 0;
                    }
                    var dd="M" + d.source.x + "," + d.source.y + "A" + arc + "," + arc + " 0 0," + d.sameArcDirection + " " + d.target.x + "," + d.target.y;
                    return dd;
                }

                function ticked() {
                    // 更新连线坐标
                    /*link.attr("x1", function (d) {
                        return d.source.x;
                       })
                        .attr("y1", function (d) {
                            return d.source.y;
                        })
                        .attr("x2", function (d) {
                            return d.target.x;
                        })
                        .attr("y2", function (d) {
                            return d.target.y;
                        });*/
                    link.attr("d", linkArc)
                    // 刷新连接线上的文字位置
                    /* linktext.attr("x", function (d) {
                         return (d.source.x + d.target.x) / 2;
                     })
                         .attr("y", function (d) {
                             return (d.source.y + d.target.y) / 2;
                         })*/


                    // 更新节点坐标
                    node.attr("cx", function (d) {
                        return d.x;
                    })
                        .attr("cy", function (d) {
                            return d.y;
                        });
                    // 更新节点操作按钮组坐标
                    nodebutton.attr("cx", function (d) {
                        return d.x;
                    })
                        .attr("cy", function (d) {
                            return d.y;
                        });
                    nodebutton.attr("transform", function (d) {
                        return "translate(" + d.x + "," + d.y+ ") scale(1)";
                    })

                    // 更新文字坐标
                    nodetext.attr("x", function (d) {
                        return d.x;
                    })
                        .attr("y", function (d) {
                            return d.y;
                        });
                    // 更新回形针坐标
                    nodesymbol.attr("transform", function (d) {

                        return "translate(" + (d.x + 8) + "," + (d.y - 30) + ") scale(0.015,0.015)";
                    })
                }
                // 鼠标滚轮缩放
                _this.svg.call(d3.zoom().on("zoom", function () {
                    d3.selectAll('.node').attr("transform",d3.event.transform);
                    d3.selectAll('.nodetext').attr("transform",d3.event.transform);
                    d3.selectAll('.line').attr("transform",d3.event.transform);
                    d3.selectAll('.linetext').attr("transform",d3.event.transform);
                    d3.selectAll('.nodesymbol').attr("transform",d3.event.transform);
                    d3.selectAll('.nodebutton').attr("transform",d3.event.transform);
                    //_this.svg.selectAll("g").attr("transform", d3.event.transform);
                }));
                _this.svg.on("dblclick.zoom", null); // 禁止双击缩放
                //按钮组事件
                _this.svg.selectAll(".buttongroup").on("click", function (d,i) {
                    console.log(_this.nodebuttonAction);
                    console.log(d);
                    if (_this.nodebuttonAction) {
                        switch (_this.nodebuttonAction) {
                            case "MORE":
                                _this.getmorenode(d);
                                break;
                            case "SELECT":
                                _this.selectnodeid=d.uuid;
                                //var out_buttongroup_id='.out_buttongroup_'+i;
                                //_this.deletenode(out_buttongroup_id);
                                _this.selectTheNode(d);
                                break;
                            case "DTL":
                                _this.showTheNodeDtlInfo(d);
                                break;
                            case "EDIT":
                                _this.isedit = true;
                                _this.propactiveName = 'propedit';
                                _this.txx=d.x;
                                _this.tyy=d.y;
                                break;
                            case "CHILD":
                                _this.operatetype = 2;
                                _this.isbatchcreate = true;
                                _this.isedit = false;
                                break;
                            case "LINK":
                                _this.isaddlink = true;
                                _this.selectsourcenodeid=d.uuid;
                                break;
                            case "DELETE":
                                _this.selectnodeid=d.uuid;
                                var out_buttongroup_id='.out_buttongroup_'+i;
                                _this.deletenode(out_buttongroup_id);
                                break;
                        }
                        ACTION = '';//重置 ACTION
                    }

                });
                //按钮组事件绑定
                _this.svg.selectAll(".action_0").on("click", function (d) {
                    _this.nodebuttonAction='MORE';//展开
                });
                _this.svg.selectAll(".action_2").on("click", function (d) {
                    _this.nodebuttonAction='SELECT';//选中
                });
                _this.svg.selectAll(".action_1").on("click", function (d) {
                    _this.nodebuttonAction='DTL';//详情
                    //_this.nodebuttonAction='CHILD_XXX';
                });
                _this.svg.selectAll(".action_3").on("click", function (d) {
                    _this.nodebuttonAction='LINK_XXX';
                });
                _this.svg.selectAll(".action_4").on("click", function (d) {
                    _this.nodebuttonAction='DELETE_XXX';
                });
                console.log('---------------upgradegraph()')
            },
            createnode() {
                var _this = this;
                var data = _this.graphEntity;
                data.domain = _this.domain;
                $.ajax({
                    data: data,
                    type: "POST",
                    traditional: true,
                    url: contextRoot + "createnode",
                    success: function (result) {
                        if (result.code == 200) {
                            d3.select('.graphcontainer').style("cursor", "");
                            if (_this.graphEntity.uuid != 0) {
                                for (var i = 0; i < _this.graph.nodes.length; i++) {
                                    if (_this.graph.nodes[i].uuid == _this.graphEntity.uuid) {
                                        _this.graph.nodes.splice(i, 1);
                                    }
                                }
                            }
                            var newnode = result.data;
                            newnode.x = _this.txx;
                            newnode.y = _this.tyy;
                            newnode.fx = _this.txx;
                            newnode.fy = _this.tyy;
                            _this.graph.nodes.push(newnode);
                            _this.resetentity();
                            _this.updategraph();
                            _this.isedit = false;
                            _this.resetsubmit();
                        }
                    }
                });
            },
            addmaker() {
                var arrowMarker = this.svg.append("marker")
                    .attr("id", "arrow")
                    .attr("markerUnits", "strokeWidth")
                    .attr("markerWidth", "20")//
                    .attr("markerHeight", "20")
                    .attr("viewBox", "0 -5 10 10")
                    .attr("refX", "22")// 13
                    .attr("refY", "0")
                    .attr("orient", "auto");
                var arrow_path = "M0,-5L10,0L0,5";// 定义箭头形状
                arrowMarker.append("path").attr("d", arrow_path).attr("fill", "#fce6d4");
            },
            addnodebutton() {
                var _this = this;
                var nodebutton = this.svg.append("defs").append("g")
                    .attr("id", "out_circle")
                var database = [1,1,1,1,1];
                var pie = d3.pie();
                var piedata = pie(database);
                var buttonEnter=nodebutton.selectAll(".buttongroup")
                    .data(piedata)
                    .enter()
                    .append("g")
                    .attr("class", function (d, i) {
                        return "action_" + i ;
                    });
                var arc = d3.arc()
                    .innerRadius(30)
                    .outerRadius(60);
                buttonEnter.append("path")
                    .attr("d", function (d) {
                        return arc(d)
                    })
                    .attr("fill", "#D2D5DA")
                    .style("opacity", 0.6)
                    .attr("stroke", "#f0f0f4")
                    .attr("stroke-width", 2);
                buttonEnter.append("text")
                    .attr("transform", function (d, i) {
                        return "translate(" + arc.centroid(d) + ")";
                    })
                    .attr("text-anchor", "middle")
                    .text(function (d, i) {
                        var zi = new Array()

                        /* zi[0] = "编辑";
                         zi[1] = "展开";
                         zi[2] = "追加";
                         zi[3] = "连线";
                         zi[4] = "删除";*/


                        zi[0] = "展开";
                        zi[1] = "详情";
                        zi[2] = "";
                        zi[3] = "";
                        zi[4] = "";

                        return zi[i]
                    })
                    .attr("font-size", 10);
            },
            dragstarted(d) {
                if (!d3.event.active) this.simulation.alphaTarget(0.3).restart();
                d.fx = d.x;
                d.fy = d.y;
                d.fixed = true;
            },
            dragged(d) {
                d.fx = d3.event.x;
                d.fy = d3.event.y;
            },
            dragended(d) {
                if (!d3.event.active) this.simulation.alphaTarget(0);
            },
            drawnode(node) {
                var _this = this;
                var nodeEnter = node.enter().append("circle");
                nodeEnter.attr("r", function (d) {
                    if (typeof(d.r) != "undefined" && d.r != '') {
                        return d.r
                    }
                    return 30;
                });
                nodeEnter.attr("fill", function (d,i) {
                    if (typeof(d.color) != "undefined" && d.color != '') {
                        return d.color
                    }
                    /*console.log(d)
                    console.log(i)
                    return "#ff4500";*/
                    let l=d.label.slice(2,d.label.length-2);
                    i=Color(l);
                    console.log(i);
                    return colorScale(i);
                });
                nodeEnter.style("opacity", 0.8);
                nodeEnter.style("stroke", function (d) {
                    if (typeof(d.color) != "undefined" && d.color != '') {
                        return d.color
                    }
                    return "#ff4500";
                });
                nodeEnter.style("stroke-opacity", 0.6);
                nodeEnter.append("title")// 为每个节点设置title
                    .text(function (d) {
                        return d.name;
                    })
                nodeEnter.on("mouseover", function (d, i) {
                    _this.Details=d.p;
                    /*_this.timer = setTimeout(function () {
                        d3.select('#richContainer')
                                .style('position', 'absolute')
                                .style('left', d.x + "px")
                                .style('top', d.y + "px")
                                .style('display', 'block');
                        _this.editorcontent = "";
                        _this.showImageList = [];
                        _this.getNodeDetail(d.uuid);
                    }, 3000);*/
                });
                nodeEnter.on("mouseout", function (d, i) {
                    clearTimeout( _this.timer);
                });
                nodeEnter.on("dblclick", function (d) {
                    app.updatenodename(d);// 双击更新节点名称
                });
                nodeEnter.on("mouseenter", function (d) {
                    _this.Details=d.p;
                    var aa = d3.select(this)._groups[0][0];
                    if (aa.classList.contains("selected")) return;
                    d3.select(this).style("stroke-width", "6");
                });
                nodeEnter.on("mouseleave", function (d) {
                    _this.Details=' ';
                    var aa = d3.select(this)._groups[0][0];
                    if (aa.classList.contains("selected")) return;
                    d3.select(this).style("stroke-width", "2");
                });
                nodeEnter.on("click", function (d,i) {
                    var out_buttongroup_id='.out_buttongroup_'+i;
                    _this.svg.selectAll("use").classed("circle_opreate", true);
                    _this.svg.selectAll(out_buttongroup_id).classed("circle_opreate", false);
                    _this.graphEntity = d;
                    _this.selectnodeid = d.uuid;
                    _this.selectnodename = d.name;

                    // 更新工具栏节点信息
                    _this.getcurrentnodeinfo(d);
                    // 添加连线状态
                    if (_this.isaddlink) {
                        _this.selecttargetnodeid = d.uuid;
                        if (_this.selectsourcenodeid == _this.selecttargetnodeid || _this.selectsourcenodeid == 0 || _this.selecttargetnodeid == 0) return;
                        _this.createlink(_this.selectsourcenodeid, _this.selecttargetnodeid, "RE")
                        _this.selectsourcenodeid = 0;
                        _this.selecttargetnodeid = 0;
                        d.fixed = false
                        d3.event.stopPropagation();
                    }
                });
                nodeEnter.call(d3.drag()
                    .on("start", _this.dragstarted)
                    .on("drag", _this.dragged)
                    .on("end", _this.dragended));
                return nodeEnter;
            },
            drawnodetext(nodetext) {
                var _this = this;
                var nodetextenter = nodetext.enter().append("text")
                    .style("fill", "#000")
                    .attr("dy", 4)
                    .attr("font-family", "微软雅黑")
                    .attr("text-anchor", "middle")
                    .text(function (d) {
                        var length = d.name.length;
                        if (d.name.length > 4) {
                            var s = d.name.slice(0, 4) + "...";
                            return s;
                        }
                        return d.name;
                    });
                nodetextenter.on("mouseover", function (d, i) {
                    _this.timer = setTimeout(function () {
                        d3.select('#richContainer')
                            .style('position', 'absolute')
                            .style('left', d.x + "px")
                            .style('top', d.y + "px")
                            .style('display', 'block');
                        _this.editorcontent = "";
                        _this.showImageList = [];
                        _this.getNodeDetail(d.uuid);



                    }, 3000);

                });

                nodetextenter.on("dblclick", function (d) {
                    app.updatenodename(d);// 双击更新节点名称
                });
                nodetextenter.on("click", function (d) {
                    $('#link_menubar').hide();// 隐藏空白处右键菜单
                    _this.graphEntity = d;
                    _this.selectnodeid = d.uuid;
                    // 更新工具栏节点信息
                    _this.getcurrentnodeinfo(d);
                    // 添加连线状态
                    if (_this.isaddlink) {
                        _this.selecttargetnodeid = d.uuid;
                        if (_this.selectsourcenodeid == _this.selecttargetnodeid || _this.selectsourcenodeid == 0 || _this.selecttargetnodeid == 0) return;
                        _this.createlink(_this.selectsourcenodeid, _this.selecttargetnodeid, "RE")
                        _this.selectsourcenodeid = 0;
                        _this.selecttargetnodeid = 0;
                        d.fixed = false
                        d3.event.stopPropagation();
                    }
                });

                return nodetextenter;
            },
            drawnodesymbol(nodesymbol) {
                var _this = this;
                var symnol_path = "M566.92736 550.580907c30.907733-34.655573 25.862827-82.445653 25.862827-104.239787 0-108.086613-87.620267-195.805867-195.577173-195.805867-49.015467 0-93.310293 18.752853-127.68256 48.564907l-0.518827-0.484693-4.980053 4.97664c-1.744213 1.64864-3.91168 2.942293-5.59104 4.72064l0.515413 0.484693-134.69696 133.727573L216.439467 534.8352l0 0 137.478827-136.31488c11.605333-10.410667 26.514773-17.298773 43.165013-17.298773 36.051627 0 65.184427 29.197653 65.184427 65.24928 0 14.032213-5.33504 26.125653-12.73856 36.829867l-131.754667 132.594347 0.515413 0.518827c-10.31168 11.578027-17.07008 26.381653-17.07008 43.066027 0 36.082347 29.16352 65.245867 65.184427 65.245867 16.684373 0 31.460693-6.724267 43.035307-17.07008l0.515413 0.512M1010.336427 343.49056c0-180.25472-145.882453-326.331733-325.911893-326.331733-80.704853 0-153.77408 30.22848-210.418347 79.0528l0.484693 0.64512c-12.352853 11.834027-20.241067 28.388693-20.241067 46.916267 0 36.051627 29.16352 65.245867 65.211733 65.245867 15.909547 0 29.876907-6.36928 41.192107-15.844693l0.38912 0.259413c33.624747-28.030293 76.301653-45.58848 123.511467-45.58848 107.99104 0 195.549867 87.6544 195.549867 195.744427 0 59.815253-27.357867 112.71168-69.51936 148.503893l0 0-319.25248 317.928107 0 0c-35.826347 42.2912-88.654507 69.710507-148.340053 69.710507-107.956907 0-195.549867-87.68512-195.549867-195.805867 0-59.753813 27.385173-112.646827 69.515947-148.43904l-92.18048-92.310187c-65.69984 59.559253-107.700907 144.913067-107.700907 240.749227 0 180.28544 145.885867 326.301013 325.915307 326.301013 95.218347 0 180.02944-41.642667 239.581867-106.827093l0.13312 0.129707 321.061547-319.962453-0.126293-0.13312C968.69376 523.615573 1010.336427 438.71232 1010.336427 343.49056L1010.336427 343.49056 1010.336427 343.49056zM1010.336427 343.49056";// 定义回形针形状
                var nodesymbolEnter = nodesymbol.enter().append("path").attr("d", symnol_path);
                nodesymbolEnter.call(d3.drag()
                    .on("start", _this.dragstarted)
                    .on("drag", _this.dragged)
                    .on("end", _this.dragended));
                console.log("dragggggggggggggggggggg");
                return nodesymbolEnter;
            },
            drawnodebutton(nodebutton) {
                var _this = this;
                var nodebuttonEnter = nodebutton.enter().append("g").append("use")//  为每个节点组添加一个 use 子元素
                    .attr("r", function(d){
                        return d.r;
                    })
                    .attr("xlink:href", "#out_circle") //  指定 use 引用的内容
                    .attr('class',function(d,i){
                        return 'buttongroup out_buttongroup_'+i;
                    })
                    .classed("circle_opreate", true);

                return nodebuttonEnter;
            },
            drawlink(link) {
                var _this = this;
                var linkEnter = link.enter().append("path")
                    .attr("stroke-width", 1)
                    .attr("stroke", "#fce6d4")
                    .attr("fill", "none")
                    .attr("id", function (d) {
                        return "invis_" + d.lk.sourceid + "-" + d.lk.name + "-" + d.lk.targetid;
                    })
                    .attr("marker-end", "url(#arrow)")
                ;// 箭头
                linkEnter.on("dblclick", function (d) {
                    _this.selectnodeid = d.lk.uuid;
                    if (_this.isdeletelink) {
                        _this.deletelink();
                    } else {
                        _this.updatelinkName();
                    }
                });
                linkEnter.on("contextmenu", function (d) {
                    var cc = $(this).offset();
                    app.selectnodeid = d.lk.uuid;
                    app.selectlinkname = d.lk.name;
                    d3.select('#link_menubar')
                        .style('position', 'absolute')
                        .style('left', cc.left + "px")
                        .style('top', cc.top + "px")
                        .style('display', 'block');
                    d3.event.preventDefault();// 禁止系统默认右键
                    d3.event.stopPropagation();// 禁止空白处右键
                });
                linkEnter.on("mouseenter", function (d) {
                    d3.select(this).style("stroke-width", "6").attr("stroke", "#ff9e9e").attr("marker-end", "url(#arrow2)");
                });
                linkEnter.on("mouseleave", function (d) {
                    d3.select(this).style("stroke-width", "1").attr("stroke", "#fce6d4").attr("marker-end", "url(#arrow)");
                });
                return linkEnter;
            },
            drawlinktext(link) {
                var linktextEnter = link.enter().append('text')
                    .style('fill', '#e3af85')
                    .append("textPath")
                    .attr("startOffset", "50%")
                    .attr("text-anchor", "middle")
                    .attr("xlink:href", function(d) {
                        return "#invis_" + d.lk.sourceid + "-" + d.lk.name + "-" + d.lk.targetid;
                    })
                    .style("font-size", 14)
                    .text(function (d) {
                        if (d.lk.name != '') {
                            return d.lk.name;
                        }
                    });

                linktextEnter.on("mouseover", function (d) {
                    app.selectnodeid = d.lk.uuid;
                    app.selectlinkname = d.lk.name;
                    var cc = $(this).offset();
                    d3.select('#link_menubar')
                        .style('position', 'absolute')
                        .style('left', cc.left + "px")
                        .style('top', cc.top + "px")
                        .style('display', 'block');
                });

                return linktextEnter;
            },
            deletenode(out_buttongroup_id) {
                var _this = this;
                _this.$confirm('此操作将删除该节点及周边关系(不可恢复), 是否继续?', '三思而后行', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    var data = {domain: _this.domain, nodeid: _this.selectnodeid};
                    $.ajax({
                        data: data,
                        type: "POST",
                        url: contextRoot + "deletenode",
                        success: function (result) {
                            if (result.code == 200) {
                                _this.svg.selectAll(out_buttongroup_id).remove();
                                var rships = result.data;
                                // 删除节点对应的关系
                                for (var m = 0; m < rships.length; m++) {
                                    for (var i = 0; i < _this.graph.links.length; i++) {
                                        if (_this.graph.links[i].uuid == rships[m].uuid) {
                                            _this.graph.links.splice(i, 1);
                                            i = i - 1;
                                        }
                                    }
                                }
                                // 找到对应的节点索引
                                var j = -1;
                                for (var i = 0; i < _this.graph.nodes.length; i++) {
                                    if (_this.graph.nodes[i].uuid == _this.selectnodeid) {
                                        j = i;
                                        break;
                                    }
                                }
                                if (j >= 0) {
                                    _this.selectnodeid = 0;
                                    _this.graph.nodes.splice(i, 1);// 根据索引删除该节点
                                    _this.updategraph();
                                    _this.resetentity();
                                    _this.$message({
                                        type: 'success',
                                        message: '操作成功!'
                                    });
                                }

                            }
                        }
                    })
                }).catch(function () {
                    _this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            deletelink() {
                var _this = this;
                this.$confirm('此操作将删除该关系(不可恢复), 是否继续?', '三思而后行', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(function () {
                    var data = {domain: _this.domain, shipid: _this.selectnodeid};
                    $.ajax({
                        data: data,
                        type: "POST",
                        url: contextRoot + "deletelink",
                        success: function (result) {
                            if (result.code == 200) {
                                var j = -1;
                                for (var i = 0; i < _this.graph.links.length; i++) {
                                    if (_this.graph.links[i].uuid == _this.selectnodeid) {
                                        j = i;
                                        break;
                                    }
                                }
                                if (j >= 0) {
                                    _this.selectnodeid = 0;
                                    _this.graph.links.splice(i, 1);
                                    _this.updategraph();
                                    _this.isdeletelink = false;
                                }
                            }
                        }
                    });
                }).catch(function () {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
            },
            createlink(sourceId, targetId, ship) {
                var _this = this;
                var data = {domain: _this.domain, sourceid: sourceId, targetid: targetId, ship: ''};
                $.ajax({
                    data: data,
                    type: "POST",
                    url: contextRoot + "createlink",
                    success: function (result) {
                        if (result.code == 200) {
                            var newship = result.data;
                            _this.graph.links.push(newship);
                            _this.updategraph();
                            _this.isaddlink = false;
                        }
                    }
                });
            },
            updatelinkName() {
                var _this = this;
                _this.$prompt('请输入关系名称', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    inputValue: this.selectlinkname
                }).then(function (res) {
                    value=res.value;
                    var data = {domain: _this.domain, shipid: _this.selectnodeid, shipname: value};
                    $.ajax({
                        data: data,
                        type: "POST",
                        url: contextRoot + "updatelink",
                        success: function (result) {
                            if (result.code == 200) {
                                var newship = result.data;
                                _this.graph.links.forEach(function (m) {
                                    if (m.uuid == newship.uuid) {
                                        m.name = newship.name;
                                    }
                                });
                                _this.selectnodeid = 0;
                                _this.updategraph();
                                _this.isaddlink = false;
                                _this.selectlinkname = '';
                            }
                        }
                    });
                }).catch(function () {
                    _this.$message({
                        type: 'info',
                        message: '取消输入'
                    });
                });
            },
            updatenodename(d) {
                /*var _this = this;
                _this.$prompt('编辑节点名称', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    inputValue: d.name
                }).then(function (res) {
                    value=res.value;
                    var data = {domain: _this.domain, nodeid: d.uuid, nodename: value};
                    $.ajax({
                        data: data,
                        type: "POST",
                        url: contextRoot + "updatenodename",
                        success: function (result) {
                            if (result.code == 200) {
                                if (d.uuid != 0) {
                                    for (var i = 0; i < _this.graph.nodes.length; i++) {
                                        if (_this.graph.nodes[i].uuid == d.uuid) {
                                            _this.graph.nodes[i].name = value;
                                        }
                                    }
                                }
                                _this.updategraph();
                                _this.$message({
                                    message: '操作成功',
                                    type: 'success'
                                });
                            }
                        }
                    });
                }).catch(function () {
                    _this.$message({
                        type: 'info',
                        message: '取消操作'
                    });
                });*/
            },
        }
    })
    $(function () {
        $(".blankmenubar").click(function () {
            $('#blank_menubar').hide();
        })
        $(".blankmenubar").mouseleave(function () {
            $('#blank_menubar').hide();
        })
        $(".graphcontainer").bind("contextmenu", function (event) {
            app.svg.selectAll("use").classed("circle_opreate", true);
            var left = event.clientX;
            var top = event.clientY;
            document.getElementById('blank_menubar').style.position = 'absolute';
            document.getElementById('blank_menubar').style.left = left + 'px';
            document.getElementById('blank_menubar').style.top = top + 'px';
            $('#blank_menubar').show();
            event.preventDefault();
        });
        $(".graphcontainer").bind("click", function (event) {
            var cursor=document.getElementById("graphcontainer").style.cursor;
            if(cursor=='crosshair'){
                d3.select('.graphcontainer').style("cursor", "");
                app.txx=event.offsetX;
                app.tyy=event.offsetY;
                app.createnode();
            }
            event.preventDefault();
        });

        $(".linkmenubar").bind("mouseleave", function (event) {
            d3.select('#link_menubar').style('display', 'none');
        });
        $("body").bind("mousedown", function (event) {
            if (!(event.target.id === "link_menubar" || $(event.target).parents("#link_menubar").length > 0)) {
                $("#link_menubar").hide();
            }
            if (!(event.target.id === "linkmenubar" || $(event.target).parents("#linkmenubar").length > 0)) {
                $("#linkmenubar").hide();
            }

        });
    })
    function getNodeDetail(uuid){

        console.log(uuid)
    }
    function changeURL1(e,thisObj) {
        var selectIndex=e.target.selectedIndex;
        var optionDom=e.target[selectIndex];
        //location.href= baseRoot+'reservePlan/editorkPage/'+rpid+'/'+thisNodeId;
        var href=location.href;
        //console.log(href);
        //alert(href);
        var xxx=href.substring(href.indexOf('?')+1)
        //alert(href);
        var newHref="/NEO/pickObject/"+optionDom.value+"?"+xxx;
        //console.log(newHref);
        location.href=newHref;
    }
    function genData(count) {
        // prettier-ignore
        const nameList = [
            '赵', '钱', '孙', '李', '周', '吴', '郑', '王', '冯', '陈', '褚', '卫', '蒋', '沈', '韩', '杨', '朱', '秦', '尤', '许', '何', '吕', '施', '张', '孔', '曹', '严', '华', '金', '魏', '陶', '姜', '戚', '谢', '邹', '喻', '柏', '水', '窦', '章', '云', '苏', '潘', '葛', '奚', '范', '彭', '郎', '鲁', '韦', '昌', '马', '苗', '凤', '花', '方', '俞', '任', '袁', '柳', '酆', '鲍', '史', '唐', '费', '廉', '岑', '薛', '雷', '贺', '倪', '汤', '滕', '殷', '罗', '毕', '郝', '邬', '安', '常', '乐', '于', '时', '傅', '皮', '卞', '齐', '康', '伍', '余', '元', '卜', '顾', '孟', '平', '黄', '和', '穆', '萧', '尹', '姚', '邵', '湛', '汪', '祁', '毛', '禹', '狄', '米', '贝', '明', '臧', '计', '伏', '成', '戴', '谈', '宋', '茅', '庞', '熊', '纪', '舒', '屈', '项', '祝', '董', '梁', '杜', '阮', '蓝', '闵', '席', '季', '麻', '强', '贾', '路', '娄', '危'
        ];
        const legendData = [];
        const seriesData = [];
        for (var i = 0; i < count; i++) {
            var name =
                Math.random() > 0.65
                    ? makeWord(4, 1) + '·' + makeWord(3, 0)
                    : makeWord(2, 1);
            legendData.push(name);
            seriesData.push({
                name: name,
                value: Math.round(Math.random() * 100000)
            });
        }
        return {
            legendData: legendData,
            seriesData: seriesData
        };
        function makeWord(max, min) {
            const nameLen = Math.ceil(Math.random() * max + min);
            const name = [];
            for (var i = 0; i < nameLen; i++) {
                name.push(nameList[Math.round(Math.random() * nameList.length - 1)]);
            }
            return name.join('');
        }
    }

</script>
</html>
