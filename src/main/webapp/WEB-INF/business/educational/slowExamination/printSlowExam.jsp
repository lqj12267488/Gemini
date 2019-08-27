<%--q申请新增和修改界面
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/18
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        table {
            width: 98%;
            margin-top: 10%;
            border: solid 1px #000;
            margin-left: 1%;
        }

        .left {
            text-align: right;
            background: #eeeeee !important;
        }
    </style>
</head>
<p>
    <br/>
</p>
<p style=";text-align:center;vertical-align:middle">
    <strong><span style="font-family: 宋体;font-size: 20px">白城职业技术学院（白城师范学院分院）</span></strong><strong></strong>
</p>
<p style=";text-align:center;vertical-align:middle">
    <strong><span style="font-family: 宋体;font-size: 24px"><span style="font-family:宋体">缓</span> <span
            style="font-family:宋体">考</span> <span style="font-family:宋体">申</span> <span style="font-family:宋体">请</span> <span
            style="font-family:宋体">单</span></span></strong>
</p>
<table border="1" cellpadding="0" cellspacing="0" style="width:95%;margin-left: 20px;border: none">
    <tbody>
    <tr style="height:49px">
        <td width="76" valign="center" style="width: 77px;padding: 1px;border-width: 1px;border-color: rgb(0, 0, 0)">
            <p style=";text-align:center;vertical-align:middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">系 &nbsp;&nbsp;别</span>
            </p>
        </td>
        <td width="132" valign="center"
            style="width: 132px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top-width: 1px;border-top-color: rgb(0, 0, 0);border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="text-align:center">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;${data.requestDept}</span>
            </p>
        </td>
        <td width="70" valign="center"
            style="width: 71px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top-width: 1px;border-top-color: rgb(0, 0, 0);border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style=";text-align:center;vertical-align:middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">班 &nbsp;&nbsp;级</span>
            </p>
        </td>
        <td width="88" valign="center"
            style="width: 89px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top-width: 1px;border-top-color: rgb(0, 0, 0);border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="text-align:center">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;${data.classId}</span>
            </p>
        </td>
        <td width="72" valign="center"
            style="width: 72px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top-width: 1px;border-top-color: rgb(0, 0, 0);border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style=";text-align:center;vertical-align:middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">姓 &nbsp;&nbsp;名</span>
            </p>
        </td>
        <td width="107" valign="center"
            style="width: 107px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top-width: 1px;border-top-color: rgb(0, 0, 0);border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="text-align:center">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;${data.manager}</span>
            </p>
        </td>
    </tr>
    <tr style="height:49px">
        <td width="76" valign="center"
            style="width: 77px;padding: 1px;border-left-width: 1px;border-left-color: rgb(0, 0, 0);border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style=";text-align:center;vertical-align:middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">缓考科目</span>
            </p>
        </td>
        <td width="132" valign="center"
            style="width: 132px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="text-align:center">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;${data.courseName}</span>
            </p>
        </td>
        <td width="159" valign="center" colspan="2"
            style="width: 159px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="text-align:center">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;</span>
            </p>
        </td>
        <td width="179" valign="center" colspan="2"
            style="width: 180px;padding: 1px;border-left: none;border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="text-align:center">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;</span>
            </p>
        </td>
    </tr>
    <tr style="height:73px">
        <td width="548" valign="center" colspan="6"
            style="width: 548px;padding: 1px;border-left-width: 1px;border-left-color: rgb(0, 0, 0);border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="vertical-align: middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;&nbsp;缓考原因：&nbsp;${data.reason}</span>
            </p>
            <p style="vertical-align: middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp; &nbsp; &nbsp;</span><span
                    style="font-family: 楷体_GB2312;font-size: 14px"><div style="text-align: right;">
                        年 &nbsp;&nbsp;月 &nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;
                    </div></span>
            </p>
        </td>
    </tr>
    <tr style="height:88px">
        <td width="548" valign="center" colspan="6"
            style="width: 548px;padding: 1px;border-left-width: 1px;border-left-color: rgb(0, 0, 0);border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="vertical-align: middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;&nbsp;辅导员意见：</span>
            </p>
            <p style="vertical-align: middle">
                    <span style="font-family: 楷体_GB2312;font-size: 14px"><br/>
                    <div style="text-align: right;">
                         年 &nbsp;&nbsp;月 &nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;
                    </div></span>
            </p>
        </td>
    </tr>
    <tr style="height:100px">
        <td width="548" valign="center" colspan="6"
            style="width: 548px;padding: 1px;border-left-width: 1px;border-left-color: rgb(0, 0, 0);border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="vertical-align: middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;&nbsp;系部意见：</span>
            </p>
            <p style="vertical-align: middle">
                    <span style="font-family: 楷体_GB2312;font-size: 14px"><br/>
                    <div style="text-align: right;">
                        年 &nbsp;&nbsp;月 &nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;
                    </div></span>
            </p>
        </td>
    </tr>
    <tr style="height:82px">
        <td width="548" valign="center" colspan="6"
            style="width: 548px;padding: 1px;border-left-width: 1px;border-left-color: rgb(0, 0, 0);border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="vertical-align: middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;&nbsp;学生工作部意见：</span>
            </p>
            <p style="vertical-align: middle">
                    <span style="font-family: 楷体_GB2312;font-size: 14px"><br/>
                    <div style="text-align: right;">
                        年 &nbsp;&nbsp;月 &nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;
                    </div></span>
            </p>
        </td>
    </tr>
    <tr style="height:104px">
        <td width="548" valign="center" colspan="6"
            style="width: 548px;padding: 1px;border-left-width: 1px;border-left-color: rgb(0, 0, 0);border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="vertical-align: middle">
                <c:forEach items="${handleList}" var="index">
                    ${index.remark}
                    ${index.handleTime}
                </c:forEach>
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;&nbsp;教务处意见：</span>
            </p>
            <p style="vertical-align: middle">
                    <span style="font-family: 楷体_GB2312;font-size: 14px"><br/>
                    <div style="text-align: right;">
                        年 &nbsp;&nbsp;月 &nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;
                    </div></span>
            </p>
        </td>
    </tr>
    <tr style="height:93px">
        <td width="548" valign="center" colspan="6"
            style="width: 548px;padding: 1px;border-left-width: 1px;border-left-color: rgb(0, 0, 0);border-right-width: 1px;border-right-color: rgb(0, 0, 0);border-top: none;border-bottom-width: 1px;border-bottom-color: rgb(0, 0, 0)">
            <p style="vertical-align: middle">
                <span style="font-family: 楷体_GB2312;font-size: 14px">&nbsp;&nbsp;主管院长意见：</span>
            </p>
            <p style="vertical-align: middle">
                    <span style="font-family: 楷体_GB2312;font-size: 14px"><br/>
                    <div style="text-align: right;">
                        年 &nbsp;&nbsp;月 &nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;
                    </div></span>
            </p>
        </td>
    </tr>
    </tbody>
</table>
<p>
    <span style=";font-family:Calibri;font-size:14px">&nbsp;</span>
</p>
<p>
    <br/>
</p>
