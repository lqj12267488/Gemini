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
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                考试名称：
                            </div>
                            <div class="col-md-2">
                                <input id="eName" class="js-example-basic-single"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="content">
                    <table id="examTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#examTable").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": '<%=request.getContextPath()%>/exam/getExamList',
            },
            "destroy": true,
            "columns": [
                {"data": "createTime", "visible": false},
                {"data": "examId", "visible": false},
                {"data": "examName", "title": "考试名称"},
                {"data": "termShow", "title": "学期"},
                {"data": "examTypes", "title": "类型"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-male" title="设置巡考教师" onclick=toExaminationList("' + row.examId + '","' + row.examName + '")/>&ensp;&ensp;';
                    }
                }
            ],
            'order': [[0, 'desc']],
             paging: true,
            "dom": 'rtlip',
            "language": language
        });
    });

    function toExaminationList(examId, examName) {
        $("#right").load("<%=request.getContextPath()%>/exam/toExaminationList?id=" + examId + "&examName=" + examName);
    }

    function searchclear() {
        $("#eName").val("");
        table.ajax.url("<%=request.getContextPath()%>/exam/getExamList").load();
    }

    function search() {
        var eName = $("#eName").val();
        if (eName == "" && eName == "") {

        } else {
            table.ajax.url("<%=request.getContextPath()%>/exam/getExamList?examName=" + eName).load();
        }
    }
</script>