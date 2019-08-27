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
                                开始时间：
                            </div>
                            <div class="col-md-2">
                                <input id="startTime" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar" style="width:100px">
                                结束时间：
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
                "url": '<%=request.getContextPath()%>/dormmanage/studentPlanJobList',
            },
            "destroy": true,
            "columns": [
                {"data": "studentOrderId", "visible": false},
                {"data":"buildingName","title":"楼宇名称"},
                {"data":"studentName","title":"学生姓名"},
                {"data":"officeStartTime","title":"开始日期"},
                {"data":"officeEndTime","title":"结束日期"},
                {"data":"tel","title":"联系电话"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=editExam("' + row.studentOrderId + '","' +row.buildingName+ '","' +row.studentName+ '")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=delExam("' + row.studentOrderId + '","' +row.buildingName+ '","' +row.studentName+ '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            "language": language
        });
    })

    function addExam() {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/studentPlanJob/edit")
        $("#dialog").modal("show")
    }

    function editExam(studentOrderId,buildingName,studentName) {
        $("#dialog").load("<%=request.getContextPath()%>/dormmanage/getStudentPlanJobById?studentOrderId=" + studentOrderId)
        $("#dialog").modal("show");
    }

    function delExam(studentOrderId,buildingName,studentName) {
        swal({
            title: "您确定要删除本条信息?",
            text: "楼宇名称："+buildingName+"，学生姓名:"+studentName+"\n\n删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/dormmanage/studentPlanJob/delete", {
                studentOrderId: studentOrderId
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
        table.ajax.url("<%=request.getContextPath()%>/dormmanage/studentPlanJobList").load();
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
            table.ajax.url("<%=request.getContextPath()%>/dormmanage/studentPlanJobList?officeStartTime="+starttime+"&officeEndTime="+endtime).load();
        }
    }


</script>