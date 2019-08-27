<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/8
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ include file="/WEB-INF/common/treeSelect.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">选择办理人</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        办理人
                    </div>
                    <div id="select" class="col-md-9">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean"
                    onclick="audit()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean"
                    data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var term = $("#termWorkflow").val();
        if (term==undefined||term==''){
            term==null;
        }

        $.post("<%=request.getContextPath()%>/getAuditer", {
            tableName: $("#tableName").val(),
            workflowCode: $("#workflowCode").val(),
            businessId: $("#businessId").val(),
            term: term
        }, function (data) {
            if (data.nodeType == 0) {
                $("#select").append("<select id='personId'></select>");
                addOption(data.emps, 'personId');
            } else {
                var doc = '<input id="name"/>' +
                    '<div id="menuContent" class="menuContent">' +
                    '<ul id="tree" class="ztree"></ul></div>' +
                    ' <input id="personIds" hidden/>';
                $("#select").append(doc);
                initSelectTreeByData(data.emps, "tree", "name", "personIds");
            }
        })
    })

    function chachAll() {
        $("#all").click(function () {
            if (this.checked) {
                $("#list :checkbox").prop("checked", true);
            } else {
                $("#list :checkbox").prop("checked", false);
            }
        });
    }
</script>
