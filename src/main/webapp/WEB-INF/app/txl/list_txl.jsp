<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <%--<meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <script type="text/javascript" src="../../../libs/js/app/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="../../../libs/js/app/mui.js"></script>--%>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.min.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.indexedlist.css" rel="stylesheet"/>
    <style>
        html,
        body {
            height: 100%;
            overflow: hidden;
        }

        .mui-bar {
            -webkit-box-shadow: none;
            box-shadow: none;
        }

        #done.mui-disabled {
            color: gray;
        }
    </style>
</head>

<body>
<header class="mui-bar mui-bar-nav">
    <span id="back" class="mui.back mui-icon mui-icon-left-nav mui-pull-left" onclick="mui.back()"
          style="color:#fff;"></span>
    <h1 class="mui-title">通讯录</h1>
    <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    <!-- 			<a id='done' class="mui-btn mui-btn-link mui-pull-right mui-btn-blue mui-disabled">完成</a> -->
</header>
<div class="mui-content">
    <div id='list' class="mui-indexed-list">
        <div class="mui-indexed-list-search mui-input-row mui-search">
            <input type="search" class="mui-input-clear  mui-indexed-list-search-input" placeholder="搜索姓名" id="search">
        </div>
        <div hidden class="mui-indexed-list-bar">
            <a>A</a>
            <a>B</a>
            <a>C</a>
            <a>D</a>
            <a>E</a>
            <a>F</a>
            <a>G</a>
            <a>H</a>
            <a>I</a>
            <a>J</a>
            <a>K</a>
            <a>L</a>
            <a>M</a>
            <a>N</a>
            <a>O</a>
            <a>P</a>
            <a>Q</a>
            <a>R</a>
            <a>S</a>
            <a>T</a>
            <a>U</a>
            <a>V</a>
            <a>W</a>
            <a>X</a>
            <a>Y</a>
            <a>Z</a>
        </div>
        <div class="mui-indexed-list-alert"></div>
        <div class="mui-indexed-list-inner">
            <div class="mui-indexed-list-empty-alert">没有数据</div>
            <ul class="mui-table-view">
                <c:forEach items="${requestScope.list}" var="dep">
                    <li data-value="AKU" class="mui-table-view-cell">
                        <a class="mui-navigate-right" onclick="txldetail('${dep.id}','${dep.dept}')">${dep.name}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<script src="<%=request.getContextPath()%>/libs/js/app/jquery.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
<script src="<%=request.getContextPath()%>/libs/js/app/mui.indexedlist.js"></script>
<%--<script src="../../../libs/js/app/mui.grouplist.testdata.js"></script>--%>
<script type="text/javascript" charset="utf-8">
    mui.init();
    mui.ready(function () {
        var header = document.querySelector('header.mui-bar');
        var list = document.getElementById('list');
        var done = document.getElementById('done');
        //calc hieght
        list.style.height = (document.body.offsetHeight - header.offsetHeight) + 'px';
        //create
        window.indexedList = new mui.IndexedList(list);
        //done event
        done.addEventListener('tap', function () {
            var checkboxArray = [].slice.call(list.querySelectorAll('input[type="checkbox"]'));
            var checkedValues = [];
            checkboxArray.forEach(function (box) {
                if (box.checked) {
                    checkedValues.push(box.parentNode.innerText);
                }
            });
            if (checkedValues.length > 0) {
                mui.alert('你选择了: ' + checkedValues);
            } else {
                mui.alert('你没选择任何姓名');
            }
        }, false);
        mui('.mui-indexed-list-inner').on('change', 'input', function () {
            var count = list.querySelectorAll('input[type="checkbox"]:checked').length;
            var value = count ? "完成(" + count + ")" : "完成";
            done.innerHTML = value;
            if (count) {
                if (done.classList.contains("mui-disabled")) {
                    done.classList.remove("mui-disabled");
                }
            } else {
                if (!done.classList.contains("mui-disabled")) {
                    done.classList.add("mui-disabled");
                }
            }
        });
    });

    function txldetail(id,dept) {
        window.top.location.href = "<%=request.getContextPath()%>/txl/result/listDedail?id=" + id+"&dept="+dept;
    }

    function search() {
        var value = $("#search").val();
        window.top.location.href = "<%=request.getContextPath()%>/txl/result/search?name=" + value;
    }
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
</body>

</html>