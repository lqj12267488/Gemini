<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
</head>
<body class="mui-content">
<header class="mui-bar mui-bar-nav">
    <span id="back" class="mui-icon mui-icon-left-nav mui-pull-left" onclick="backMain()" style="color:#fff;"></span>
    <h1 id="title" class="mui-title">${typeName} </h1>
    <div class="mui-pull-right" style="padding-top: 4%">
        <a href="<%=request.getContextPath()%>/app/workflow/requestAppInfo?tableName=${tableName}&workflowId=${workflowId}" style="color:#fff; font-size: 18px">新增</a>
    </div>
</header>
<div class=""></div>
<div id="pullrefresh" class="mui-scroll-wrapper">
    <div class="mui-scroll">
        <!--数据列表-->
       <%-- <h3><a href="#">礼堂使用申请</a> </h3>--%>
        <ul  id="list" class="mui-table-view mui-table-view-striped mui-table-view-condensed">
        </ul>
    </div>
</div>
</body>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/mui.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
<script type="text/javascript">
    var etype = '${type}';
    //启用双击监听
    mui.init({
        back: function(){
            //获得列表界面的webview
            var list = plus.webview.getWebviewById('list');
            //触发列表界面的自定义事件（refresh）,从而进行数据刷新
            mui.fire(list,'refresh');
            //返回true，继续页面关闭逻辑
            return true;
        },
        swipeBack:true ,//启用右滑关闭功能
        gestureConfig:{
            doubletap:true
        },
        pullRefresh: {
            container: '#pullrefresh',
            down: {
                callback: pulldownRefresh
            },
            up: {
                contentrefresh: '正在加载...',
                callback: pullupRefresh
            }
        }
    });

    var contentWebview = null;
    document.querySelector('header').addEventListener('click',function () {
        if(contentWebview==null){
            contentWebview = plus.webview.currentWebview().children()[0];
        }
        contentWebview.evalJS("mui('#pullrefresh').pullRefresh().scrollTo(0,0,100)");
    });
    /**
     * 下拉刷新具体业务实现
     */
    var page = 1;
    function pulldownRefresh() {
        var table = document.body.querySelector('.mui-table-view');
        var cells = document.body.querySelectorAll('.mui-table-view-cell');
        setTimeout(function() {
            //1.清表;
            for (var i =0 ;cells.length>i;  i++)
            {
                table.removeChild(cells[i]);
            }
            page = 1;
            //2.刷新，动态拼接内容start(始终查询page=1 的数据);
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/workflowApp/result/getWorkFlowNameAppList",
                data:{"page":page,"type":etype},
                async: false,
                dataType: 'json',
                success: function(jsonData){
                    createEmlist(jsonData);
                    page = 2;
                }
            });
            function createEmlist(jsonStr){
                var emlistData = jsonStr;
                $.each(emlistData, function(key, map){
                    var  workFlowNameData = decodeURI(decodeURI(map.workflowName));
                    var li = document.createElement('li');
                    li.className = 'mui-table-view-cell';
                    li.innerHTML = '<div class="mui-table" >'+
                        '<div class="mui-table-cell mui-col-xs-10">'+
                        '<h3 class="mui-ellipsis">' +
                        '<a open-type="common"  href="<%=request.getContextPath()%>/app/workflow/requestAppInfo?workflowId='+map.workflowId+'&url='+map.url+
                        '&tableName='+map.tableName+'&businessId='+map.businessId+'">'
                        +workFlowNameData+'</a>' +
                        '</h3>' +
                        '</div></div>';
                    table.appendChild(li);
                });
            }
            //动态拼接内容end
            mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
        }, 1500);
    }
    var count = 0;
    /**
     * 上拉加载具体业务实现
     */
    function pullupRefresh() {
        setTimeout(function() {
            mui('#pullrefresh').pullRefresh().endPullupToRefresh((++count > 20)); //参数为true代表没有更多数据了。
            var table = document.body.querySelector('.mui-table-view');
            var cells = document.body.querySelectorAll('.mui-table-view-cell');
            //1.第一次正常加载
            if(page == 1){
                createEmlist('${emJson}');
                //2.以后加载，后台根据page过滤数据返回前台
            }else{
                $.ajax({
                    type: "POST",
                    url: "<%=request.getContextPath()%>/workflowApp/result/getWorkFlowNameAppList",
                    data:{"page":page,"type":etype},
                    async: false,
                    dataType: 'json',
                    success: function(jsonData){
                        createEmlist(jsonData);
                    }
                });
            }
            page++;
            //3.动态拼接内容start
            function createEmlist(jsonStr){
                if(page == 1){
                    var emlistData = eval('('+jsonStr+')');
                }else{
                    var emlistData = jsonStr;
                }
                $.each(emlistData, function(key, map){
                    var  workFlowNameData = decodeURI(decodeURI(map.workflowName));
                    workFlowNameData = decodeURI(decodeURI(workFlowNameData));
                    var li = document.createElement('li');
                    li.className = 'mui-table-view-cell';
                    li.innerHTML = '<div class="mui-table" >'+
                        '<div class="mui-table-cell mui-col-xs-10">'+
                        '<h3 class="mui-ellipsis">' +
                                '<a open-type="common"  href="<%=request.getContextPath()%>/app/workflow/requestAppInfo?workflowId='+map.workflowId+'&url='+map.url+
                                '&tableName='+map.tableName+'&businessId='+map.businessId+'">'
                                +workFlowNameData+'</a>' +
                        '</h3>' +
                        '</div></div>';
                    table.appendChild(li);
                });
            }
            //动态拼接内容end
        }, 1500);
    }
    if (mui.os.plus) {
        mui.plusReady(function() {
            setTimeout(function() {
                mui('#pullrefresh').pullRefresh().pullupLoading();
            }, 1000);

        });
    } else {
        mui.ready(function() {
            mui('#pullrefresh').pullRefresh().pullupLoading();
        });
    }
    (function($) {
        //阻尼系数
        var deceleration = mui.os.ios?0.003:0.0009;
        $('.mui-scroll-wrapper').scroll({
            bounce: false,
            indicators: true, //是否显示滚动条
            deceleration:deceleration
        });
        $.ready(function() {
            //循环初始化所有下拉刷新，上拉加载。
            $.each(document.querySelectorAll('.mui-slider-group .mui-scroll'), function(index, pullRefreshEl) {
                $(pullRefreshEl).pullToRefresh({
                    down: {
                        callback: function() {
                            var self = this;
                            setTimeout(function() {
                                var ul = self.element.querySelector('.mui-table-view');
                                ul.insertBefore(createFragment(ul, index, 10, true), ul.firstChild);
                                self.endPullDownToRefresh();
                            }, 1000);
                        }
                    },
                    up: {
                        callback: function() {
                            var self = this;
                            setTimeout(function() {
                                var ul = self.element.querySelector('.mui-table-view');
                                ul.appendChild(createFragment(ul, index, 5));
                                self.endPullUpToRefresh();
                            }, 1000);
                        }
                    }
                });
            });
            var createFragment = function(ul, index, count, reverse) {
                var length = ul.querySelectorAll('li').length;
                var fragment = document.createDocumentFragment();
                var li;
                for (var i = 0; i < count; i++) {

                    li = document.createElement('li');
                    li.className = 'mui-table-view-cell';
                    li.innerHTML = '第' + (index + 1) + '个选项卡子项-' + (length + (reverse ? (count - i) : (i + 1)));
                    fragment.appendChild(li);
                }
                return fragment;
            };
        });
    })(mui);
    var aniShow = "pop-in";
    mui('#list').on('tap', 'a', function() {
        var id = this.getAttribute('href');
        var href = this.href;
        var type = this.getAttribute("open-type");
        //不使用父子模板方案的页面
        if (type == "common") {
            var webview_style = {
                popGesture: "close"
            };
            //侧滑菜单需动态控制一下zindex值；
            if (~id.indexOf('offcanvas-')) {
                webview_style.zindex = 9998;
                webview_style.popGesture = ~id.indexOf('offcanvas-with-right') ? "close" : "none";
            }
            //图标界面需要启动硬件加速
            if(~id.indexOf('icons.html')){
                webview_style.hardwareAccelerated = true;
            }
            window.top.location.href =this.href;
        }
    });

    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>

</html>
