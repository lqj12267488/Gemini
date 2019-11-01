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
        .box {
            width: 98%;
            border: solid 1px #000;
            margin-left: 1%;
        }

        td {
            height: 40px;
        }

        .left {
            text-align: right;
            background: #eeeeee !important;
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

        .clearBoth {
            clear: both;
            margin-bottom: 10px
        }
    </style>
</head>
<div style="margin-left: 30%;margin-top: 5%;">
    <h2>${projectName}${workflowName}</h2>
</div>
<div style="font-size: 10.5pt;margin-top:10%;padding-right: 2%;" align="right">
    编号：${number}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;填表日期：${studentReissue.requestDate}
</div>
<table border="1" cellpadding="0" cellspacing="0" class="box">
    <tr>
        <td class="left" align="center" style="text-align:center;  width: 96px;">姓名：</td>
        <td align="center" class="left1" style="text-align:center; width: 96px;">${studentReissue.studentId}</td>
        <td class="left" align="center" style="text-align:center;  width: 96px;">民族：</td>
        <td align="center" class="left1" style="text-align:center; width: 96px;">${studentReissue.nation}</td>
        <td class="left" align="center" style="text-align:center;  width: 96px;">身份证号：</td>
        <td align="center" class="left1" style="text-align:center; width: 96px;">${studentReissue.idcard}</td>
        <td rowspan="4" style="width:15%;">
            <img
                    style="width: 130px;height: 162px;margin-left:9px;"
                    src="data:image/png;base64,${studentReissue.img}"
                    height="150"
                    width="110" alt="" id="userImg">
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;  width: 96px;">班级：</td>
        <td align="center" class="left1" style="text-align:center; width: 96px;">${studentReissue.classId}</td>
        <td class="left" align="center" style="text-align:center;  width: 96px;">性别：</td>
        <td align="center" class="left1" style="text-align:center; width: 96px;">${studentReissue.sex}</td>
        <td class="left" align="center" style="text-align:center;  width: 96px;">学号：</td>
        <td align="center" class="left1" style="text-align:center; width: 96px;">${studentReissue.studentNumber}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;  width: 140px;">专业：</td>
        <td align="center" class="left1" style="text-align:center; width: 420px;"
            colspan="5">${studentReissue.majorCode}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;  width: 140px;">乘车区间：</td>
        <td align="center" class="left1" style="text-align:center; width: 420px;"
            colspan="5">
            <span style="float: left">乌市站到</span>
            <span style="border-bottom: dotted 1px #000;width: 120px;float: left">${requestDateMonth}</span>
            <span style="float: left">站</span>
        </td>
    </tr>


    <tr>
        <td class="left" align="center" style="text-align:center;  width: 140px;">家庭地址：</td>
        <td align="center" class="left1" style="text-align:center; width: 140px;"
            colspan="3">${studentReissue.familyAddress}</td>
        <td class="left" align="center" style="text-align:center;  width: 140px;">电话：</td>
        <td align="center" class="left1" style="text-align:center; width: 140px;"
            colspan="2">${studentReissue.phone}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;width: 140px;">籍贯：</td>
        <td align="center" class="left1" style="text-align:center;" colspan="6">
            <span style="float: left">新疆省</span>
            <span style="border-bottom: dotted 1px #000;width: 120px;float: left">${studentReissue.regional}</span>
            <span style="float: left">地区（州）</span>
            <span style="border-bottom: dotted 1px #000;width: 120px;float: left">${studentReissue.city}</span>
            <span style="float: left">市（县）</span>
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;width:140px;">申请项目：</td>
        <td align="center" class="left1" style="text-align:center;" colspan="6">${studentReissue.requestProject}</td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;width:130px;height:90px">申请理由：</td>
        <td align="center" class="left1" style="text-align:center; height:90px;" colspan="6">
            ${studentReissue.requestReason}
            <br>
            我承诺以上理由均属实；若有不实，本人甘愿接受任何处罚。
            <br>
            学生签字：${studentReissue.studentId}
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：${studentReissue.requestDate}
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;width: 140px;height:80px;">
            辅导员<br>
            意 见：
        </td>
        <td align="center" class="left1" style="text-align:center;height:80px;" colspan="6">
            ${departmentName}
            <br>
            辅导员签名：${departmentNames}
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：${departmentNameRequestDate}
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;width: 140px;height:80px;">
            年级组长<br>
            意 见：
        </td>
        <td align="center" class="left1" style="text-align:center;height:80px;" colspan="6">
            ${agent}
            <br>
            年级组长签名：${agentNames} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：${agentRequestDate}
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;width:140px;height:80px;">
            学生处<br>
            意 见：
        </td>
        <td align="center" class="left1" style="text-align:center;height:80px;" colspan="6">
            ${departmentNameStudent}
            <br>
            学生处签名：${departmentStudentNames}
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日期：${departmentNameStudentRequestDate}
        </td>
    </tr>
    <tr>
        <td class="left" align="center" style="text-align:center;width: 140px;">办理情况</td>
        <td align="center" class="left1" style="text-align:center;" colspan="6">
            <div>
                <span class="right" style="width:120px; float: left">${studentReissue.studentId}</span>
                <span style="float: left">同学的学生证已于 </span>
                <span class="right" style="width:40px; float: left">${requestDateYear}</span>
                <span style="float: left">年</span>
                <span class="right" style="width:20px; float: left">${requestDateMonth}</span>
                <span style="float: left">月</span>
                <span class="right" style="width:20px; float: left">${requestDateDay}</span>
                <span style="float: left">日办理完毕，于 </span>
                <span class="right" style="width:10px; float: left"></span>
                <span style="float: left">年</span>
                <span class="right" style="width:10px; float: left"></span>

            </div>
            <div>
                <span style="float: left">月</span>
                <span class="right" style="width:10px; float: left"></span>
                <span style="float: left">日发放。特备此表备查。</span>
            </div>

            <div style="float: left;clear: both;">20 &nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月 &nbsp;&nbsp;&nbsp;日在
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;报纸上声明丢失；</div>
            <br>
            <div class="clearBoth footTxt" style="width: 220px; margin-top: 10px">
                <span align="right">学生签名：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><br>
                &nbsp;&nbsp;&nbsp;<span align="right">20 &nbsp;&nbsp;&nbsp;年 &nbsp;&nbsp;&nbsp;月 &nbsp;&nbsp;&nbsp;日</span>
            </div>
        </td>
    </tr>
</table>
<div style="padding-left: 2%;">
    备 注：1、如出现弄虚作假行为，视情节轻重给予处理；<br>
    2、除规定时间外，其余时间不予补办学生证；<br>
    3、申请站点更改须凭家庭所在地派所证明或父母工作单位证明方可办理变更手续。
</div>
<div class="clearBoth footTxt" style="width: 220px;">
    <span align="right">新疆现代职业技术院</span>
</div>
<div class="clearBoth footTxt" style="width: 220px;">
    <span align="right">学 生 处</span>
</div>
