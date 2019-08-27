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
                                学生姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="selStudentId" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:120px">
                                助学金类别：
                            </div>
                            <div class="col-md-2">
                                <select id="selGrantType" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                上报时间:
                            </div>
                            <div class="col-md-2">
                                <select id="selReportTerm" class="js-example-basic-single"></select>
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
                        <table id="grantsGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var grantsTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXJLB", function (data) {
            addOption(data, 'selGrantType');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selReportTerm');
        });
        search();
        grantsTable.on('click', 'tr a', function () {
            var data = grantsTable.row($(this).parent()).data();
            var id = data.id;
            var studentId = data.studentId;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/grants/edit?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delete") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "学生姓名："+studentId+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/studentRewardPunish/grants/detele?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#grantsGrid').DataTable().ajax.reload();
                        }
                    })

                });
               /* if (confirm("确认要删除?")) {
                    $.get("/studentRewardPunish/grants/detele?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#grantsGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
            if (this.id == "detail") {
                $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/grants/edit?id="+id+"&flag=1");
                $("#dialog").modal("show");
            }
        });
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/grants/edit" );
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#selStudentId").val("");
        $("#selGrantType").val("");
        $("#selReportTerm").val("");
        search();
    }
    function search() {
        var studentId = $("#selStudentId").val();
        studentId="%"+studentId+"%";
        var grantType = $("#selGrantType").val();
        var reportTerm = $("#selReportTerm").val();
        grantsTable = $("#grantsGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/studentRewardPunish/grants/getList',
                "data":{
                    studentId: studentId,
                    grantType: grantType,
                    reportTerm: reportTerm
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "studentId", "title": "学生姓名"},
                {"width":"8%","data": "sexShow", "title": "性别"},
                {"width":"10%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorShow", "title": "专业"},
                {"width":"8%","data": "classId", "title": "班级"},
                {"width":"12%","data": "grantType", "title": "助学金类别"},
                {"width":"15%","data": "grantSum", "title": "助学金(元)"},
                {"width":"15%","data": "reportTerm", "title": "上报时间"},
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