<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2017/4/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="content">
    <div class="col-md-12">
        <div class="block">
            <div class="header">
                <span style="font-size: 15px;margin-left: 20px">${complexTaskName} > 子评教管理</span>
            </div>
            <div class="content">
                <button type="button" class="btn btn-default btn-clean"
                        onclick="back()">返回
                </button>
            </div>
        </div>
        <div class="block">
            <div class="content">
                <button type="button" class="btn btn-default btn-clean" id="addBtn"
                        onclick="add()">新增
                </button>
                <table id="ComplexDetailTable" cellpadding="0" cellspacing="0" width="100%"
                       class="table table-bordered table-striped sortable_default">
                </table>
            </div>
        </div>
    </div>
    <input type="hidden" id="complexTaskId" value="${complexTaskId}">
    <input type="hidden" id="term" value="${term}">
    <input type="hidden" id="testFlag" value="${testFlag}"/>
    <input type="hidden" id="evaluationType" value="${evaluationType}"/>
</div>
<script>
    var ComplexDetailTable;
    $(document).ready(function () {
        var sty = "";
        var testFlag = $("#testFlag").val();
        if(testFlag== '1'){
            $('#addBtn').css('display','none');
            sty = ' style="display:none" ';
        }

        ComplexDetailTable = $("#ComplexDetailTable").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/evaluation/complex/getComplexDetail',
                "data": {
                    complexTaskId: $("#complexTaskId").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "complexTaskId", "visible": false},
                {"width": "30%", "data": "taskShowName", "title": "子评教名称"},
                {"width": "20%", "data": "taskName", "title": "包含评教"},
                {"width": "20%", "data": "weights", "title": "权重"},
                {"width": "20%", "data": "score", "title": "子评教原总分"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function (date,type,row) {
                        return  '<a class="icon-edit" title="查看" id="edit" />&nbsp;&nbsp;&nbsp;' +
                            '<a class="icon-trash" title="删除" id="del" '+ sty +' />';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });

        ComplexDetailTable.on('click', 'tr a', function () {
            var data = ComplexDetailTable.row($(this).parent()).data();
            if(this.id == "edit"){
                $("#dialog").load("<%=request.getContextPath()%>/evaluation/complex/viewComplexDetail?id="+data.id);
                $("#dialog").modal("show");
            }else if(this.id == "del"){
                swal({
                    title: "您确定要删除本条信息？ ",
                    text: "子评教名称："+data.taskShowName+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/evaluation/complex/delChildTask?id=" + data.id, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "success"});
                            $('#ComplexDetailTable').DataTable().ajax.reload();
                        }
                    })

                });
                /* if (confirm("确定要删除"+data.taskShowName+"子评教?")) {
                    $.get("/evaluation/complex/delChildTask?id=" + data.id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#ComplexDetailTable').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });

    });

    function add() {
        $.post("<%=request.getContextPath()%>/evaluation/complex/checkDetailWeights", {
            complexTaskId: $("#complexTaskId").val()
        }, function (msg) {
            if (msg.status == 1) {
                $("#dialog").load("<%=request.getContextPath()%>/evaluation/complex/addComplexDetail" +
                    "?complexTaskId="+$("#complexTaskId").val()+"&term="+$("#term").val()
                    +"&evaluationType="+$("#evaluationType").val());
                $("#dialog").modal("show");
            }else if (msg.status == 0) {
                swal({title: msg.msg, type: "error"});
            }
        })
    }

    function back() {
        $("#right").load("<%=request.getContextPath()%>/evaluation/complex/getTaskList");
    }
</script>
