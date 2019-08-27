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
            <span style="font-size: 14px;">${head}</span>
            <input id="resourceMajorId" hidden value="${data.resourceMajorId}"/>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业名称
                    </div>
                    <div class="col-md-9">
                        <input id="resourceMajorName" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="15" placeholder="最多输入15个字" value="${data.resourceMajorName}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>专业排序
                    </div>
                    <div class="col-md-9">
                        <input id="resourceMajorOrder" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="10" placeholder="最多输入10个字" value="${data.resourceMajorOrder}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学科名称
                    </div>
                    <div class="col-md-9">
                        <select id="resourceSubjectIdd" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark"
                               maxlength="150" placeholder="最多输入150个字" value="${data.remark}"/>
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
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " RESOURCE_SUBJECT_ID ",
                text: " RESOURCE_SUBJECT_NAME ",
                tableName: " ZYK_TYPE_SUBJECT ",
                where: " ",
                orderby: " order by LPAD(resource_SUBJECT_order,5,'0') "
            },
            function (data) {
                addOption(data, "resourceSubjectIdd",'${data.resourceSubjectId}');
            })

        if('${data.resourceMajorId}'!=""){
            $("#resourceSubjectId").attr('disabled','disabled');
        }
    });


    function save() {
        var resourceMajorId = $("#resourceMajorId").val();
        var resourceMajorName = $("#resourceMajorName").val();
        var resourceMajorOrder = $("#resourceMajorOrder").val();
        var resourceSubjectId = $("#resourceSubjectIdd").val();
        var remark = $("#remark").val();
        if (resourceMajorName == "" || resourceMajorName == undefined || resourceMajorName == null) {
            swal({title: "请填写专业名称！",type: "info"});
            return;
        }
        if (resourceSubjectId == "" || resourceSubjectId == undefined || resourceSubjectId == null) {
            swal({title: "请选择学科！",type: "info"});
            return;
        }
        var reg = new RegExp("^[1-9][0-9]*$");
        if (!reg.test(resourceMajorOrder)) {
            swal({title: "请填写数字！"});
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/resourceLibrary/typeMajor/saveResourceTypeMajor", {
            resourceMajorId:resourceMajorId,
            resourceMajorName:resourceMajorName,
            resourceMajorOrder:resourceMajorOrder,
            resourceSubjectId:resourceSubjectId,
            remark:remark,
        }, function (msg) {
            hideSaveLoading();
            swal({title: msg.msg,type: msg.result});
            $("#dialog").modal('hide');
            $('#tableMajor').DataTable().ajax.reload();
        })
    }
</script>



