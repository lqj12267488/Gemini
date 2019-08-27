<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/10/12
  Time: 11:21
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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
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
            var scoreExamId = data.scoreExamId;
            var scoreExamName = data.scoreExamName;
            if (this.id == "update") {
                $.get("<%=request.getContextPath()%>/scoreImport/getTermIdByStudentIdScoreExamId?scoreExamId=" + scoreExamId, function (boolean) {
                    if (boolean==true) {
                        $("#right").load("<%=request.getContextPath()%>/student/studentPersonScoreList?scoreExamId=" + scoreExamId);
                        $("#right").modal("show");
                    }else{
                        swal({
                            title: "本学生没有参加本次考试",
                            type: "info"
                        });
                    }
                })

            }



        });
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/scoreExam/editScoreExam" );
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#selName").val("");
        $("#selTerm").val("");
        search();
    }
    function search() {
        var scoreExamName = $("#selName").val();
        scoreExamName="%"+scoreExamName+"%";
        var term=$("#selTerm").val();
        scoreExamTable = $("#scoreExamGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/scoreExam/getScoreExamList',
                "data":{
                    scoreExamName: scoreExamName,
                    term:term
                }
            },
            "destroy": true,
            "columns": [
                {"data": "scoreExamId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "scoreExamName", "title": "考试名称"},
                {"width":"8%","data": "startTime", "title": "开始时间"},
                {"width":"8%","data": "endTime", "title": "结束时间"},
                {"width":"12%","data": "term", "title": "学期"},
                {"width":"8%","title": "操作","render": function () {return
                    "<a id='update' class='icon-edit' title='学生个人成绩查看'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>