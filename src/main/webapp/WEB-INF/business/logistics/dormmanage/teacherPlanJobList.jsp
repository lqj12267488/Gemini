<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
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
                            <div class="col-md-1 tar" style="width:100px">
                                接班时间：
                            </div>
                            <div class="col-md-2">
                                <input id="startTime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                交班时间：
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
                <div class="content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addExam()">新增排班
                        </button>
                        <br>
                    </div>
                    <table id="examTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var table;
    $(document).ready(function () {
        table = $("#examTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/dormmanage/teacherPlanJobList',
            },
            "destroy": true,
            "columns": [
                {"data": "teacherOrderId", "visible": false},
                {"data":"buildingName","title":"楼宇名称"},
                {"data":"teacherName","title":"老师姓名"},
                {"data":"teacherDept","title":"所在部门"},
                {"data":"tel","title":"电话"},
                {"data":"officeStartTime","title":"接班时间"},
                {"data":"officeEndTime","title":"交班时间"},
                {"data":"remark","title":"值班记录"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editExam("' + row.teacherOrderId + '","' +row.buildingName+ '","' +row.teacherName+ '")/>&ensp;&ensp;' +
                            '<span id="upload" onclick=upFile("'+row.teacherOrderId+'") class="icon-cloud-upload" title="上传附件"></span>&nbsp;&nbsp;&nbsp;'+
                            '<span class="icon-arrow-up" title="交班" onclick=shiftShift("' + row.teacherOrderId + '","' +row.buildingName+ '","' +row.teacherName+ '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delExam("' + row.teacherOrderId + '","' +row.buildingName+ '","' +row.teacherName+ '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/teacherPlanJob/edit")
        $("#dialog").modal("show")
    }

    function editExam(teacherOrderId,buildingName,teacherName) {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/getTeacherPlanJobById?teacherOrderId=" + teacherOrderId)
        $("#dialog").modal("show")
    }

    function delExam(teacherOrderId,buildingName,teacherName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "楼宇名称："+buildingName+"，教师姓名:"+teacherName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/dormmanage/teacherPlanJob/delete", {
                teacherOrderId: teacherOrderId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#examTable').DataTable().ajax.reload();
            });
        })
    }
    function searchclear() {
        $("#startTime").val("");
        $("#endTime").val("");
        table.ajax.url("<%=request.getContextPath()%>/dormmanage/teacherPlanJobList").load();
    }

    function search() {
        var starttime = $("#startTime").val();
        var endtime = $("#endTime").val();
        if(starttime!=''||endtime!=''){
            if(starttime!=''&&endtime!=''){
                if(endtime<starttime){
                    swal({
                        title: "开始时间必须早于结束时间！",
                        type: "info"
                    });
                    return;
                }
            }
            table.ajax.url("<%=request.getContextPath()%>/dormmanage/teacherPlanJobList?officeStartTime="+starttime+"&officeEndTime="+endtime).load();
        }
    }


    function shiftShift (teacherOrderId,buildingName,teacherName) {
        swal({
            title: "您确定要交班吗?",
            text: "楼宇名称："+buildingName+"，教师姓名:"+teacherName+"！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#3771dd",
            confirmButtonText: "确认交班",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/dormmanage/teacherPlanJob/shiftShiftById", {
                teacherOrderId: teacherOrderId
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                });
                $('#examTable').DataTable().ajax.reload();
            });
        })
    }
    function upFile(teacherOrderId) {
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + teacherOrderId + '&businessType=TEST&tableName=T_BG_NEWSDRAFT_WF');
        $('#dialogFile').modal('show');
    }

</script>