<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/23
  Time: 9:27
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
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="selClassId" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                班主任：
                            </div>
                            <div class="col-md-2">
                                <input id="selHeadTeacher" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                授予时间:
                            </div>
                            <div class="col-md-2">
                                <input id="selGrantTime" type="date"/>
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
                        <table id="miyoshiClassGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var miyoshiClassTable;
    $(document).ready(function () {
        search();
        miyoshiClassTable.on('click', 'tr a', function () {
            var data = miyoshiClassTable.row($(this).parent()).data();
            var id = data.id;
            var classId = data.classId;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/edit?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delete") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "班级："+classId+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/detele?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#miyoshiClassGrid').DataTable().ajax.reload();
                        }
                    })
                });
                /*if (confirm("确认要删除?")) {
                    $.get("/studentRewardPunish/miyoshiClass/detele?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#miyoshiClassGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
            if (this.id == "detail") {
                $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/edit?id="+id+"&flag=1");
                $("#dialog").modal("show");
            }
        });
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/edit" );
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#selClassId").val("");
        $("#selHeadTeacher").val("");
        $("#selGrantTime").val("");
        search();
    }
    function search() {
        var classId = $("#selClassId").val();
        classId="%"+classId+"%";
        var headTeacher = $("#selHeadTeacher").val();
        headTeacher="%"+headTeacher+"%";
        var grantTime = $("#selGrantTime").val();
        miyoshiClassTable = $("#miyoshiClassGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/studentRewardPunish/miyoshiClass/getList',
                "data":{
                    classId: classId,
                    headTeacher: headTeacher,
                    grantTime: grantTime
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"8%","data": "classId", "title": "班级"},
                {"width":"8%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorShow", "title": "专业"},
                {"width":"8%","data": "headTeacher", "title": "班主任"},
                {"width":"12%","data": "grantUnit", "title": "授予单位"},
                {"width":"12%","data": "grantTime", "title": "授予时间"},
                {"width":"8%","title": "操作","render": function () {return "<a id='update' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delete' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='detail' class='icon-search' title='查看'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
