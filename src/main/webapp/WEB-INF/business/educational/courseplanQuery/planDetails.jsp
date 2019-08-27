<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">${planName} > 计划管理</span>
                </div>
                <div class="block block-drop-shadow content block-fill-white">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            课程名称：
                        </div>
                        <div class="col-md-2">
                            <input id="courseName"/>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>

                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                    </div>

                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#table").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/courseplan/getPlanDetails?planId=${id}',
            },
            "destroy": true,
            "columns": [
                {"data": "courseName", "title": "课程名称"},
                {"data": "textbookName", "title": "教材名称"},
                {"data": "theoreticalHours", "title": "理论学时"},
                {"data": "practiceHours", "title": "实践学时"},
                {"data": "totalHours", "title": "总学时"},
                {"data": "theoryPracticeHours", "title": "理实结合学时"},
                {"data": "examType", "title": "考核方式"},
                {"data": "credit", "title": "学分"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-eye-open" title="查看" onclick=toPlanTerms("' + row.id + '","'+row.courseName+'")/>&ensp;&ensp;';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
    })

    function back() {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toCoursePlanQuery");
    }

    function search() {
        var courseName = $("#courseName").val();
        $("#table").DataTable().ajax.url("<%=request.getContextPath()%>/courseplan/getPlanDetails?planId=${id}&courseName=" + courseName).load();
    }

    function searchclear() {
        $("#courseName").val("");
        search();
    }

    function toPlanTerms(id ,courseName) {
        $("#right").load("<%=request.getContextPath()%>/courseplan/toPlanTerm?planName=${planName}&id=" + id + "&courseName="+courseName);
    }

</script>