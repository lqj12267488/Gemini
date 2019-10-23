<%@ page import="com.goisan.system.bean.CommonBean" %><%--q申请新增和修改界面
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

        td {
            height: 40px;
        }

        .clearBoth {
            clear: both;
            margin-bottom: 10px
        }

        .footTxt {
            float: right;
            padding-right: 3%;
            text-align: center;
        }

        .right {
            background: #fff !important;
            font-size: 14pt;
            width: 280px;
            text-align: center;
            float: left;
            padding-left: 2%;
            display: inline-block;
            text-align: center;
            width: 140px;
            height: 25px;
            border-bottom: solid 2px #333
        }

        .left {
            text-align: right;
            background: #eeeeee !important;
        }

    </style>
</head>
<table border="1" cellpadding="0" cellspacing="0">
    <div>
        <h2 style="margin-left: 20%;">
            <%--<img src="<%=request.getContextPath()%>/libs/img/logodl.png" style="width: 50px; height: 50px;">&nbsp;&nbsp;--%><%=CommonBean.getParamValue("SZXXMC")%>人员招聘需求申请表
        </h2>
    </div>
        <h6 style="margin-left: 2%;">
        申请日期：${requestDate}
        </h6>
    <tr>
        <td class="left" style="padding-left: 2%;text-align:center; width: 95px;">申请部门：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 95px;">${talentRecruitment.requestDept}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 95px;">申请人：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 95px;">${talentRecruitment.requester}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 95px;">职务：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 95px;">${talentRecruitment.post}</td>
    </tr>
    <tr>
        <td class="left" style="padding-left: 2%;text-align:center; width: 95px;">招聘岗位：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 95px;">${talentRecruitment.recruitmentPosts}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 95px;">申请到岗<br>日期：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 95px;">${talentRecruitment.stationDate}</td>
        <td class="left" align="center" style="padding-left: 2%;text-align:center; width: 95px;">招聘人数：</td>
        <td align="center" class="left1"
            style="padding-left: 2%;text-align:center; width: 95px;">${talentRecruitment.recruitment}</td>
    </tr>
    <tr>
        <td class="left" style="padding-left: 2%;text-align:center; width: 95px;">招聘原由：</td>
        <c:if test="${talentRecruitment.recruitmentReason == '' || null == talentRecruitment.recruitmentReason}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left; " colspan="5">▢空编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢扩大编制
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢短期需求 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢储备人才
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </c:if>
        <c:if test="${talentRecruitment.recruitmentReason == 1}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left; " colspan="5">☑空编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢扩大编制
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢短期需求 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢储备人才
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </c:if>
        <c:if test="${talentRecruitment.recruitmentReason == 2}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left; " colspan="5">▢空编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑扩大编制
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢短期需求 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢储备人才
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </c:if>
        <c:if test="${talentRecruitment.recruitmentReason == 3}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left; " colspan="5">▢空编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢扩大编制
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑短期需求 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢储备人才
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </c:if>
        <c:if test="${talentRecruitment.recruitmentReason == 4}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left; " colspan="5">▢空编 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢扩大编制
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢短期需求 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑储备人才
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </c:if>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;" rowspan="8">应具资格条件：
        </td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
            <div>
                <c:if test="${talentRecruitment.boyNumber == null}">
                    <span style="float: left">性别：▢男</span>
                </c:if>
                <c:if test="${talentRecruitment.boyNumber != '' and null != talentRecruitment.boyNumber}">
                    <span style="float: left">性别：☑男</span>
                </c:if>
                <span class="right" style="width:60px; float: left">${talentRecruitment.boyNumber}</span>
                <span style="float: left">名&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <c:if test="${talentRecruitment.girlNumber == null}">
                    <span style="float: left">▢女</span>
                </c:if>
                <c:if test="${talentRecruitment.girlNumber != '' and null != talentRecruitment.girlNumber}">
                    <span style="float: left">☑女</span>
                </c:if>
                <span class="right" style="width:60px; float: left">${talentRecruitment.girlNumber}</span>
                <span style="float: left">名&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <c:if test="${talentRecruitment.sex == 3}">
                    <span style="float: left">☑不限</span>
                </c:if>
                <c:if test="${talentRecruitment.sex == 4}">
                    <span style="float: left">▢不限</span>
                </c:if>
            </div>
        </td>
    </tr>
    <tr>
        <c:if test="${talentRecruitment.maritalStatus == '' || null == talentRecruitment.maritalStatus}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">婚姻状况：▢已婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢未婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢不限</td>
        </c:if>
        <c:if test="${talentRecruitment.maritalStatus == 1}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">婚姻状况：☑已婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢未婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢不限</td>
        </c:if>
        <c:if test="${talentRecruitment.maritalStatus == 2}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">婚姻状况：▢已婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑未婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢不限</td>
        </c:if>
        <c:if test="${talentRecruitment.maritalStatus == 3}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">婚姻状况：▢已婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢未婚&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑不限</td>
        </c:if>
    </tr>
    <tr>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="3">
            <span style="float: left">年龄：</span>
            <span class="right" style="width:60px; float: left">${talentRecruitment.ageStart}</span>
            <span style="float: left">岁至</span>
            <span class="right" style="width:60px; float: left">${talentRecruitment.ageEnd}</span>
            <span style="float: left">岁</span>
        </td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="2">
            <span style="float: left">政治面貌：</span>
            <span class="right" style="width:120px; float: left">${talentRecruitment.politicalOutlookShow}</span>
        </td>
    </tr>
    <tr>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
            <span style="float: left">语言要求：</span>
            <span class="right" style="width:240px; float: left">${talentRecruitment.languageRequirements}</span>
        </td>
    </tr>
    <tr>
        <c:if test="${talentRecruitment.education == '' || null == talentRecruitment.education}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">学历：▢研究生及以上 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢本科
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢大专 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢中专（含中专以下）
            </td>
        </c:if>
        <c:if test="${talentRecruitment.education == 1}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">学历：☑研究生及以上 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢本科&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢大专
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢中专（含中专以下）
            </td>
        </c:if>
        <c:if test="${talentRecruitment.education == 2}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">学历：▢研究生及以上 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑本科&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢大专
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢中专（含中专以下）
            </td>
        </c:if>
        <c:if test="${talentRecruitment.education == 3}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">学历：▢研究生及以上 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢本科&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑大专
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢中专（含中专以下）
            </td>
        </c:if>
        <c:if test="${talentRecruitment.education == 4}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">学历：▢研究生及以上 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢本科&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▢大专
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;☑中专（含中专以下）
            </td>
        </c:if>
    </tr>
    <tr>
        <c:if test="${talentRecruitment.professionalRestrictions == '' || null == talentRecruitment.professionalRestrictions}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                <span style="float: left">专业限制： ▢相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢非相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢临近</span>
                <span class="right" style="width:120px; float: left">${talentRecruitment.near}</span>
            </td>
        </c:if>
        <c:if test="${talentRecruitment.professionalRestrictions == 1}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                <span style="float: left">专业限制： ☑相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢非相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢临近</span>
                <span class="right" style="width:120px; float: left">${talentRecruitment.near}</span>
            </td>
        </c:if>
        <c:if test="${talentRecruitment.professionalRestrictions == 2}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                <span style="float: left">专业限制： ▢相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ☑非相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢临近</span>
                <span class="right" style="width:120px; float: left">${talentRecruitment.near}</span>
            </td>
        </c:if>
        <c:if test="${talentRecruitment.professionalRestrictions == 3}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                <span style="float: left">专业限制： ▢相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢非相关 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ☑临近</span>
                <span class="right" style="width:120px; float: left">${talentRecruitment.near}</span>
            </td>
        </c:if>
    </tr>
    <tr>
        <c:if test="${talentRecruitment.workingLife == '' || null == talentRecruitment.workingLife}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                工作年限：▢1-3年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢3-5年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢5年以上
            </td>
        </c:if>
        <c:if test="${talentRecruitment.workingLife == 1}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                工作年限：☑1-3年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢3-5年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢5年以上
            </td>
        </c:if>
        <c:if test="${talentRecruitment.workingLife == 2}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                工作年限：▢1-3年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ☑3-5年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢5年以上
            </td>
        </c:if>
        <c:if test="${talentRecruitment.workingLife == 3}">
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                工作年限：▢1-3年 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ▢3-5年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ☑5年以上
            </td>
        </c:if>
    </tr>
    <tr>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
            <span style="float: left">相关资格证书（申请部门手写）：</span>
            <span class="right" style="width:160px; float: left">${talentRecruitment.relevantCertificate}</span>
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;">岗位职责：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center;"
            colspan="5">${talentRecruitment.jobResponsibilities}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;">其他要求：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:center;"
            colspan="5">${talentRecruitment.otherRequirements}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;">部门负责人<br>意见：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;"
            colspan="5">
            ${deptPersonRemark}<br><br>
            <div class="clearBoth footTxt" style="width: 270px;">
                <span align="right">签名：${deptPerson}</span>
                <span align="right">日期：${deptPersonTime}</span>
            </div>
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;">分管院领导<br>意见：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
            ${leaderRemark}<br><br>
            <div class="clearBoth footTxt" style="width: 270px;">
                <span align="right">签名：${leader}</span>
                <span align="right">日期：${leaderTime}</span>
            </div>
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;">院长审批<br>意见：</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
            ${deanRemark}<br><br>
            <div class="clearBoth footTxt" style="width: 270px;">
                <span align="right">签名：${dean}</span>
                <span align="right">日期：${deanTime}</span>
            </div>
        </td>
    </tr>
    <tr>
            <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;">董事长审批<br>意见：
            </td>
            <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5">
                ${chairmanRemark}<br>
                <div class="clearBoth footTxt" style="width: 270px;">
                    <span align="right">签名：${chairman}</span>
                    <span align="right">日期：${chairmanTime}</span>
                </div>
            </td>
    </tr>
    <tr>
        <td class="left" align="center" style="padding-left: 2%;text-align:center;  width: 95px;">备注</td>
        <td align="center" class="left1" style="padding-left: 2%;text-align:left;" colspan="5"></td>
    </tr>
</table>


