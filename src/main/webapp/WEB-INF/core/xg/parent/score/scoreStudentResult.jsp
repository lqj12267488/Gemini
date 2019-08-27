<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content" id="list">
                    <header class="mui-bar mui-bar-nav">
                        <h5 class="mui-title"> 学生考试成绩查询</h5>
                    </header>
                    <ul class="nav nav-tabs nav-justified">
                        <c:forEach items="${classScoreExam}" var="classObj">
                            <li><a href="#li_${classObj.classBean.id}" id="menu_${classObj.classBean.id}" data-toggle="tab">${classObj.classBean.text}班级成绩单</a></li>
                        </c:forEach>
                    </ul>
                    <div class="content tab-content">
                        <c:forEach items="${classScoreExam}" var="classObj">
                            <div class="tab-pane" id="li_${classObj.classBean.id}">
                                <div id="cont_${classObj.classBean.id}"></div>
                                <br/>
                                <h5 class="mui-title">${classObj.classBean.text}班级 成绩单</h5>
                                <div class="form-row " style="overflow-y:auto;">
                                    <table cellpadding="0" cellspacing="0"
                                           width="100%" style="max-height: 50%;min-height: 10%;"
                                           class="table table-bordered table-striped sortable_default">
                                        <tr>
                                            <td></td>
                                            <c:forEach items="${classObj.exam}" var="classExam">
                                                <td>${classExam.text}</td>
                                            </c:forEach>
                                        </tr>
                                        <c:forEach items="${classObj.course}" var="classCourse">
                                            <tr>
                                                <td>${classCourse.text}</td>
                                                <c:forEach items="${classObj.exam}" var="classExam">
                                                    <td><div id="studentScore_${classObj.classBean.id}_${classExam.id}_${classCourse.id}"></div></td>
                                                </c:forEach>
                                            </tr>
                                        </c:forEach>

                                    </table>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
<%----%>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {
        if ( '${classNum}' == '0') {
            var th1 = '<th>当前学生暂无班级</th>';
            $("#list").html(th1);
        } else {
            document.getElementById("menu_${classCheck}").click();
            var courseList = JSON.parse('${courseList}');
            $.each(courseList, function (index, content) {
                var scorehtm = "";
                scorehtm = content.score ;
                if(content.makeupScore!= null && content.makeupScore!= ""){
                    scorehtm = scorehtm+ "&nbsp;&nbsp;补考成绩："+content.makeupScore;
                }
                if(content.graduateMakeupScore != null && content.graduateMakeupScore!= "" ){
                    scorehtm = scorehtm+ "&nbsp;&nbsp;毕业补考成绩："+content.graduateMakeupScore;
                }
                $("#studentScore_"+content.classId+"_"+content.termId+"_"+content.courseValue).html(scorehtm);
            })
        }

    });
</script>
<style>

    table tr th {
        text-align: center;
    }

    table tr td {
        text-align: center;
    }

    th, td {
        white-space: nowrap;
    }

</style>