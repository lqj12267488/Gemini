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
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="messageId" hidden value="${data.messageId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        标题
                    </div>
                    <div class="col-md-9">
                        <input id="title" value="${data.title}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        内容
                    </div>
                    <div class="col-md-9">
                        <textarea id="message"  style="height: 200px"  class="validate[required,maxSize[1000]] form-control">${data.message}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        留言类型
                    </div>
                    <div class="col-md-9">
                        <select id="type" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        接收教师
                    </div>
                    <div class="col-md-9">
                        <select id="personId" />
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
</div>

<script>
    $(document).ready(function () {
//
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JZLY",function (data) {
            addOption(data,'type',${data.type});
        });

        $.post("<%=request.getContextPath()%>/core/parent/getTeacherList",
            function (data) {
                $("#personId").html("");
                if ('${data.personId}' === undefined)
                    $("#personId").append("<option value='' selected>请选择</option>")
                else
                    $("#personId").append("<option value=''>请选择</option>")
                $.each(data.data, function (index, content) {
                    if (content.teacherPersonId === '${data.personId}')
                        $("#personId").append("<option value='" + content.teacherPersonId+","+content.teacherDeptId + "' selected>" + content.teacherPersonName + "</option>")
                    else
                        $("#personId").append("<option value='" + content.teacherPersonId+","+content.teacherDeptId + "'>" + content.teacherPersonName + "</option>")
                })
                if (data.data.length == 0)
                    $("#personId").append("<option value=''>无数据</option>")
        });
    });


    function save() {
        var messageId = $("#messageId").val();
        var title = $("#title").val();
        var message = $("#message").val();
        var type = $("#type").val();
        var personId = $("#personId").val();
        if (title == "" || title == undefined || title == null) {
            swal({title: "请添加标题！",type: "info"});
            return;
        }
        if (message == "" || message == undefined || message == null) {
            swal({title: "请填写内容！",type: "info"});
            return;
        }
        if (type == "" || type == undefined || type == null) {
            swal({title: "请选择留言类型！",type: "info"});
            return;
        }
        if (personId == "" || personId == undefined || personId == null) {
            swal({title: "请选择接收教师！",type: "info"});
            return;
        }

        $.post("<%=request.getContextPath()%>/parent/saveParentMessage", {
            messageId:messageId,
            title:title,
            message:message,
            type:type,
            personId:personId,
        }, function (msg) {
            swal({title: msg.msg, type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#tableMessage').DataTable().ajax.reload();
            });
        })
    }
</script>



