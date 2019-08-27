<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${arrayClassCoursePlan.arrayClassId}">
            <input id="planId" hidden value="${arrayClassCoursePlan.planId}">
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学年
                    </div>
                    <div class="col-md-9">
                        <select id="a_schoolYear" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="a_term" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        教学计划
                    </div>
                    <div class="col-md-9">
                        <select id="a_coursePlan" class="js-example-basic-single"></select>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/arrayClass/getPlanId", function (data) {
            addOption(data, 'a_coursePlan', '${arrayClassCoursePlan.planId}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KKJHXQ", function (data) {
            addOption(data, 'a_term', '${arrayClassCoursePlan.term}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=KKJHXN", function (data) {
            addOption(data, 'a_schoolYear', '${arrayClassCoursePlan.schoolYear}');
        });
    })

    function save() {
        if ($("#a_coursePlan option:selected").val() == "" || $("#a_coursePlan option:selected").val() == undefined) {
            swal({
                title: "请选择要关联的教学计划！",
                type: "info"
            });
            return;
        }
        if ($("#planId").val() == "" || $("#planId").val() == null) {
            $.post("<%=request.getContextPath()%>/arrayClass/saveCoursePlanForArrayClass", {
                arrayClassId: $("#id").val(),
                planId: $("#a_coursePlan option:selected").val(),
                term: $("#a_term option:selected").val(),
                schoolYear: $("#a_schoolYear option:selected").val()
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    $('#arrayClassGrid').DataTable().ajax.reload();
                }
            })
        } else {
            $.post("<%=request.getContextPath()%>/arrayClass/saveCoursePlanForArrayClass", {
                arrayClassId: $("#id").val(),
                planId: $("#a_coursePlan option:selected").val(),
                term: $("#a_term option:selected").val(),
                schoolYear: $("#a_schoolYear option:selected").val()
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    $('#arrayClassGrid').DataTable().ajax.reload();
                }
            })
        }

    }

</script>


