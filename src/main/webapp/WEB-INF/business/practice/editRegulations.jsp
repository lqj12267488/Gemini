<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%--新增页面--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="regulationsid" hidden value="${regulations.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        学期
                    </div>
                    <div class="col-md-9">
                        <select id="f_semester" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="departmentId" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="majorId"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        上传人
                    </div>
                    <div class="col-md-9">
                        <input id="f_uploadPerson" type="text" readonly="readonly" value="${regulations.uploadPerson}"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        上传时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_uploadTime" type="datetime-local"
                               class="validate[required,maxSize[20]] form-control"
                               value="${regulations.uploadTime}"/>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'f_semester','${regulations.semester}');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"dept_id",
            text:"dept_name",
            tableName:"T_SYS_DEPT",
            where:"WHERE dept_type = 8 ",
            orderBy:""
        }, function (data) {
            addOption(data, 'departmentId','${regulations.departmentId}');
        });
        $("#departmentId").change(function () {
            if($("#departmentId").val() != null){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"WHERE departments_id = '" + $("#departmentId").val() +"' ",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'majorId');
                });
            }

        })

        if("" != '${regulations.majorId}' ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"",
                    orderBy:""
                }
                , function (data) {
                    addOption(data, 'majorId','${regulations.majorId}');
                });
        }
    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_semester").val() == "" || $("#f_semester").val() == "0" || $("#f_semester").val() == undefined) {
            swal({
                title: "请选择学期！",
                type: "info"
            });
            return;
        }
        if ($("#departmentId").val() == "" || $("#departmentId").val() == "0") {
            swal({
                title: "请选择系部！",
                type: "info"
            });
            return;
        }
        if ($("#majorId").val() == "" || $("#majorId").val() == "0") {
            swal({
                title: "请选择专业！",
                type: "info"
            });
            return;
        }
        if ($("#f_uploadPerson").val() == "" || $("#f_uploadPerson").val() == "0" || $("#f_uploadPerson").val() == undefined) {
            swal({
                title: "请填写上传人！",
                type: "info"
            });
            return;
        }
        if( $("#f_uploadTime").val() == "" || $("#f_uploadTime").val() == "0" || $("#f_uploadTime").val() == undefined){
            swal({
                title: "请填写上传时间！",
                type: "info"
            });
            return;
        }
        var uploadTime = $("#f_uploadTime").val().replace('T',' ');
        $.post("<%=request.getContextPath()%>/regulations/saveRegulations", {
            id: $("#regulationsid").val(),
            semester: $("#f_semester").val(),
            uploadPerson: $("#f_uploadPerson").val(),
            departmentId: $("#departmentId").val(),
            majorId: $("#majorId").val(),
            uploadTime: uploadTime
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#regulations').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

