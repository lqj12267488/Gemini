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
            <span style="font-size: 14px;">查看签课</span>
        </div>
        <div class="modal-body clearfix">
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
                        <input type="text" disabled value="${sign.courseName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        开课学期
                    </div>
                    <div class="col-md-9">
                        <input type="term" disabled value="${sign.term}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教师
                    </div>
                    <div class="col-md-9">
                        <input type="text" disabled value="${sign.personId}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        部门
                    </div>
                    <div class="col-md-9">
                        <input type="text" disabled value="${sign.deptId}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <%--<button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>--%>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
    <input id="signId" hidden value="${sign.signId}"/>
</div>

<script>

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
        $.post("<%=request.getContextPath()%>/courseplan/saveCourseSign", {
            planId: planId,
            detailsId: detailsId,
            termId: termId,
            courseId: courseId,
            courseName: courseName,
            term: term,
        }, function (msg) {
            swal({title: msg.msg, type: "success"});
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



