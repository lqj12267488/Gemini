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
                                报修物品名称：
                            </div>
                            <div class="col-md-2">
                                <input id="rname" type="text"
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
                                onclick="addRepair()">新增
                        </button>
                        <br>
                    </div>
                    <table id="repairTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="repairID" hidden value="${repair.repairID}">
<input id="pID" hidden value="${repair.creator}">
<script>
    var repairTable;
    //主页面显示的条件
    $(document).ready(function () {
        repairTable = $("#repairTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repair/search',
            },
            "destroy": true,
            "columns": [
                {"data": "repairID", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "repairType", "visible": false},
                {"width": "10%", "data": "repairTypeShow", "title": "报修种类"},
                /*{"width": "9%", "data": "assetsID", "title": "资产编号"},*/
                /*{"width": "8%", "data": "position", "title": "所在位置"},*/
                {"width": "9%", "data": "dept", "title": "所在部门"},
                {"width": "9%", "data": "itemNameShow", "title": "报修物品名称"},
                {"width": "10%", "data": "repairAddress", "title": "维修地址"},
                {"width": "9%", "data": "faultDescription", "title": "故障描述"},
                {"width": "9%", "data": "contactNumber", "title": "联系人电话"},
                /*{ "width": "7%", "data":"repairmanID", "title": "维修员ID"},*/
                /* { "width": "6%", "data":"repairmanPersonID", "title": "维修员人员ID"},
                 { "width": "6%", "data":"repairmanDeptID", "title": "维修员部门ID"},*/
                /*{ "width": "7%", "data":"repairResult", "title": "维修结果说明"},*/
                {"width": "9%", "data": "requestFlag", "title": "请求状态"},
                {"width": "9%", "data": "submitTime", "title": "报修时间"},
                {"width": "9%", "data": "feedbackFlag", "title": "完成时间"},
                {"width": "9%", "data":"checkFlag", "title": "回捡状态"},
                /*{ "width": "5%", "data":"checker", "title": "回检员ID"},
                { "width": "5%", "data":"checkerDept", "title": "回检员部门ID"},
                { "width": "5%", "data":"checkFlag", "title": "回检状态"},
                { "width": "5%", "data":"checkResult", "title": "回检结果"},*/
                {
                    "width": "9%", "title": "操作", "render": function () {
                    return "<a id='editRepair' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='deleteRepair' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='submitRepair' class='icon-upload-alt' title='提交'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='feedback' class='icon-reply-all' title='申请人反馈'></a>&nbsp;&nbsp;&nbsp;";
                }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            "language": language
        });
        repairTable.on('click', 'tr a', function () {
            var data = repairTable.row($(this).parent()).data();
            var repairID = data.repairID;
            var creator = data.creator;
            var itemName = data.itemName;
            var loginID = $("#pID").val();
            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + repairID + '&businessType=TEST&tableName=T_ZW_REPAIR');
                $('#dialogFile').modal('show');
            }
            //修改
            if (this.id == "editRepair") {
                $.post("<%=request.getContextPath()%>/repair/checkDelFile", {
                    repairID: repairID
                }, function (msg) {
                    if (msg.status != 1) {
                        swal({
                            title: "该申请已经提交不能修改！",
                            type: "error"
                        });
                    } else {
                        $("#dialog").load("<%=request.getContextPath()%>/repair/editRepairById?id=" + repairID);
                        $("#dialog").modal("show");
                    }
                })
            }
            //删除
            if (this.id == "deleteRepair") {
                //if (confirm("确认要删除?")) {
                $.post("<%=request.getContextPath()%>/repair/checkDelFile", {
                    repairID: repairID
                }, function (msg) {
                    if (msg.status != 1) {
                        swal({
                            title: "该申请已经提交不能删除！",
                            type: "error"
                        });
                    } else {
                        swal({
                            title: "您确定要删除本条信息?",
                            text: "报修物品：" + data.itemNameShow + "\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "删除",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/repair/deleteRepairById?id=" + repairID, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    //alert(msg.msg);
                                    $('#repairTable').DataTable().ajax.reload();
                                }
                            })
                        })
                    }
                })
            }
            //提交
            if (this.id == "submitRepair") {
                if (data.requestFlag == "未提交") {
                    swal({
                        title: "您确定要提交本条信息?",
                        text: "报修物品：" + data.itemNameShow,
                        type: "warning",
                        showCancelButton: true,
                        cancelButtonText: "取消",
                        confirmButtonColor: "green",
                        confirmButtonText: "提交",
                        closeOnConfirm: false
                    }, function () {
                        $.post("<%=request.getContextPath()%>/repair/submitRepair", {
                            repairID: repairID
                        }, function (msg) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#repairTable').DataTable().ajax.reload();

                        });

                    });
                    /*if (confirm("您确定要提交本条信息?")) {
                        $.get("/repair/submitRepair?repairID=" + repairID, function (msg) {
                            if (msg.status == 1) {
                                alert(msg.msg);
                                $('#repairTable').DataTable().ajax.reload();
                            }
                        })
                    }*/
                }
                else {
                    swal({
                        title: "此维修任务已提交,不可重复提交！",
                        type: "error"
                    });
                    return;
                }
            }
            if (this.id == "feedback") {
                if (data.requestFlag == "维修完成") {
                    if (data.feedbackFlag == "满意" || data.feedbackFlag == "不满意") {
                        swal({
                            title: "此任务已反馈，不可重复反馈！",
                            type: "error"
                        });
                        return;
                    }
                    else {
                        if (creator == loginID) {
                            $("#dialog").load("<%=request.getContextPath()%>/repair/feedBack?repairID=" + repairID);
                            $("#dialog").modal("show");
                        }
                        else {
                            swal({
                                title: "您不是申请人，不可反馈！",
                                type: "error"
                            });
                        }
                    }
                }
                else {
                    swal({
                        title: "此任务还未维修完成，不可反馈！",
                        type: "error"
                    });
                    return;
                }
            }
        });
    })

    function addRepair() {
        $("#dialog").load("<%=request.getContextPath()%>/repair/addRepair");
        $("#dialog").modal("show");
    }

    function editRepair(repairID) {
        $("#dialog").load("<%=request.getContextPath()%>/repair/editRepairById?id=" + repairID);//从前台往后台传输数据 关联controller
        $("#dialog").modal("show");
    }

    function searchclear() {
        $("#rname").val("");
        $("#name").val("")
        search();
    }

    function search() {
        repairTable.ajax.url("<%=request.getContextPath()%>/repair/search?itemName=" + $("#rname").val()).load();
    }
</script>

