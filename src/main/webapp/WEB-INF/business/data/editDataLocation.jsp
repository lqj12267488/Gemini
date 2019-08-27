<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<input id="id" hidden value="${dataLocation.locationId}">
<input id="pId" hidden value="${dataLocation.parentLocationId}">
<div class="col-md-12">
    <div class="block block-drop-shadow">
        <div class="header">
            <span style="font-size: 14px">${name}</span>
        </div>
        <div class="content controls" style="height: 80%">
            <div class="form-row">
                <div class="col-md-3 tar">
                   存放位置名称
                </div>
                <div class="col-md-9">
                    <input id="locationName" type="text"
                           class="validate[required,maxSize[20]] form-control"
                           value="${dataLocation.locationName}"/>
                </div>
            </div>
            <div class="form-row">
                <div style="text-align: center">
                    <button class="btn btn-default btn-clean" onclick="saveDataLocation()">保存</button>
                    <button class="btn btn-default btn-clean" onclick="deptObjhide()">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="pname" hidden value="${name}">
<script>
    function saveDataLocation() {
        if ($("#locationName").val() == ""  || $("#locationName").val() == null) {
            swal({
                title: "请填写名称！",
                type: "info"
            });
            return;
        }
        if ($("#locationName").val().length>50) {
            swal({
                title: "名称过长！",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/dataLocation/checkLocationName", {
            locationId: '${id}',
            locationName: $("#locationName").val(),
            parentLocationId: $("#pId").val()
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: "名称重复，请重新填写！", type: "error"});
            }
            else {

                $.post("<%=request.getContextPath()%>/dataLocation/updateDataLocation", {
                    locationId: $("#id").val(),
                    locationName: $("#locationName").val(),
                    parentLocationId: $("#pId").val()
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({title: msg.msg, type: "success"});
                        refreDataTree();
                    }
                })
            }
        })
    }
</script>