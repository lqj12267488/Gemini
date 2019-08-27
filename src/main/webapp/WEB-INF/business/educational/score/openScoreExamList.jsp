<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/11/27
  Time: 14:01
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
            if (this.id == "list") {
                $("#right").load("<%=request.getContextPath()%>/scoreExam/openScoreList?scoreExamId=" + scoreExamId + "&scoreExamName=" + scoreExamName);
                $("#right").modal("show");
            }
        });
    })

    function searchclear() {
        $("#selTerm").val("");
        search();
    }

    function search() {
        var term = $("#selTerm").val();
        scoreExamTable = $("#scoreExamGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreExam/getOpenScoreExamList',
                "data": {
                    term: term
                }
            },
            "destroy": true,
            "columns": [
                {"data": "scoreExamId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "20%", "data": "termShow", "title": "学期"},
                {"width": "22%", "data": "scoreExamName", "title": "考试名称"},
                {
                    "width": "15%", "title": "操作",
                    "render": function () {
                        return "<a id='list' class='icon-search' title='查看详情'></a>";
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
