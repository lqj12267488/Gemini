<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/app/mui.js"></script>
	<script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/libs/css/app/mui.min.css">
	<link href="<%=request.getContextPath()%>/libs/css/app/mui.min.css" rel="stylesheet" />
	<link href="<%=request.getContextPath()%>/libs/css/app/mui.indexedlist.css" rel="stylesheet" />
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
		#done.mui-disabled{
			color: gray;
		}
	</style>
</head>

<body>
<div class="mui-content">
	<header class="mui-bar mui-bar-nav">
		<span id="back" class="mui.back mui-icon mui-icon-left-nav mui-pull-left" onclick="mui.back()" style="color:#fff;"></span>
		<h1 class="mui-title">通讯录</h1>
		<span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
		<!-- 			<a id='done' class="mui-btn mui-btn-link mui-pull-right mui-btn-blue mui-disabled">完成</a> -->
	</header>
	<div >
		<div class="mui-scroll-wrapper">
			<div class="mui-scroll">
				<ul class="mui-table-view">
					<li class="mui-table-view-cell">
						<a id="head" class="mui-navigate-right">头像
							<span class="mui-pull-right head">
									<img class="head-img mui-action-preview" id="head-img1" src=""/>
								</span>
						</a>
					</li>
					<li class="mui-table-view-cell">
						<a>姓名<span class="mui-pull-right">${xm}</span></a>
					</li>
					<li class="mui-table-view-cell">
						<a>部门<span class="mui-pull-right">${bm}</span></a>
					</li>
				</ul>
				<ul class="mui-table-view">
					<li class="mui-table-view-cell">
						<a>电话<span class="mui-pull-right">${tel}</span></a>
					</li>

				</ul>
			</div>
		</div>
	</div>
</div>
<!--<script src="./js/mui.grouplist.testdata.js"></script>-->
<script type="text/javascript" charset="utf-8">
    mui.init();
    mui.ready(function() {
        swipeBack:true//启用右滑关闭功能

    });
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
</body>

</html>