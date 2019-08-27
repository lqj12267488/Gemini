<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/7/25
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
                            <div class="col-md-1 tar">
                                拟稿日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
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
                                onclick="addDraftPaper()">新增
                        </button>
                        <br>
                    </div>
                    <table id="draftTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_DRAFTPAPER_WF">
<input id="workflowCode" hidden value="T_BG_DRAFTPAPER_WF01">
<input id="businessId" hidden>
<script>
    var draftTable;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE DEPT_TYPE =8 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "departmentsId");
            });
        draftTable = $("#draftTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/draftPaper/getDraftPaperList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "title", "title": "标题"},
                {"width": "8%", "data": "paperNumber", "title": "文号"},
                {"width": "10%", "data": "draftDept", "title": "拟稿人部门"},
                {"width": "10%", "data": "drafter", "title": "拟稿人"},
                {"width": "10%", "data": "draftDate", "title": "拟稿日期"},
                {"width": "10%", "data": "checkerShow", "title": "核稿人"},
                {"width": "10%", "title": "操作", "render": function ()
                    {return "<a id='editDraftPaper' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='delDraftPaper' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='submit' class='icon-upload-alt' title='提交'></a>";}}
            ],
            "dom": 'rtlip',
            "language": language
        });
        draftTable.on('click', 'tr a', function () {
            var data = draftTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "editDraftPaper") {
                $("#dialog").load("<%=request.getContextPath()%>/draftPaper/getDraftPaperById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delDraftPaper") {
                //if (confirm("请确认是否要删除本条申请?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "标题："+data.title+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/draftPaper/deleteDraftPaperById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#draftTable').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_DRAFTPAPER_WF');
                $('#dialogFile').modal('show');
            }
        });

    })
    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
    }
    function addDraftPaper() {
        $("#dialog").load("<%=request.getContextPath()%>/draftPaper/editDraftPaper");
        $("#dialog").modal("show");
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
                tableName: "T_BG_DRAFTPAPER_WF",
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
                    $('#draftTable').DataTable().ajax.reload();
                }
            })
    }




    function searchclear() {
        $("#date").val("");
        draftTable.ajax.url("<%=request.getContextPath()%>/draftPaper/getDraftPaperList").load();
    }

    function search() {
        var date = $("#date").val();
        if (date == "") {

        } else{
            draftTable.ajax.url("<%=request.getContextPath()%>/draftPaper/getDraftPaperList?draftDate="+date).load();
        }
    }


</script>