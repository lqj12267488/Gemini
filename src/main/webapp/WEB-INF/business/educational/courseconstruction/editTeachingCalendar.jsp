<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="                                                   font-size: 14px;">${head}</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 学期
                    </div>
                    <div class="col-md-9">
                        <select id="term"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 系部
                    </div>
                    <div class="col-md-9">
                        <select id="deptId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 上传人
                    </div>
                    <div class="col-md-9">
                        <input id="creator" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字" value="${data.creator}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 上传时间
                    </div>
                    <div class="col-md-9">
                        <input id="createTime" type="date" value="${data.time}">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>

    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'term', '${data.term}');
        });
        $.get("<%=request.getContextPath()%>/common/getDepartments", function (data) {
            addOption(data, 'deptId', '${data.deptId}');
        });
    });

    function save() {

        var id = $("#id").val();
        var creator = $("#creator").val();
        var createTime = $("#createTime").val();
        var term = $("#term").val();
        var deptId = $("#deptId").val();

        if (term == "" || term == undefined || term == null) {
            swal({
                title: "请选择学期!",
                type: "info"
            });
            return;
        }
        if (deptId == "" || deptId == undefined || deptId == null) {
            swal({
                title: "请选择系部!",
                type: "info"
            });
            return;
        }
        if (creator == "" || creator == undefined || creator == null) {
            swal({
                title: "请填写创建人!",
                type: "info"
            });
            return;
        }
        if (createTime == "" || createTime == undefined || createTime == null) {
            swal({
                title: "请填写创建时间!",
                type: "info"
            });
            return;
        }

        showSaveLoading();

        $.post("<%=request.getContextPath()%>/courseconstruction/saveTeachingCalendar", {
            id: id,
            creator: creator,
            time: createTime,
            term: term,
            deptId: deptId
        }, function (msg) {
            swal({
                title: msg.msg,
                type: msg.result
            });
            hideSaveLoading();
            if (msg.status == 1) {
                return;
            } else {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            }
        })
    }
</script>



