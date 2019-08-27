<%--助学金信息管理
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/28
  Time: 14:47
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
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSel" onchange="changeMajor()" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                专业类型：
                            </div>
                            <div class="col-md-2">
                                <select id="majorCodeSel" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                助学金类别:
                            </div>
                            <div class="col-md-2">
                                <select id="grantTypeSel" class="js-example-basic-single"></select>
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
                                onclick="addStudentGrants()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="studentGrantsTable" cellpadding="0" cellspacing="0" width="100%"
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
    var StudentGrantsTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsIdSel');//addOption()为加载下拉选项的加载方法,可以通过ctrl+左键点击看一下
        });
        var deptId = $("#departmentsIdSel").val();//获取当前系部id
        $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {//将系部id传入方法获取所属专业
            addOption(data, 'majorCodeSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXJLB", function (data) {
            addOption(data, 'grantTypeSel');
        });
        search();
    })
    //选择系部后,查询系部下的专业
    function changeMajor() {
        var deptId = $("#departmentsIdSel").val();
        $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSel');
        });
    }

    StudentGrantsTable.on('click', 'tr a', function () {
        //var data = roleTable.row(this.parent).data();
        var data = StudentGrantsTable.row($(this).parent()).data();
        var id = data.id;
        var studentId = data.studentId;
        //修改
        if (this.id == "updateGrants") {
            $("#dialog").load("<%=request.getContextPath()%>/studentGrants/updateStudentGrants?id=" + id);
            $("#dialog").modal("show");
        }
        //删除
        if (this.id == "delGrants") {
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
                $.get("<%=request.getContextPath()%>/studentGrants/deleteStudentGrantsById?id=" + id, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#studentGrantsTable').DataTable().ajax.reload();
                    }
                })
            });

        }
    });

    function addStudentGrants() {
        $("#dialog").load("<%=request.getContextPath()%>/studentGrants/addStudentGrants");
        $("#dialog").modal("show");
    }

    function search() {
        var departmentsIdSel = $("#departmentsIdSel").val();
        var majorCodeSel = $("#majorCodeSel").val();
        var grantTypeSel = $("#grantTypeSel").val();
        StudentGrantsTable = $("#studentGrantsTable").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/studentGrantsManagement/getStudentGrantsList',
                "data":{
                    departmentsId: departmentsIdSel,
                    majorCode: majorCodeSel,
                    grantType: grantTypeSel
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "studentId", "title": "学生姓名"},
                {"width":"10%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorCode", "title": "专业"},
                {"width":"10%","data": "classId", "title": "班级"},
                {"width":"12%","data": "trainingLevel", "title": "培养层次"},
                {"width":"12%","data": "grantType", "title": "助学金类别"},
                {"width":"12%","data": "money", "title": "金额"},
                {"width":"12%","data": "term", "title": "学期"},
                {"width":"8%","title": "操作","render": function () {return "<a id='updateGrants' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delGrants' class='icon-trash' title='删除'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function searchclear() {
        //注意:此处不能使用 option:selected 不然会造成下拉选项无法恢复成请选择
        $("#departmentsIdSel").val("");
        $("#majorCodeSel").val("");
        $("#grantTypeSel").val("");
        search();
    }
</script>


