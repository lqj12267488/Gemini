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
                                评教方案：
                            </div>
                            <div class="col-md-2">
                                <input id="planNameSea" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
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
                    <table id="planTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var planTable;
    var eType =  '0';
    $(document).ready(function () {
        planTable = $("#planTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/evaluation/getPlanList?evaluationType='+eType,
            },
            "destroy": true,
            "columns": [
                {"data": "planId", "visible": false},
                {"data": "planName", "title": "评教方案名称"},
                {"data": "score", "title": "总分数"},
                {"data": "remark", "title": "备注"},
                {"data": "testFlag", "title": "是否校验"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        var htm ='<span class="icon-edit" title="修改"' +
                            ' onclick="editPlan(\'' + row.planId + '\')"/>&ensp;&ensp;' +
                            '<span class="icon-copy" title="复制评教方案"' +
                            ' onclick="editCopy(\'' + row.planId + '\')"/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" ' +
                            'onclick="del(\''+row.planId+'\',\''+row.planName+'\')"/>&ensp;&ensp;' +
                            '<span class="icon-cog" title="指标管理" ' +
                            'onclick="toIndex(\'' + row.planId + '\',\''+row.planName+'\')"/>&ensp;&ensp;';
                        if(row.testFlag != '验证通过')
                            htm = htm+ '<span class="icon-check" title="校验" ' +
                                'onclick="test(\'' +row.planId + '\')"/>';
                        return htm;
                    },
                    "width": "8%"
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/addPlan");
        $("#dialog").modal("show");
    }

    function editPlan(id) {
        $("#dialog").load("<%=request.getContextPath()%>/evaluation/toEditPlan", {
            id: id
        });
        $("#dialog").modal("show");
    }

    function editCopy(id) {
        swal({
            title: "您确定要复制本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "复制",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/editCopyPlan", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                planTable.ajax.reload();

            });

        });
    }
    function del(id,planName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "评教方案名称："+planName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/evaluation/deletePlan", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                planTable.ajax.reload();

            });

        });
       /* if (confirm("确定要删除此条记录？")) {
            $.post("/evaluation/deletePlan", {
                id: id
            }, function (msg) {
                alert(msg.msg);
                planTable.ajax.reload();
            });
        }*/
    }

    function toIndex(id,planName) {
        $("#right").load("<%=request.getContextPath()%>/evaluation/toIndex", {
            id: id,
            planName:planName
        });
    }

    function searchclear() {
        $("#planNameSea").val("");
        planTable.ajax.url("<%=request.getContextPath()%>/evaluation/getPlanList?evaluationType="+eType).load();
    }

    function search() {
        var planName = $("#planNameSea").val();
        planTable.ajax.url("<%=request.getContextPath()%>/evaluation/getPlanList?name=" + planName+"&evaluationType="+eType).load();
    }

    function test(id) {
        $.post("<%=request.getContextPath()%>/evaluation/checkPlan", {
            id: id
        }, function (msg) {
            swal({title: msg.msg, type: msg.result});
            planTable.ajax.reload();
        });

    }
</script>