<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/15
  Time: 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    <!--App自定义的css-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/libs/css/app/app.css"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.picker.css" rel="stylesheet"/>
    <link href="<%=request.getContextPath()%>/libs/css/app/mui.poppicker.css" rel="stylesheet"/>

    <script src="<%=request.getContextPath()%>/libs/js/app/mui.min.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.picker.js"></script>
    <script src="<%=request.getContextPath()%>/libs/js/app/mui.poppicker.js"></script>
<body><%-- onload="onl();"--%>
<!-- 主页面容器 -->
<div class="mui-inner-wrap mui-content">
    <!-- 主页面标题 -->
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" style="color:#fff;"></a>
        <h1 class="mui-title">工资单详情</h1>
        <span id="appIndex" class="mui-icon mui-icon-home mui-pull-right" onclick="backMain()" style="color:#fff;"></span>
    </header>
    <!--style="padding-top: 0%"-->
    <div class="" style="padding-top: 12%">
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            姓名
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.name}
            <%--<input id="name" type="number" value="${salary.name}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            身份证号
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.idcard}
            <%--<input id="idcard" type="number" value="${salary.idcard}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            年份
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.year}
            <%-- <input id="year" type="number" value="${salary.year}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            月份
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.month}
            <%--<input id="month" type="number"  value="${salary.month}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            岗位工资
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.postSalary}
            <%--<input id="postSalary" type="number"  value="${salary.postSalary}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            薪级工资
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.wagePay}
            <%--<input id="wagePay" type="number" value="${salary.wagePay}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            百分之十
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.bfzs}
            <%-- <input id="bfzs" type="number"  value="${salary.bfzs}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            基础性绩效
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.basicPerformance}
            <%--<input id="basicPerformance" type="number" value="${salary.basicPerformance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            国家奖励性绩效
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.rewardPerformance}
            <%--<input id="rewardPerformance" type="number"  value="${salary.rewardPerformance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            独子补贴
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.childAllowance}
            <%--<input id="childAllowance" type="number" value="${salary.childAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            教护龄
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.seniorityAllowance}
            <%-- <input id="seniorityAllowance" type="number"  value="${salary.seniorityAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            房租补贴
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.rentSubsidies}
            <%--<input id="rentSubsidies" type="number" value="${salary.rentSubsidies}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            特殊岗位津贴
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.postAllowance}
            <%-- <input id="postAllowance" type="number"  value="${salary.postAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; =">
            补发津贴
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.reissueAllowance}
            <%--<input id="reissueAllowance" type="number" value="${salary.reissueAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            劳动合同岗位工资
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lcPv}
            <%--<input id="lcPv" type="number"  value="${salary.lcPv}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            劳动合同学历工资
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lcAcademicSalary}
            <%--<input id="lcAcademicSalary" type="number" value="${salary.lcAcademicSalary}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;">
            劳动合同职称津贴
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lcTitleAllowance}
            <%-- <input id="lcTitleAllowance" type="number"  value="${salary.lcTitleAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            劳动合同校龄工资
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lcAgeSalary}
            <%--<input id="lcAgeSalary" type="number" value="${salary.lcAgeSalary}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            劳动合同调整津贴
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.lcAdjustmentAllowance}
            <%-- <input id="lcAdjustmentAllowance" type="number"  value="${salary.lcAdjustmentAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            劳动合同绩效工资
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lcMeritPay}
            <%-- <input id="lcMeritPay" type="number" value="${salary.lcMeritPay}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            劳动合同独子补贴
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lcChildAllowance}
            <%--<input id="lcChildAllowance" type="number"  value="${salary.lcChildAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            采暖费
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.heatingFee}
            <%--<input id="heatingFee" type="number"  value="${salary.heatingFee}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; "
             style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            讲课费1
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lectureFee}
            <%-- <input id="lectureFee" type="number" value="${salary.lectureFee}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            讲课费2
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.lectureFeeSecond}
            <%--<input id="lectureFeeSecond" type="number"  value="${salary.lectureFeeSecond}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle;"
             style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            中专班主任费
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.polytechnicHeadmasterFee}
            <%-- <input id="polytechnicHeadmasterFee" type="number"  value="${salary.polytechnicHeadmasterFee}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            大专班主任费
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.juniorHeadmasterFee}
            <%--  <input id="juniorHeadmasterFee" type="number" value="${salary.juniorHeadmasterFee}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            绩效考核返还
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.performanceAppraisalReturn}
            <%--<input id="performanceAppraisalReturn" type="number"  value="${salary.performanceAppraisalReturn}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            责任绩效
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.accountabilityPerformance}
            <%--<input id="accountabilityPerformance" type="number" value="${salary.accountabilityPerformance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            管理、教辅效益绩效
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.managementPerformance}
            <%--<input id="managementPerformance" type="number"  value="${salary.managementPerformance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            内聘津贴
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.internalAllowance}
            <%--<input id="internalAllowance" type="number" value="${salary.internalAllowance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            职大百分之十
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.zdbfzs}
            <%-- <input id="zdbfzs" type="number"  value="${salary.zdbfzs}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            职大商校职称差额
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.titleDifference}
            <%--<input id="titleDifference" type="number" value="${salary.titleDifference}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            补发工资1
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.replacementWage}
            <%--<input id="replacementWage" type="number"  value="${salary.replacementWage}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            补发工资2
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.replacementWageSecond}
            <%--<input id="replacementWageSecond" type="number" value="${salary.replacementWageSecond}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            招生项目绩效
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.recruitStudentsAchievements}
            <%--<input id="recruitStudentsAchievements" type="number"  value="${salary.recruitStudentsAchievements}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            大赛项目绩效
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.contestAchievements}
            <%-- <input id="contestAchievements" type="number" value="${salary.contestAchievements}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            科研项目绩效
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.scientificAchievements}
            <%--<input id="scientificAchievements" type="number"  value="${salary.scientificAchievements}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            其他
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.others}
            <%--<input id="others" type="number" value="${salary.others}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            绩效考核奖
        </div>
        <div class="col-md-9"
             style="height:40px;vertical-align:middle;text-align:center;">${salary.performanceAppraisalAward}
            <%--<input id="performanceAppraisalReturn" type="number"  value="${salary.performanceAppraisalReturn}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            应发合计
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.totalPayable}
            <%--<input id="totalPayable" type="number" value="${salary.totalPayable}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            个人所得税
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.individualIncomeTax}
            <%-- <input id="individualIncomeTax" type="number"  value="${salary.individualIncomeTax}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            养老保险
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.endowmentInsurance}
            <%-- <input id="endowmentInsurance" type="number" value="${salary.endowmentInsurance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            医疗保险
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.medicalInsurance}
            <%--<input id="medicalInsurance" type="number"  value="${salary.medicalInsurance}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            住房基金
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.housingFund}
            <%--  <input id="housingFund" type="number" value="${salary.housingFund}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            职业年金
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.occupationalPension}
            <%-- <input id="occupationalPension" type="number"  value="${salary.occupationalPension}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            补扣养老保险
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.supplementaryEi}
            <%-- <input id="supplementaryEi" type="number" value="${salary.supplementaryEi}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            补扣医疗保险
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.supplementaryMi}
            <%--<input id="supplementaryMi" type="number"  value="${salary.supplementaryMi}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            补扣房基金
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.supplementaryHf}
            <%--<input id="supplementaryHf" type="number" value="${salary.supplementaryHf}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            补扣职业年金
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.supplementaryOp}
            <%-- <input id="supplementaryOp" type="number"  value="${salary.supplementaryOp}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            补扣税
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.supplementaryTax}
            <%--<input id="supplementaryTax" type="number" value="${salary.supplementaryTax}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            扣款
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.debit}
            <%-- <input id="debit" type="number"  value="${salary.debit}"/>--%>
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            会费
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.membershipDues}
            <%-- <input id="membershipDues" type="number" value="${salary.membershipDues}"/>--%>
        </div>

        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            实发合计
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.realSalary}
            <%--<input id="realSalary" type="number"  value="${salary.realSalary}"/>--%>
        </div>

        <%--<div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            基本工资
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.basicwage}
            &lt;%&ndash; <input id="basicwage" type="number" value="${salary.basicwage}"/>&ndash;%&gt;
        </div>
        <div class="col-md-3 tar" style="background:#d0d0d0;height:25px;vertical-align:middle; ">
            五险一金
        </div>
        <div class="col-md-9" style="height:40px;vertical-align:middle;text-align:center;">${salary.insuranceFund}
            &lt;%&ndash;<input id="insuranceFund" type="number"  value="${salary.insuranceFund}"/>&ndash;%&gt;
        </div>--%>

    </div>
</div>
<script>
    function backMain() {
        window.location.href = "<%=request.getContextPath()%>/loginApp/index";
    }
</script>
