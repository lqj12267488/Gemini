<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="header">
                    <span style="font-size: 15px;margin-left: 20px">补考考场安排</span>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="back()">返回
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addExamRoom()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row" >
                        ${re}
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="scoreRomeTable" cellpadding="0" cellspacing="0"
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
    var scoreRomeTable;
    $(document).ready(function () {
/*
        $.get("< %=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selTerm');
        });
*/
        search();
        scoreRomeTable.on('click', 'tr a', function () {
            var data = scoreRomeTable.row($(this).parent()).data();
            var scoreExamId = data.scoreExamId;
            if (this.id == "editRoom") {
                $("#dialog").load("<%=request.getContextPath()%>/exam/makeup/editMakeupRoom?scoreExamId=${scoreExamId}&examRoomId=" +data.examRoomId  );
                $("#dialog").modal("show");
            }else if (this.id == "delRoom"){
                swal({
                    title: "您确定要删除本考场?",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/exam/makeup/delMakeupRoom?examRoomId=" +data.examRoomId, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#scoreRomeTable').DataTable().ajax.reload();
                    })
                });
            }else if (this.id == "viewRoom"){
                $("#dialog").load("<%=request.getContextPath()%>/scoreGraduateMakeup/importAfterGraduation?scoreExamId=" + scoreExamId);
                $("#dialog").modal("show");
            }
        });
    })

    function searchclear() {
        $("#selName").val("");
        $("#selTerm").val("");
        search();
    }
    function search() {
        scoreRomeTable = $("#scoreRomeTable").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/exam/makeup/getMakeupExamRoom?examId=${scoreExamId}'
            },
            "destroy": true,
            "columns": [
                {"data": "examId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "roomName", "title": "考场名称"},
                {"width":"8%","data": "studentNumber", "title": "容纳考生数量"},
                {"width":"8%","title": "操作",
                    "render": function () {
                        return "<a id='editRoom' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;&nbsp;"
                                 +"<a id='delRoom' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;&nbsp;"
//                            + "<a id='viewRoom' class='icon-wrench' title='考场情况查询'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function addExamRoom() {
        $("#dialog").load("<%=request.getContextPath()%>/exam/makeup/editMakeupRoom?scoreExamId=${scoreExamId}");
        $("#dialog").modal("show");

//        /exam/makeup/
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/exam/makeup/makeupExamPlan");
    }



</script>