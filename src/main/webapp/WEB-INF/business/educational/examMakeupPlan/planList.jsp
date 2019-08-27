<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">补考排考管理</span>
                </div>
                <div class="block block-drop-shadow content">
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
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreExamTable" cellpadding="0" cellspacing="0"
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
    var scoreExamTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selTerm');
        });
        search();
        scoreExamTable.on('click', 'tr a', function () {
            var data = scoreExamTable.row($(this).parent()).data();
            var scoreExamId = data.scoreExamId;
            if (this.id == "editRoom") {
                $("#right").load("<%=request.getContextPath()%>/exam/makeup/makeupExamRoom?scoreExamId=" + scoreExamId+"&scoreExamName="+data.scoreExamName );
                $("#right").modal("show");
            }else if (this.id == "editPlan") {
                $("#right").load("<%=request.getContextPath()%>/exam/makeup/makeupExamCourse?scoreExamId=" + scoreExamId+"&scoreExamName="+data.scoreExamName );
                $("#right").modal("show");
            }else if (this.id == "checkPlan"){
                $.post("<%=request.getContextPath()%>/exam/makeup/checkExamMakeupPlan?scoreExamId=" + scoreExamId, {
                },function (msg) {
                    swal({title: msg.msg, type: msg.result});

                });
            }
        });
    })

    function searchclear() {
        $("#selName").val("");
        $("#selTerm").val("");
        search();
    }
    function search() {
        var scoreExamName = $("#selName").val();
        scoreExamName="%"+scoreExamName+"%";
        var term=$("#selTerm").val();
        scoreExamTable = $("#scoreExamTable").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/scoreExam/getScoreExamList1',
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
                {"width":"8%","title": "操作",
                    "render": function () {
                        return "<a id='editRoom' class='icon-home' title='补考考场设置'></a>&nbsp;&nbsp;&nbsp;&nbsp;"+
                            "<a id='editPlan' class='icon-align-justify' title='补考考场设置'></a>&nbsp;&nbsp;&nbsp;&nbsp;"+
                            "<a id='checkPlan' class='icon-wrench' title='整体校验'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>