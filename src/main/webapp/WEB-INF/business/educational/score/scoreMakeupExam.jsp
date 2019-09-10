<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/11/20
  Time: 9:00
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
                        <div class="form-row">
                            <div class="col-md-1 tar" style="width:100px">
                                考试名称：
                            </div>
                            <div class="col-md-2">
                                <input id="selName" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                学期:
                            </div>
                            <div class="col-md-2">
                                <select id="selTerm" class="js-example-basic-single"></select>
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
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreExamGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="type" hidden value="${type}">
</div>
<script>
    var scoreExamTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selTerm');
        });
        search();
        scoreExamTable.on('click', 'tr a', function () {
            var data = scoreExamTable.row($(this).parent()).data();
            var scoreExamId = data.examId;
            var scoreExamName = data.examName;
            var openFlag = data.openFlag;
            var term = data.termShow;
            if (this.id == "list" ) {
                if("${type}"=="3" || "${type}"=="4" ){
                    $("#right").load("<%=request.getContextPath()%>/scoreExam/toCourseClass?type=${type}&queryFlag=2&id=" + scoreExamId + "&openFlag=" + openFlag);
                }else {
                    $("#right").load("<%=request.getContextPath()%>/scoreExam/toCourseClass?type=${type}&queryFlag=1&id=" + scoreExamId + "&openFlag=" + openFlag);
                }
            }
        });
    })

    function seeDetails(id) {
        $("#right").load("<%=request.getContextPath()%>/scoreExam/seeDetails?type=${type}&id=" + id);
    }

    function searchclear() {
        $("#selName").val("");
        $("#selTerm").val("");
        search();
    }

    function search() {
        var scoreExamName = $("#selName").val();
        scoreExamName = "%" + scoreExamName + "%";
        var term = $("#selTerm").val();
        scoreExamTable = $("#scoreExamGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreExam/getScoreExamList1',
                "data": {
                    examName: scoreExamName,
                    term: term,
                    examTypes: '${type}'
                }
            },
            "destroy": true,
            "columns": [
                {"data": "examId", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "openFlag", "visible": false},
                {"data": "examName", "title": "考试名称"},
                {"data": "startTime", "title": "开始时间"},
                {"data": "endTime", "title": "结束时间"},
                {"data": "termShow", "title": "学期"},
                {
                    "title": "状态",
                    "render": function (data, type, row) {
                        switch (row.status) {
                            case '0':
                                return '未提交';
                            case '1':
                                return '全部提交';
                            case '2':
                                return '部分提交'
                        }
                    }
                },
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        if("${type}"=="2"){
                            return "<a id='list' class='icon-align-justify'  title='期末补考成绩' ></a>&nbsp;&nbsp;&nbsp;"
                                + '<span class=\'icon-search\' onclick=seeDetails("' + row.examId + '") title="查看详情"></span>';
                        }
                        if("${type}"=="3"){
                            return "<a id='list' class='icon-align-justify' title='毕业前补考'></a>&nbsp;&nbsp;&nbsp;"
                                + '<span class=\'icon-search\' onclick=seeDetails("' + row.examId + '") title="查看详情"></span>';
                        }
                        if("${type}"=="4"){
                            return "<a id='list' class='icon-align-justify' title='毕业后补考'></a>&nbsp;&nbsp;&nbsp;"
                                + '<span class=\'icon-search\' onclick=seeDetails("' + row.examId + '") title="查看详情"></span>';
                        }
                    }
                }
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
</script>
