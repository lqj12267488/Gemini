<%--
  Created by IntelliJ IDEA.
  User: NeilVan
  Date: 2018/11/13
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    table{
        width:50%;
        height:50%;
        text-align:center;
        border-color:#ffffff;
        border-collapse:collapse;
        border-width: 2px;
        padding: 2px;
        margin:auto;
    }
</style>
<div style="width: 50%;margin:auto" >
<p style=";text-align:center;vertical-align:bottom">
    <strong><span style="text-decoration:underline;"><span style="font-family: 宋体;font-size: 21px"><span style="font-family:宋体">试</span> &nbsp;<span style="font-family:宋体">卷</span> &nbsp;<span style="font-family:宋体">分</span> &nbsp;<span style="font-family:宋体">析</span> &nbsp;<span style="font-family:宋体">单</span></span></span></strong>
</p>
<p style=";text-align:center;vertical-align:bottom">
    <strong><span style="font-family: 宋体;font-size: 21px">&nbsp;</span></strong><strong><span style="text-decoration:underline;"><span style="font-family: 宋体;font-size: 21px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></strong><strong><span style="font-family: 宋体;font-size: 21px"><span style="font-family:宋体"></td>学年度</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-family:宋体">第</span></span></strong><strong><span style="text-decoration:underline;"><span style="font-family: 宋体;font-size: 21px">&nbsp;&nbsp;&nbsp;&nbsp;</span></span></strong><strong><span style="font-family: 宋体;font-size: 21px"><span style="font-family:宋体">学期</span></span></strong>
</p>
<p style=";text-align:center;vertical-align:bottom">
    <strong><span style="font-family: 宋体;font-size: 21px">&nbsp;</span></strong>
</p>
<p style=";text-align:right;vertical-align:bottom">
    <strong><span style="font-family: 宋体;font-size: 16px"><span style="font-family:宋体">年</span> &nbsp;&nbsp;&nbsp;<span style="font-family:宋体">月</span> &nbsp;&nbsp;&nbsp;<span style="font-family:宋体">日</span></span></strong>
</p>
</div>
<div style="text-align: center ">
<table border="1" cellpadding="0" cellspacing="0">
    <tbody>
    <tr style="height:27px" class="firstRow">
        <td width="78" valign="bottom" style="padding: 1px; border-width: 1px; border-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">考试科目</span></strong>
            </p>
        </td>
        <td width="78" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"><input id="e_course" type="text"></td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">考试班级</span></strong>
            </p>
        </td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"><input id="e_class" type="text"></td></td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">任课教师</span></strong>
            </p>
        </td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"><input id="e_teacher" type="text"></td></td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">考试性质</span></strong>
            </p>
        </td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top-width: 1px; border-top-color: rgb(255, 255, 255); border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"><input id="e_state" type="text"></td></td>
    </tr>
    <tr style="height:27px">
        <td width="78" valign="bottom" style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">考试方式</span></strong>
            </p>
        </td>
        <td width="78" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">考试时间</span></strong>
            </p>
        </td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">考试人数</span></strong>
            </p>
        </td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <strong><span style="font-family: 宋体;font-size: 16px">缺考人数</span></strong>
            </p>
        </td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:31px">
        <td width="156" valign="top" colspan="2" rowspan="7" style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style=";text-align:center;vertical-align:top">
                <strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">个题得分率</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="text-decoration:underline;"><span style="font-family: 宋体;font-size: 19px">全班该题实得分数</span></span></strong><strong><span style="text-decoration:underline;"><span style="font-family: 宋体;font-size: 19px"><br/></span></span></strong><strong><span style="font-family: 宋体;font-size: 19px">该题满分值*参考人数</span></strong>
            </p>
        </td>
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <span style="font-family: 宋体;font-size: 19px">1</span>
            </p>
        </td>
        <td width="355" valign="bottom" colspan="5" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px">
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <span style="font-family: 宋体;font-size: 19px">2</span>
            </p>
        </td>
        <td width="355" valign="bottom" colspan="5" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px">
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <span style="font-family: 宋体;font-size: 19px">3</span>
            </p>
        </td>
        <td width="355" valign="bottom" colspan="5" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px">
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <span style="font-family: 宋体;font-size: 19px">4</span>
            </p>
        </td>
        <td width="355" valign="bottom" colspan="5" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px">
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <span style="font-family: 宋体;font-size: 19px">5</span>
            </p>
        </td>
        <td width="355" valign="bottom" colspan="5" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px">
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <span style="font-family: 宋体;font-size: 19px">6</span>
            </p>
        </td>
        <td width="355" valign="bottom" colspan="5" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"><input id="e_1   " type="text"></td></td>
    </tr>
    <tr style="height:27px">
        <td width="71" valign="bottom" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style="vertical-align: bottom">
                <span style="font-family: 宋体;font-size: 19px">7</span>
            </p>
        </td>
        <td width="355" valign="bottom" colspan="5" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px">
        <td width="156" valign="top" colspan="2" rowspan="8" style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style=";text-align:center;vertical-align:top">
                <strong><span style="font-family: 宋体;font-size: 19px">卷面分析</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">（主要包括</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">覆盖面，</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">深广度、</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">难度、效</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">度、区分</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">度、信度</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">等方面）</span></strong>
            </p>
        </td>
        <td width="427" valign="bottom" colspan="6" rowspan="8" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px">
        <td width="156" valign="top" colspan="2" rowspan="6" style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style=";text-align:center;vertical-align:top">
                <strong><span style="font-family: 宋体;font-size: 19px">学</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">生</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">学</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">习</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">情</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">况</span></strong>
            </p>
        </td>
        <td width="427" valign="bottom" colspan="6" rowspan="6" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:38px"></tr>
    <tr style="height:4px"></tr>
    <tr style="height:27px">
        <td width="156" valign="top" colspan="2" rowspan="6" style="padding: 1px; border-left-width: 1px; border-left-color: rgb(255, 255, 255); border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);">
            <p style=";text-align:center;vertical-align:top">
                <strong><span style="font-family: 宋体;font-size: 19px">主</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">要</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">改</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">进</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">措</span></strong><strong><span style="font-family: 宋体;font-size: 19px"><br/></span></strong><strong><span style="font-family: 宋体;font-size: 19px">施</span></strong>
            </p>
        </td>
        <td width="427" valign="bottom" colspan="6" rowspan="6" style="padding: 1px; border-left: none; border-right-width: 1px; border-right-color: rgb(255, 255, 255); border-top: none; border-bottom-width: 1px; border-bottom-color: rgb(255, 255, 255);"></td>
    </tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    <tr style="height:27px"></tr>
    </tbody>
</table>
</div>
</html>
