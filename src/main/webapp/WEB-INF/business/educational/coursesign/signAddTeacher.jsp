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
                        <input type="text" disabled value="${planName}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        课程名称
                    </div>
                    <div class="col-md-9">
                        <input id="courseName" type="text" disabled value="${term.courseName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>   开课学期
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
                        <input id="personId" type="text" disabled value="${personName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        部门
                    </div>
                    <div class="col-md-9">
                        <select id="deptId" disabled/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn"	 class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
    <input id="planId" hidden value="${term.planId}"/>
    <input id="detailsId" hidden value="${term.detailsId}"/>
    <input id="termId" hidden value="${term.id}"/>
    <input id="courseId" hidden value="${term.courseId}"/>
    <input id="deptIdValue" hidden value="${deptId}"/>
</div>

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data,"term");
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " dept_id",
                text: " dept_name ",
                tableName: "T_SYS_DEPT",
                where: " WHERE 1 = 1 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "deptId", '${deptId}');
            });
    });

    function save() {
        var planId = $("#planId").val();
        var detailsId = $("#detailsId").val();
        var termId = $("#termId").val();
        var courseId = $("#courseId").val();
        var courseName = $("#courseName").val();
        var term = $("#term option:selected").val();
        if(term == null || term ==""){
            swal({
                title: "请选择开课学期！",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/coursesign/saveCourseSign", {
            planId: planId,
            detailsId: detailsId,
            termId: termId,
            courseId: courseId,
            courseName: courseName,
            term: term,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



