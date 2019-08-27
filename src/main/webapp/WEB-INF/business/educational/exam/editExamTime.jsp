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
            <span style="font-size: 14px;">新增</span>
        </div>
        <form id="form">
            <input name="id" value="${data.id}" hidden>
            <input name="examId" value="${empty id? data.examId:id}" hidden>
            <div class="modal-body clearfix">
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 开始时间
                        </div>
                        <div class="col-md-9">
                            <input type="time" value="${data.startTime}" name="startTime" class="required" msg="请填写开始时间！"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span> 结束时间
                        </div>
                        <div class="col-md-9">
                            <input type="time" value="${data.endTime}" name="endTime" class="required" msg="请填写结束时间！"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
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

    function save() {
        var flag = true;
        $("form select,form input").each(function (index, item) {
            if ($(item).hasClass("required") && !$(item).val()) {
                swal({
                    title: $(item).attr("msg"),
                    type: "info"
                });
                flag = false;
                return false;
            }
        });
        var startTime = $("input[name=startTime]").val();
        var endTime = $("input[name=endTime]").val();
        if (endTime < startTime) {
            swal({
                title: "结束时间不能大于开始时间！",
                type: "info"
            });
            flag = false;
            return false;
        }
        if (flag) {
            showSaveLoading();
            $.post("<%=request.getContextPath()%>/exam/updateExamTime", $("#form").serialize(), function (msg) {
                swal({
                    title: msg.msg,
                    type: msg.result
                }, function () {
                    $('#grid').DataTable().ajax.reload();
                    $("#dialog").modal('hide');
                });
                hideSaveLoading();
            })
        }

    }
</script>



