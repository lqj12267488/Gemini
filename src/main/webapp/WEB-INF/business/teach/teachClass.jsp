<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <form id="dataForm" method="post" enctype="multipart/form-data">
        <div class="modal-content block-fill-white">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span style="font-size: 14px;">新增</span>
                <input hidden name="id" id="id" value="${data.id}">
            </div>
            <div class="modal-body clearfix">
                <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>姓名
                        </div>
                        <div class="col-md-9">
                            <input id="teacherId" value="${data.nameShow}" keycode="${data.teacherId}"
                                   <c:if test="${flag == '1'}">readonly="readonly"</c:if>/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>班级
                        </div>
                        <div class="col-md-9">
                            <input id="classId" value="${data.classShow}" keycode="${data.classId}"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
                </button>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
                </button>
            </div>
        </div>
    </form>
</div>

<script>

    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/teach/getPerson", function (data) {
            $("#teacherId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherId").val(ui.item.label);
                    $("#teacherId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul);
            };
        });

        $.get("<%=request.getContextPath()%>/teach/getClasses", function (data) {
            $("#classId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#classId").val(ui.item.label);
                    $("#classId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul);
            };
        });
    });


    function save() {
        var id = $("#id").val();
        var teacherId = $("#teacherId").attr("keycode");
        var classId = $("#classId").attr("keycode");
        if (teacherId == "" || teacherId == undefined || teacherId == null) {
            swal({
                title: "请填写教师名称！",
                type: "info"
            });
            return;
        }
        if (classId == "" || classId == undefined || classId == null) {
            swal({
                title: "请选择班级！",
                type: "info"
            });
            return;
        }

        $.post("<%=request.getContextPath()%>/teach/saveTeachClass", {
            id: id,
            teacherId: teacherId,
            classId: classId
        }, function (data) {
            swal({
                title: data.msg,
                type: "info"
            });
            $("#dialog").modal('hide');
            $('#table').DataTable().ajax.reload();
        })
    }
</script>



