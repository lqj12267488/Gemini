<%--助学金信息查询
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/5
  Time: 17:22
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
            addOption(data, 'departmentsIdSel');
        });
        var deptId = $("#departmentsIdSel").val();
        $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSel');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXJLB", function (data) {
            addOption(data, 'grantTypeSel');
        });
        search();
        StudentGrantsTable.on('click', 'tr a', function () {
            var data = StudentGrantsTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "viewGrants") {
                $("#dialog").load("<%=request.getContextPath()%>/studentGrants/studentGrantsDetail?id=" + id);
                $("#dialog").modal("show");
            }
        });
    })
    //选择系部后,查询系部下的专业
    function changeMajor() {
        var deptId = $("#departmentsIdSel").val();
        $.get("<%=request.getContextPath()%>/studentGrants/getMajorDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSel');
        });
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
                {"width":"10%","data": "studentId", "title": "学生姓名"},
                {"width":"12%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorCode", "title": "专业"},
                {"width":"10%","data": "classId", "title": "班级"},
                {"width":"12%","data": "trainingLevel", "title": "培养层次"},
                {"width":"12%","data": "grantType", "title": "助学金类别"},
                {"width":"12%","data": "money", "title": "金额"},
                {"width":"12%","data": "term", "title": "学期"},
                {"width":"8%","title": "操作","render": function () {return "<a id='viewGrants' class='icon-book' title='详情'></a>";}}
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

