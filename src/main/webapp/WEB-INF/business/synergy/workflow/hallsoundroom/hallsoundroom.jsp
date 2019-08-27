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
                                <input id="rdate" type="date"
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
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addHallsoundroom()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="hallsoundroomGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_HALLSOUNDROOM_WF">
<input id="workflowCode" hidden value="T_BG_HALLSOUNDROOM_WF01">
<input id="businessId" hidden>
<script>
    var hallsoundroomTable;

    $(document).ready(function () {
        search();
        hallsoundroomTable.on('click', 'tr a', function () {
            var data = hallsoundroomTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "uHallsoundroom") {
                $("#dialog").load("/hallsoundroom/getHallsoundroomById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delHallsoundroom") {
                if (confirm("确定要删除此条数据?")) {
                    $.get("/hallsoundroom/deleteHallsoundroomById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            alert(msg.msg);
                            $('#hallsoundroomGrid').DataTable().ajax.reload();
                        }
                    })
                }
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();

            }
            if (this.id == "upload"){
                $('#dialogFile').load('/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_HALLSOUNDROOM_WF');
                $('#dialogFile').modal('show');
            }
        });
    })

    function addHallsoundroom() {
        $("#dialog").load("/hallsoundroom/addHallsoundroom");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#rdate").val("");
        search();
    }

    function search() {
        var searc_rdate = $("#rdate").val();
        if (searc_rdate != "") {
            searc_rdate = '%' + searc_rdate + '%';
        }
        hallsoundroomTable = $("#hallsoundroomGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '/hallsoundroom/searchhallsoundroom',
                "data": {
                    requestdate: searc_rdate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "15%","data": "meetingcontent", "title": "会议内容"},
                {"width": "13%","data": "starttime", "title": "使用开始时间"},
                {"width": "13%","data": "endtime", "title": "使用结束时间"},
                {"width": "11%","data": "usedevice", "title": "使用设备"},
                {"width": "11%","data": "requestdept", "title": "申请部门"},
                {"width": "11%","data": "requester", "title": "申请人"},
                {"width": "15%","data": "requestdate", "title": "申请日期"},
                {
                    "width": "11%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='uHallsoundroom' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delHallsoundroom' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
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
        $("#dialog").modal().load("/toSelectAuditer")
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
        $.post("/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_BG_HALLSOUNDROOM_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    alert(msg.msg);
                    $("#dialog").modal("hide");
                    $('#hallsoundroomGrid').DataTable().ajax.reload();
                }
            })
    }
</script>
