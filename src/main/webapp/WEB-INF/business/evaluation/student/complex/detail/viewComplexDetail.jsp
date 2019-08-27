<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<div class="modal-dialog" id="modaldialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">&nbsp;</h4>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            考评子项名称
                        </div>
                        <div class="col-md-9">${ecDetail.taskShowName}
                            <%--<input id="taskShowName" type="text" />--%>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            权重
                        </div>
                        <div class="col-md-9">${ecDetail.weights}
                            <%--<input id="weights" type="text" />--%>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            子考评原总分
                        </div>
                        <div class="col-md-9">${ecDetail.score}
                            <%--<input id="weights" type="text" />--%>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            考评任务
                        </div>
                        <div class="col-md-9" id="taskNameList">

                            <%--<div>
                                <input id="itemTaskShow" type="text" onclick="showTree()" />
                            </div>
                            <div id="menuContent" class="menuContent">
                                <ul id="itemTaskTree" class="ztree"></ul>
                            </div>
                            <input id="itemTask" type="hidden" />--%>
                        </div>
                    </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input type="hidden" id="taskName" value="${ecDetail.taskName}">
    <input type="hidden" id="complexTaskId" value="${complexTaskId}">
    <input type="hidden" id="term" value="${term}">
</div>
<script>
    $(document).ready(function () {
        var taskName = $("#taskName").val() ;
        var list =taskName.split(",");
        var htm ="";
        for (i=0;i<list.length ;i++ )
        {
            htm = htm+'<div class="col-md-12">'+list[i]+'</div>';
        }
        $("#taskNameList").html(htm);
    });
</script>
