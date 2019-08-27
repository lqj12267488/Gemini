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
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addDeviceUse()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="deviceUseGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_DEVICEUSE_WF">
<input id="workflowCode" hidden value="T_BG_DEVICEUSE_WF01">
<input id="businessId" hidden>
<script>
    var deviceUseTable;

    $(document).ready(function () {
/*
        $.get("/deviceUse/getDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("/deviceUse/getPerson", function (data) {
            $("#manager").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#manager").val(ui.item.label);
                    $("#manager").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })*/
        search();

        deviceUseTable.on('click', 'tr a', function () {
            var data = deviceUseTable.row($(this).parent()).data();
            var id = data.id;
            var deviceUseNameShow = data.deviceUseNameShow;
            if (this.id == "uDeviceUse") {
                $("#dialog").load("<%=request.getContextPath()%>/deviceUse/getDeviceUseById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delDeviceUse") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "设备名称："+deviceUseNameShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/deviceUse/deleteDeviceUseById?id="+id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#deviceUseGrid').DataTable().ajax.reload();
                        }
                    })
                });
                /*if (confirm("请确认是否要删除本条申请?")) {
                    $.get("/deviceUse/deleteDeviceUseById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#deviceUseGrid').DataTable().ajax.reload();
                        }
                    })
                }*/
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_DEVICEUSE_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addDeviceUse() {
        $("#dialog").load("<%=request.getContextPath()%>/deviceUse/editDeviceUse");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#date").val("");
        search();
    }
    function search(){
        var requestDate = $("#date").val();
        if (requestDate != "")
            requestDate = '%'+ requestDate +'%';
        deviceUseTable = $('#deviceUseGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/deviceUse/getDeviceUseList',
                "data": {
                    requestDate:requestDate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "deviceName", "visible": false},
                {"width": "16%","data": "deviceUseNameShow", "title": "设备名称"},
                {"width": "18%","data": "reason", "title": "申请事由"},
                {"width": "12%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "manager", "title": "经办人"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "18%","data": "remark", "title": "备注"},
                {
                    "width": "16%","title": "操作",
                    "render": function () {
                        return  "<a id='uDeviceUse' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delDeviceUse' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
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
                tableName: "T_BG_DEVICEUSE_WF",
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
                    $("#dialog").modal("hide");
                    $('#deviceUseGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
