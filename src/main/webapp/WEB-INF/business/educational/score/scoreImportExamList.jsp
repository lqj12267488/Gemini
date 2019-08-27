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
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="termSel"></select>
                            </div>
                            <div class="col-md-1 tar">
                                考试名称：
                            </div>
                            <div class="col-md-2">
                                <input id="nameSel"/>
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
                        <table id="scoreImportGrid" cellpadding="0" cellspacing="0"
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
    var scoreImportTable;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termSel');
        });
        search();
        scoreImportTable.on('click', 'tr a', function () {
            var data = scoreImportTable.row($(this).parent()).data();
            var id = data.scoreExamId;
            var name = data.scoreExamName;
            if (this.id == "getScoreImport") {
                $("#right").load("<%=request.getContextPath()%>/scoreClass/studentGrid?scoreExamName=" + name + "&scoreExamId=" + id);
            }
        });
    });

    function searchclear() {
        $("#nameSel").val("");
        $("#termSel").val("");
        search();
    }

    function search() {
        var term = $("#termSel option:selected").val();
        var scoreExamName = $("#nameSel").val();
        scoreImportTable = $("#scoreImportGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/scoreImport/getExamList',
                "data": {
                    term: term,
                    scoreExamName: scoreExamName
                }
            },
            "destroy": true,
            "columns": [
                {"data": "scoreExamId", "visible": false},
                {"data": "term", "visible": false},
                {"width": "18%", "data": "termShow", "title": "学期"},
                {"width": "18%", "data": "scoreExamName", "title": "考试名称"},
                {"width": "18%", "data": "startTime", "title": "开始时间"},
                {"width": "18%", "data": "endTime", "title": "结束时间"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getScoreImport' class='icon-eye-open' title='查看成绩'></a>";
                    }
                },
            ],
            'order': [2, 'asc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }

</script>
