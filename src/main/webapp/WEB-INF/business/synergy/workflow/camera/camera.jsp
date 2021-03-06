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
<style>
    @media screen and (max-width: 1050px){
        .tar{
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
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="rate1" type="date"
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
                                onclick="addCamera()">新增
                        </button>
                        <br>
                    </div>
                    <table id="zzTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_CAMERA_WF">
<input id="workflowCode" hidden value="T_BG_CAMERA_WF01">
<input id="businessId" hidden>
<script>
    var CameraTable;
    //主页面显示的条件
    $(document).ready(function () {
        CameraTable = $("#zzTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/camera/search',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                { "width": "10%", "data":"shootDate", "title": "拍摄时间"},
                {"width":"10%", "data":"shootingLocation", "title": "拍摄地点"},
                { "width":"10%", "data": "shootingMethod", "title": "拍摄方法"},
                { "width":"18%", "data": "machineNumber", "title": "摄像机机位数"},
                { "width": "11%", "data":"content", "title": "活动内容"},
                { "width":"9%", "data": "requestDept", "title": "申请部门"},
                { "width": "13%", "data":"requester", "title": "申请人"},
                { "width": "10%", "data":"requestDate", "title": "申请日期"},
                {"width": "8","title": "操作", "render": function () {return "<a id='editCamera' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='deleteCamera' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='submitCamera' class='icon-upload-alt' title='提交'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            "language": language
        });
        CameraTable.on('click', 'tr a', function () {
            //var data = roleTable.row(this.parent).data();
            var data = CameraTable.row($(this).parent()).data();
            var id = data.id;
            //修改
            if (this.id == "editCamera") {
                $("#dialog").load("<%=request.getContextPath()%>/camera/updateCameraById?id=" + id);
                $("#dialog").modal("show");
            }
            //删除
            if (this.id == "deleteCamera") {
                //if (confirm("确认要删除?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "活动内容："+data.content+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/camera/deleteCameraById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#zzTable').DataTable().ajax.reload();
                        }
                    })
                })
            }
            //提交
            if (this.id == "submitCamera") {
                $("#businessId").val(id);
                getAuditer();
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_CAMERA_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addCamera() {
        $("#dialog").load("<%=request.getContextPath()%>/camera/addCamera");
        $("#dialog").modal("show");
    }

    function editCamera(id) {
        $("#dialog").load("<%=request.getContextPath()%>/camera/updateCameraById?id=" + id);//从前台往后台传输数据 关联controller
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#rate1").val("");
        search();
    }

    function search() {
       var requestDate1 = $("#rate1").val();
        CameraTable.ajax.url("<%=request.getContextPath()%>/camera/getCameraList?requestDate="+requestDate1).load();
    }
    /*动态弹窗选择审批人*/
    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
    }
    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }
        }
        if (personId == '') {
            swal({title: '请选择人员！',type: "warning"});
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_BG_CAMERA_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    $("#dialog").modal("hide");
                    $('#zzTable').DataTable().ajax.reload();
                }
            }
        )
    }
</script>

