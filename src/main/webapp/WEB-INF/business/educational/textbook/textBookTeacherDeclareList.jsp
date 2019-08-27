<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/26
  Time: 15:29
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
                            <div class="col-md-1 tar">
                                课程名称
                            </div>
                            <div class="col-md-2">
                                <input id="f_courseName" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                圈定人
                            </div>
                            <div class="col-md-2">
                                <input id="f_boundPerson" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                教材名称
                            </div>
                            <div class="col-md-2">
                                <input id="s_textbookName" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchBranch()">
                                    查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="textBookDeclare()">
                            教材申报
                        </button>
                        <a id="exportData" class="btn btn-default btn-clean">导出</a>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="textBookGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="personType" hidden value="${personType}">
<script>
    var table;

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${data.departmentsId}');
        });
        if ('${data.majorCode}' != "") {
            var deptId = '${data.departmentsId}';
            $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
                addOption(data, 'majorCode', '${data.majorCode},${data.trainingLevel}');
            });
        } else {
            $("#majorCode").append("<option value='' selected>请选择</option>")
        }

        if ('${data.majorCode}' != "") {
            var majorCode = '${data.majorCode}';
            var trainingLevel = '${data.trainingLevel}';
            var majorDirection = '${data.majorDirection}';
            $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + majorCode + "&trainingLevel=" +
                trainingLevel, function (data) {
                addOption(data, 'classId', '${data.classId}');
            });
        } else {
            $("#classId").append("<option value='' selected>请选择</option>")
        }
        searchBranch();
        exportMajorTextBook();
        <%--table.on('click', 'tr a', function () {--%>
            <%--var data = table.row($(this).parent()).data();--%>
            <%--var id = data.id;--%>
            <%--var majorId = data.majorId;--%>
            <%--if (this.id == "editTextBookDeclare") {--%>
                <%--$("#dialog").load("<%=request.getContextPath()%>/textbook/editTextBookDeclare?id=" + id);--%>
                <%--$("#dialog").modal("show");--%>
            <%--}--%>
            <%--if (this.id == "delTextBookDeclare") {--%>
                <%--swal({--%>
                    <%--title: "您确定要删除本条信息?",--%>
                    <%--text: "专业名称：" + majorId + "\n\n删除后将无法恢复，请谨慎操作！",--%>
                    <%--type: "warning",--%>
                    <%--showCancelButton: true,--%>
                    <%--cancelButtonText: "取消",--%>
                    <%--confirmButtonColor: "#DD6B55",--%>
                    <%--confirmButtonText: "删除",--%>
                    <%--closeOnConfirm: false--%>
                <%--}, function () {--%>
                    <%--$.post("<%=request.getContextPath()%>/textbook/deleteTextBookDeclareById", {--%>
                        <%--id: id--%>
                    <%--}, function (msg) {--%>
                        <%--swal({--%>
                            <%--title: msg.msg,--%>
                            <%--type: msg.result--%>
                        <%--});--%>
                        <%--table.ajax.reload();--%>
                    <%--});--%>
                <%--})--%>
            <%--}--%>
            <%--if (this.id == "submit") {--%>
                <%--swal({--%>
                    <%--title: "您确定要提交吗?",--%>
                    <%--text: "提交之后将无法修改和删除，请谨慎操作！",--%>
                    <%--type: "warning",--%>
                    <%--showCancelButton: true,--%>
                    <%--cancelButtonText: "取消",--%>
                    <%--confirmButtonColor: "green",--%>
                    <%--confirmButtonText: "提交",--%>
                    <%--closeOnConfirm: false--%>
                <%--}, function () {--%>
                    <%--$.post("<%=request.getContextPath()%>/textbook/submitTextBookDeclareById", {--%>
                        <%--id: id,--%>
                        <%--personType: "1"--%>
                    <%--}, function (msg) {--%>
                        <%--swal({--%>
                            <%--title: msg.msg,--%>
                            <%--type: msg.result--%>
                        <%--});--%>
                        <%--table.ajax.reload();--%>
                    <%--});--%>
                <%--})--%>
            <%--}--%>
        <%--});--%>
    });

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getMajorCodeAndTrainingLeavelByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCode');
        });
    }

    function changeClass() {
        var majorCode = $("#majorCode").val();
        var arr = majorCode.split(",");
        $.get("<%=request.getContextPath()%>/common/getClassIdByMajor?majorCode=" + arr[0] + "&trainingLevel=" + arr[1], function (data) {
            addOption(data, 'classId');
        });
    }

    function exportMajorTextBook() {
        var href = "<%=request.getContextPath()%>/textbook/exportTextBookTeacherDeclare";
        $("#exportData").attr("href", href);
    }

    function textBookDeclare() {
        var personType = $("#personType").val();
        $("#dialog").load("<%=request.getContextPath()%>/textbook/addTextBookDeclare?personType="+personType);
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#s_textbookName").val("");
        $("#f_boundPerson").val("");
        $("#f_courseName").val("");
        searchBranch();
    }

    function searchBranch() {
        var textbookName = $("#s_textbookName").val();
        if (textbookName != "")
            textbookName = '%' + textbookName + '%';
        var departmentsId = $("#f_boundPerson").val();
        var majorCode = $("#f_courseName").val();
        table = $("#textBookGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/textbook/getTextBookDeclareList',
                "data": {
                    textbookName: textbookName,
                    submitState: "1",
                    personType: "1",
                    boundPerson:departmentsId,
                    courseId:majorCode,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                /*{"width": "8%", "data": "collegeShow", "title": "所属学院"},
                {"width": "8%", "data": "majorIdShow", "title": "专业名称"},
                {"width": "8%", "data": "trainingLevel", "title": "培养层次"},
                {"width": "8%", "data": "gradeId", "title": "年级"},
                {"width": "8%", "data": "classIdShow", "title": "班级名称"},*/
                {"width": "8%", "data": "courseId", "title": "课程名称"},
                // {"width": "10%", "data": "trainingLevel", "title": "培养层次"},
                // {"width": "10%", "data": "courseId", "title": "课程"},
                // {"width": "10%", "data": "creator", "title": "申报人"},
                {"width": "10%", "data": "textbookId", "title": "教材名称"},
                {"width": "8%", "data": "unitPrice", "title": "单价"},
                {"width": "7%", "data": "declareNum", "title": "预定数量"},
                {"width": "7%", "data": "boundPerson", "title": "圈订人"},
                {"width": "7%", "data": "textbookUser", "title": "教材使用者"},
                {"width": "7%", "data": "remark", "title": "备注"},
                // {"width": "7%", "data": "declareNum", "title": "申报数量"},
                // {"width": "8%", "data": "submitState", "title": "提交状态"},
                {
                    "width": "10%", "title": "操作", "render": function () {
                        return "<a id='editTextBookDeclare' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delTextBookDeclare' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id = data.id;
            var majorIdShow = data.majorIdShow;
            if (this.id == "editTextBookDeclare") {
                var personType = $("#personType").val();
                $("#dialog").load("<%=request.getContextPath()%>/textbook/editTextBookDeclare?id=" + id+"&personType="+personType);
                $("#dialog").modal("show");
            }
            if (this.id == "delTextBookDeclare") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "专业名称：" + majorIdShow + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/textbook/deleteTextBookDeclareById", {
                        id: id,
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        table.ajax.reload();
                    });
                })
            }
            if (this.id == "submit") {
                swal({
                    title: "您确定要提交吗?",
                    text: "提交之后将无法修改和删除，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "提交",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/textbook/submitTextBookDeclareById", {
                        id: id,
                        personType: "1"
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: msg.result
                        });
                        table.ajax.reload();
                    });
                })
            }
        });
    }
</script>
