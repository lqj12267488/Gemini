<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/24
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<
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
            <span style="font-size: 14px;">签课</span>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        开课计划
                    </div>
                    <div class="col-md-9">
                        <input type="text" disabled value="${sign.planId}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <input id="courseName" type="text" disabled value="${sign.courseName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>开课学期
                    </div>
                    <div class="col-md-9">
                        <select id="term" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教师
                    </div>
                    <div class="col-md-9">
                        <input id="personId" type="text" disabled value="${sign.personId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        部门
                    </div>
                    <div class="col-md-9">
                        <input id="deptId" type="text" disabled value="${sign.deptId}"/>
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
    <input id="signId" hidden value="${sign.signId}"/>
    <input id="termVal" hidden value="${sign.termValue}"/>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data,"term",$("#termVal").val());
        });
    });

    function save() {
        var signId = $("#signId").val();
        var term = $("#term option:selected").val();
        if(term == null || term ==""){
            swal({
                title: "请选择开课学期！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/coursesign/updateCourseSign", {
            signId: signId,
            term: term,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#signList').DataTable().ajax.reload();
        })
    }
</script>



