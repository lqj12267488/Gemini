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
            <h4 class="modal-title">分组授权管理</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" id="check">
<%--
                <div class="form-row">
                    <c:forEach items="${roleList}" var="role">
                        <input type="checkbox" id="${role.roleid}" />${role.rolename}<br/>
                    </c:forEach>
                </div>
--%>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button"  id="saveBtn"	class="btn btn-success btn-clean" onclick="saveClass()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="groupId" hidden value="${groupId}">

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        //  groupRoleList
        var roleList = ${roleList};
        var groupRoleList = ${groupRoleList};
        var htm ='';
        $.each(roleList, function (index, content) {
            htm += '<div class="col-md-1"><input type="checkbox" name="checkbox" value="'+content.roleid+'" /></div><div class="col-md-5">'+content.rolename+'<br/> </div>';
        })
        $("#check").html('<div class="form-row">'+htm+'</div>');
        $.each(groupRoleList, function (index, content) {
            $("input:checkbox[value='"+content.roleId+"']").attr('checked','true');
        })

    });

    function saveClass() {
        var roleId ="";
        $.each($('input:checkbox:checked'),function(){
            if(roleId =="")
                roleId += $(this).val();
            else
                roleId +=',' + $(this).val();
        });
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/commonGroup/saveRole", {
            roleId :roleId,
            groupId: $("#groupId").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $("#commonGroupGrid").DataTable().ajax.reload();
            }
        })
    }

</script>