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
            <span style="font-size: 14px;">${r'${head}'}&nbsp;</span>
            <input id="${primary}" hidden value="${r'${data.'}${primary}}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
            <#list queryMapList as col>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>${col.comments}
                    </div>
                    <div class="col-md-9">
                        <#if col.dic??>
                        <select id="${col.queryCol}Edit"/>
                        <#else>
                        <input id="${col.queryCol}Edit" value="${col.edit}"/>
                        </#if>
                    </div>
                </div>
            </#list>
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
 <#list queryMapList as col>
     <#if col.dic??>
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=${col.dic}", function (data) {
                addOption(data, '${col.queryCol}Edit','${col.edit}');
            });
     </#if>
 </#list>
    });

    function save() {
        <#list queryMapList as col>
        if ($("#${col.queryCol}Edit").val() == "" || $("#${col.queryCol}Edit").val() == undefined || $("#${col.queryCol}Edit").val() == null) {
            swal({
            <#if col.dic??>
                title: "请选择${col.comments}！",
            <#else >
                title: "请填写${col.comments}！",
            </#if>
                type: "warning"
            });
            return;
        }
        </#list>
         <#--${save}-->
        $.post("<%=request.getContextPath()%>${url}/save${beanName?cap_first}", {
            ${primary}: "${r'${data.'}${primary}}",
        <#list queryMapList as col>
            ${col.queryCol}: $("#${col.queryCol}Edit").val(),
        </#list>
        <#--${ajax}-->
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>



