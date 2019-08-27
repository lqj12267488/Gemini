<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/9/21
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
                                <input id="selStudentName" type="text"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                入职时间：
                            </div>
                            <div class="col-md-2">
                                <input id="startTime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                离职时间：
                            </div>
                            <div class="col-md-2">
                                <input id="endTime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
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
                        <table id="schoolBurseGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var schoolBurseTable;

       /* "<a id='detail' class='icon-search' title='查看'></a>";*/
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XJXJCH", function (data) {
            addOption(data, 'selTitle');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'selGrantTime');
        });
        search();
        schoolBurseTable.on('click', 'tr a', function () {
            var data = schoolBurseTable.row($(this).parent()).data();
            var studentDormId = data.studentDormId;
            var studentId = data.studentId;
            if (this.id == "update") {
                $("#dialog").load("<%=request.getContextPath()%>/dormmanage/getStudentDormById?studentDormId=" + studentDormId);
                $("#dialog").modal("show");
            }
            if (this.id == "delete") {
                swal({
                    title: "您确定要学生："+studentId+"离开舍委会?",
                    text: "学生姓名："+studentId+"\n\n请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/dormmanage/studentdorm/delete?studentDormId=" + studentDormId, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#schoolBurseGrid').DataTable().ajax.reload();
                        }
                    })

                });

            }
            if (this.id == "detail") {
                $("#dialog").load("<%=request.getContextPath()%>/studentRewardPunish/schoolBurse/edit?id="+id+"&flag=1");
                $("#dialog").modal("show");
            }
        });
    })
    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/studentDormList/edit" );
        $("#dialog").modal("show");
    }
    function searchclear() {
        $("#selStudentName").val("");
        $("#startTime").val("");
        $("#endTime").val("");
        search();
    }
    function search() {
        var studentName = $("#selStudentName").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();

        if(endTime!=''){
            if(startTime>endTime){
                swal({
                    title: "入职时间必须早于离职时间！",
                    type: "info"
                });
                return;
            }
        }
        schoolBurseTable = $("#schoolBurseGrid").DataTable({
            "ajax": {
                "type":"post",
                "url": '<%=request.getContextPath()%>/dormmanage/studentDormListLog',
                "data":{
                    studentName: studentName,
                    startTime: startTime,
                    endTime: endTime
                }
            },
            "destroy": true,
            "columns": [
                {"data": "studentDormId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "studentId", "title": "学生姓名"},
                {"width":"8%","data": "departmentsId", "title": "系部"},
                {"width":"12%","data": "majorShow", "title": "专业"},
                {"width":"8%","data": "classId", "title": "班级"},
                {"width":"8%","data": "startTime", "title": "入职时间"},
                {"width":"8%","data": "endTime", "title": "离职时间"},
                {"width":"8%","data": "tel", "title": "电话"},
                {"width":"8%","data": "sexShow", "title": "性别"},
                {"width":"8%","data": "idcard", "title": "身份证号"},

            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
</script>


