<%--资产报废申请
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
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
                                教师名称：
                            </div>
                            <div class="col-md-2">
                                <input id="rewordPersonId" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="searchAssets()">
                                    查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                    清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addRewards()">
                            新增</button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="otherWorkloadGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_JW_TEACHER_OTHER_WORKLOAD">
<input id="businessId" hidden>
<script>
    var roleTable;

    $(document).ready(function () {
        searchAssets();

        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var id = data.id;
            var teacherId =data.teacherId;
            if (this.id == "uRole") {
                $("#dialog").load("<%=request.getContextPath()%>/otherWorkload/editOtherWorkload?id=" + id +"&type=1");
                $("#dialog").modal("show");
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_JW_TEACHER_OTHER_WORKLOAD');
                $('#dialogFile').modal('show');
            }
            if (this.id == "delRole") {
                swal({
                    title: "请确认是否要删除本条信息?",
                    text: "教师名称："+teacherId+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/otherWorkload/deleteOtherWorkloadById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#otherWorkloadGrid').DataTable().ajax.reload();

                    });
                })
            }
        });
    })
    /*添加*/
    function addRewards() {
        $("#dialog").load("<%=request.getContextPath()%>/otherWorkload/addOtherWorkload");
        $("#dialog").modal("show");
    }
    /*清空*/
    function searchclear() {
        $("#rewordPersonId").val("");
        searchAssets();
    }
    /*查询*/
    function searchAssets() {
        var rewordPersonId=$("#rewordPersonId").val();
        if(rewordPersonId!=""){
            rewordPersonId=rewordPersonId;
        }
        roleTable = $("#otherWorkloadGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/otherWorkload/otherWorkloadAction',
                "data": {
                    teacherId: rewordPersonId
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width":"12%","data": "teacherId", "title": "教师姓名"},
                {"width":"12%","data": "deptId", "title": "所属系部"},
                {"width":"12%","data": "workContent", "title": "工作内容"},
                {"width":"12%","data": "time", "title": "工作时间"},
                {"width":"12%","data": "classHours", "title": "课时数"},
                {"width":"12%","data": "workload", "title": "工作量"},
                {"width":"12%", "data": "fileNumber", "title": "文件数量"},
                {"width":"10%","title": "操作","render": function (data, type, row)
                    {
                        var html = "<a id='uRole' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delRole' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            '<span class="icon-download" title="下载" onclick=upload("' + row.id + '")></span>&ensp;&ensp;';

                        return html;
                    }
                }
            ],
            "columnDefs": [{
                "orderable": false
            }],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
    function upload(id){
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + id + '&businessType=TEST&tableName=T_JW_TEACHER_OTHER_WORKLOAD');
        $('#dialogFile').modal('show');
    }
    function reloadFileNumber() {
        $('#otherWorkloadGrid').DataTable().ajax.reload();
    }
</script>

