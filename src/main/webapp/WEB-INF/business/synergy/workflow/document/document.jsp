<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 11:08
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
                        <button type="button" class="btn btn-default btn-clean" onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="documentGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_DOCUMENT_WF">
<input id="workflowCode" hidden value="T_BG_DOCUMENT_WF01">
<input id="businessId" hidden>
<script>
    var documentTable;
    $(document).ready(function () {
        search();

        documentTable.on('click', 'tr a', function () {
            var data = documentTable.row($(this).parent()).data();
            var id = data.id;
            var deviceList = data.requester;
            if (this.id == "editdocument") {
                $("#dialog").load("<%=request.getContextPath()%>/document/getDocumentById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "deldocument") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "申请人："+deviceList+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/document/deleteDocumentById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#documentGrid').DataTable().ajax.reload();
                        }
                    })

                });


            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_DOCUMENT_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/document/editDocument");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#date").val("");
        search();
    }
    function search() {
        var date = $("#date").val();

        if (date != "")
            date = date;

        documentTable = $("#documentGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/document/getDocumentList',
                "data": {
                    requestDate: date
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "9%","data": "requestDept", "title": "申请部门"},
                {"width": "9%","data": "requestDate", "title": "申请日期"},
                {"width": "9%","data": "requester", "title": "拟稿"},
                {"width": "9%","data": "fileTitle", "title": "文件标题"},
                {"width": "9%","data": "deliveryEmpIdShow", "title": "主送"},
                {"width": "9%","data": "makeEmpIdShow", "title": "抄送"},
                {"width": "9%","data": "secretClass", "title": "密级"},
                /*{"width": "9%","data": "title", "title": "标题"},*/
                {"width": "9%","data": "printingNumber", "title": "打印份数"},
                {"width": "9%","data": "symbol", "title": "文号"},
                {"width": "9%","title": "操作", "render": function () {return "<a id='editdocument' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='deldocument' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='submit' class='icon-upload-alt' title='提交'></a>";}}
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
        $("#saveBtn").attr("disabled",true);
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_BG_DOCUMENT_WF",
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
                    $('#documentGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
