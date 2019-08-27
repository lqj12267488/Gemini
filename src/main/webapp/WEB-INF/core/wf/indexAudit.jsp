<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/5/11
  Time: 14:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header" style="height: 6%">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="backIndex()">
                &times;
            </button>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="auditTable">

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="backIndex()">关闭
            </button>
        </div>
    </div>
</div>
<script>
    function addEventTest() {
        plus.key.addEventListener("backbutton",function(){
            alert( "BackButton Key pressed!" );
        });
    }
    $(document).ready(function () {
        $("#auditTable").load("<%=request.getContextPath()%>/toAudit", {
            url: '${url}',
            tableName: '${tableName}',
            businessId: '${businessId}',
            flag:'${flag}'
        }, function () {
            $("#back").hide();
        })

    })
    function backIndex() {
        window.location.reload();
    }
</script>
