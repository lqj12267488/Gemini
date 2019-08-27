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
                                <input id="rdate" type="date"
                                       class="validate[required,maxSize[100]] form-control" />
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchComputer()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclearComputer()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button  type="button" class="btn btn-default btn-clean" onclick="addComputer()">新增</button><br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="computerGrid" cellpadding="0" cellspacing="0" width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_COMPUTER_WF">
<input id="workflowCode" hidden value="T_BG_COMPUTER_WF01">
<input id="businessId" hidden>
<script>
    var computerTable;


    $(document).ready(function () {
        searchComputer();

        computerTable.on('click', 'tr a', function () {
            var data = computerTable.row($(this).parent()).data();
            var id = data.id;
            var reason = data.reason;
          if (this.id == "uComputer") {
                $("#dialog").load("<%=request.getContextPath()%>/computer/getComputerById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delComputer") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "申请事由："+reason+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/computer/deleteComputerById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#computerGrid').DataTable().ajax.reload();
                        }
                    })

                });

            }
            if (this.id == "submitComputer") {
                $("#businessId").val(id);
                getAuditerComputer();

            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_COMPUTER_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addComputer() {
        $("#dialog").load("<%=request.getContextPath()%>/computer/addComputer");
        $("#dialog").modal("show");
    }

    function getAuditerComputer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer");
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
                tableName: "T_BG_COMPUTER_WF",
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
                    $('#computerGrid').DataTable().ajax.reload();
                }
            })
    }

    function searchclearComputer() {
        $("#rdate").val("");
        searchComputer();
    }

    function searchComputer() {
        var v_requestdate = $("#rdate").val();
        if (v_requestdate != "") {
            v_requestdate = '%' + v_requestdate + '%';
        }

        computerTable = $("#computerGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/computer/searchComputer',
                "data": {
                    requestdate: v_requestdate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%", "data": "reason", "title": "申请事由"},
                {"data": "suppliesname", "visible": false},
                {"width": "15%","data": "suppliesnameShow", "title": "外设名称"},
                {"width": "15%", "data": "requestdept", "title": "申请部门"},
                {"width": "15%", "data": "manager", "title": "经办人"},
                {"width": "15%", "data": "requestdate", "title": "申请日期"},
                {"width": "15%", "data": "remark", "title": "备注"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uComputer' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delComputer' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='submitComputer' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

</script>
