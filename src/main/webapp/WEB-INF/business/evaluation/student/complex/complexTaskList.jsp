<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
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
                                综合考评:
                            </div>
                            <div class="col-md-3">
                                <input id="complexTaskNameSel" type="text"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期:
                            </div>
                            <div class="col-md-3">
                                <select id="termSel" type="text"/>
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
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <table id="ComplexTaskTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var ComplexTaskTable;
    var eType = '1';
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termSel');
        });

        ComplexTaskTable = $("#ComplexTaskTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/xgEvaluation/complex/getComplexTask?evaluationType=' + eType
            },
            "destroy": true,
            "columns": [
                {"data": "complexTaskId", "visible": false},
                {"data": "term", "visible": false},
                {"data": "testFlag", "visible": false},
                {"width": "25%", "data": "complexTaskName", "title": "综合考评名称"},
                {"width": "10%", "data": "score", "title": "总分"},
                {"width": "10%", "data": "termShow", "title": "学期"},
                {"width": "15%", "data": "testFlagShow", "title": "是否验证"},
                {"width": "10%", "data": "creator", "title": "操作人"},
                {"width": "10%", "data": "startTime", "title": "操作时间"},
                {
                    "width": "20%",
                    "title": "操作",
                    "render": function (date, type, row) {
                        var htm ='<a class="icon-edit" title="修改" id="editComplexTask" />&nbsp;&nbsp;&nbsp;' +
                            '<a class="icon-cog" title="子考评管理" id="editChildTask" />&nbsp;&nbsp;&nbsp;' +
                            '<a class="icon-trash" title="删除" id="del" />&nbsp;&nbsp;&nbsp;' +
                            '<a class="icon-check" title="校验" id="checkComplexDetail" />&nbsp;&nbsp;&nbsp;';
                        if(row.testFlag == '1')
                            htm = htm + '<a class="icon-cogs" title="生成考评结果" id="insertResult" />&nbsp;&nbsp;&nbsp;' +
                                '<a class="icon-camera-retro" title="被考评人校验列表" id="checkEmpsList" />';
                        return  htm;
                    }
                }
            ],
//            'order' : [[1,'desc'],[7,'asc']],
            "dom": 'rtlip',
            language: language
        });

        ComplexTaskTable.on('click', 'tr a', function () {
            var data = ComplexTaskTable.row($(this).parent()).data();
            if (this.id == "editComplexTask") {// 查看
                $("#dialog").load("<%=request.getContextPath()%>/xgEvaluation/complex/editComplexTask?complexTaskId=" + data.complexTaskId + "&testFlag=" + data.testFlag);
                $("#dialog").modal("show");
            } else if (this.id == "editChildTask") {// 子考评管理
                $("#right").load("<%=request.getContextPath()%>/xgEvaluation/complex/editChildTask?" +
                    "complexTaskId=" + data.complexTaskId +
                    "&term=" + data.term + "&complexTaskName=" + data.complexTaskName +
                    "&testFlag=" + data.testFlag + "&evaluationType=" + eType);
            } else if (this.id == "del") {// 删除
                swal({
                    title: "您确定要删除本条信息？ ",
                    text: "综合评教名称：" + data.complexTaskName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/xgEvaluation/complex/delComplexTask?id=" +
                        data.complexTaskId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#ComplexTaskTable').DataTable().ajax.reload();
                        }
                    })

                });
                /* if (confirm("请确认是否要删除本条申请?")) {
                     $.get("/xgEvaluation/complex/delComplexTask?complexTaskId="+data.complexTaskId, function (msg) {
                         if (msg.status == 1) {
                             alert(msg.msg);
                             $('#ComplexTaskTable').DataTable().ajax.reload();
                         }
                     })
                 }*/
            } else if (this.id == "checkComplexDetail") {// 校验
                if (data.testFlag == "1") {
                    swal({title: "已成功校验!", type: "success"});
                    return;
                }
                $.get("<%=request.getContextPath()%>/xgEvaluation/complex/checkChildTask?complexTaskId=" + data.complexTaskId, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        $('#ComplexTaskTable').DataTable().ajax.reload();
                    }else if (msg.status == 2){
                        swal({title: msg.msg, type: "error"});
                    } else {
                        swal({title: msg.msg, type: "error"});
                    }
                })
            } else if (this.id == "insertResult") {// 生成考评结果
                if (data.testFlag == 0) {
                    swal({title: "请先校验！", type: "error"});
                    return;
                } else {
                    insertResult(data.complexTaskId);
                }
            }else if(this.id == "checkEmpsList"){// 被考评人校验列表
                $("#right").load( "<%=request.getContextPath()%>/evaluation/complex/checkEmpsList?" +
                    "complexTaskId="+data.complexTaskId+"&complexTaskName="+data.complexTaskName+
                    "&evaluationType="+eType);
            }

        });

    })

    function insertResult(complexTaskId) {
        $.get("<%=request.getContextPath()%>/xgEvaluation/complex/insertResult?complexTaskId=" + complexTaskId, function (msg) {
            swal({title: msg.msg, type: "success"});
            if (msg.status == 1) {
                $('#ComplexTaskTable').DataTable().ajax.reload();
            }
        })
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/xgEvaluation/complex/addComplexTask");
        $("#dialog").modal("show");
    }

    function updateEmpsMenmbers(taskId) {
        swal({title: "此评教已超期!", type: "error"});
        $.post("<%=request.getContextPath()%>/xgEvaluation/result/updateEmpsMenmbers",
            {taskId: taskId},
            function (msg) {
                ComplexTaskTable.ajax.reload();
            })
    }

    function search() {
        var complexTaskNameSel = $("#complexTaskNameSel").val();
        var term = $("#termSel option:selected").val();
        if (term == undefined || term == null) {
            term = "";
        }
        ComplexTaskTable.ajax.url("<%=request.getContextPath()%>/xgEvaluation/complex/getComplexTask?" +
            "complexTaskName=" + complexTaskNameSel + "&term=" + term + "&evaluationType=" + eType
        ).load();
    }

    function searchclear() {
        $("#complexTaskNameSel").val("");
        $("#termSel option:selected").val("")
        $("#termSel").val("")
        search();
    }

</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/libs/js/jquery.mousewheel.min.js"></script>