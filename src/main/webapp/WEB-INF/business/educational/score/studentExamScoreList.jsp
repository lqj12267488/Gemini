<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/18
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <header class="mui-bar mui-bar-nav">
                            <h5 class="mui-title">${scoreExamName}成绩单</h5>
                        </header>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="back()">返回
                            </button>
                            <a id="exportList" class="btn btn-info btn-clean" >导出成绩单</a>
                            <br>
                        </div>
                        <table id="listGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="scoreExamId" value="${scoreExamId}" hidden/>
    <input id="scoreExamName" value="${scoreExamName}" hidden/>
</div>
<script>
    var listTable;
    $(document).ready(function () {
        var scoreExamId=$("#scoreExamId").val();
        var scoreExamName=$("#scoreExamName").val();
        var exportUrl = "<%=request.getContextPath()%>/studentExamScore/exportList?scoreExamId="+scoreExamId+"&scoreExamName="+scoreExamName;        $("#exportList").attr("href",exportUrl);
        listTable = $("#listGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/studentExamScore/getStudentExamScoreList',
                "data":{
                    scoreExamId: scoreExamId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "scoreExamId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "courseId", "title": "课程名称"},
                /*     {"width":"12%","data": "totalScore", "title": "总分"},
                     {"width":"12%","data": "passScore", "title": "及格分"},*/
                {"width":"8%","data": "examinationStatus", "title": "考试状态"},
                {"width":"12%","data": "score", "title": "成绩"}
                /*  {"width":"8%","data": "makeupStatus", "title": "补考状态"},
                  {"width":"8%","data": "makeupScore", "title": "补考成绩"},
                  {"width":"12%","data": "graduateMakeupStatus", "title": "毕业补考状态"},
                  {"width":"12%","data": "graduateMakeupScore", "title": "毕业补考成绩"}*/
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    })
    function back(){
        $("#right").load("<%=request.getContextPath()%>/studentExamScore/studentExamList");
        $("#right").modal("show");
    }
</script>

