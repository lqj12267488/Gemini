<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
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
                                系部：
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSel" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                入学年份：
                            </div>
                            <div class="col-md-2">
                                <select id="yearSel" class="js-example-basic-single"></select>
                            </div>
                            <div class="col-md-1 tar">
                                班级名称：
                            </div>
                            <div class="col-md-2">
                                <input id="classNameSel" type="text" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <%--<div class="col-md-1 tar">
                                专业类型
                            </div>
                            <div class="col-md-2">
                                <select id="majorTypeSel" class="js-example-basic-single"></select>
                            </div>--%>
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
                                onclick="addClass()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="classGrid" cellpadding="0" cellspacing="0"
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
    var classTable;

    $(document).ready(function () {
       $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsIdSel");
        });
        //入学年份 year
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ND", function (data) {
            addOption(data, 'yearSel');
        });
        search();
        classTable.on('click', 'tr a', function () {
            var data = classTable.row($(this).parent()).data();
            var classId = data.classId;
            var className = data.className;
            if (this.id == "updateClass") {
                $("#dialog").load("<%=request.getContextPath()%>/classManagement/updateClass?classId=" + classId);
                $("#dialog").modal("show");
            }
            if (this.id == "delClass") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "班级名称："+className+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {

                    $.get("<%=request.getContextPath()%>/classManagement/delClass?classId=" + classId, function (msg) {
                        if (msg.status == 0) {
                            swal({
                                title: msg.msg,
                                type: msg.result
                            });
                        }else{
                            swal({
                                title: msg.msg,
                                type: msg.result
                            });
                            $('#classGrid').DataTable().ajax.reload();
                        }
                    })
                });
               /* if (confirm("确定要删除" + data.className + "?")) {
                    $.get("/classManagement/delClass?classId=" + classId, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#classGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
        });
    })

    function addClass() {
        $("#dialog").load("<%=request.getContextPath()%>/classManagement/addClass");
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#departmentsIdSel option:selected").val("");
        $("#departmentsIdSel").val("");
        $("#yearSel option:selected").val("");
        $("#yearSel").val("");
        $("#classNameSel").val("");

        search();
    }

    function search() {

        var classNameSel = $("#classNameSel").val();
        if (classNameSel != "")
            classNameSel = '%' + classNameSel + '%';

        classTable = $("#classGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/classManagement/getclassList',
                "data": {
                    departmentsId: $("#departmentsIdSel option:selected").val(),
                    year:  $("#yearSel option:selected").val(),
                    className:classNameSel,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "classId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "20%", "data": "className", "title": "班级名称"},
                {"width": "10%", "data": "year", "title": "入学年份"},
                {"width": "10%", "data": "departmentsIdShow", "title": "系部"},
                {"width": "10%", "data": "classTypeShow", "title": "班级类型"},
                {"width": "10%", "data": "roomId", "title": "班级教室"},
                {"width": "10%", "data": "majorCodeShow", "title": "专业"},
                {"width": "10%", "data": "headTeacherShow", "title": "班主任"},
                {"width": "10%", "data": "studyTypeShow", "title": "学习形式"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='updateClass' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delClass' class='icon-trash' title='删除'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>