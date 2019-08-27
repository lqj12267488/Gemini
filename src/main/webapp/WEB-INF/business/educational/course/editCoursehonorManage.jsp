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
            <input id="courseHonorId" hidden value="${courseHonorId}">
            <input id="courseManageId" hidden value="${coursehonor.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        等级
                    </div>
                    <div class="col-md-9">
                        <select id="f_honorLevel" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        获得时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_ownTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${coursehonor.ownTime}"/>
                    </div>
                </div>
              <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        有效期
                    </div>
                    <div class="col-md-9">
                        <input id="f_validTime"  type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${coursehonor.validTime}"/>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=DJ", function (data) {
            addOption(data, 'f_honorLevel','${coursehonor.honorLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getUserDict?name=RYMC", function (data) {
            addOption(data, 'f_honorName', '${coursehonor.honorName}');
        });
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
            id:"COURSE_ID",
            text:"COURSE_NAME",
            tableName:"T_JW_COURSE",
            where:" ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_courseName','${coursehonor.courseName}');
        });
    })

    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        var reg2 = /^[0-9]+.?[0-9]*$/;

        if ($("#f_honorLevel").val() == "" || $("#f_honorLevel").val() == "0") {
            swal({
                title: "请选择等级！",
                type: "info"
            });
            return;
        }

       if( $("#f_ownTime").val() == "" || $("#f_ownTime").val() == "0" || $("#f_ownTime").val() == undefined){
            swal({
                title: "请填写获得时间！",
                type: "info"
            });
            return;
        }
        if( $("#f_validTime").val() == "" || $("#f_validTime").val() == "0" || $("#f_validTime").val() == undefined){
            swal({
                title: "请填写有效期！",
                type: "info"
            });
            return;
        }
        if (!reg2.test($("#f_validTime").val())) {
            alert("有效期请填写数字");
            return;
        }


        if($("#person").attr("keycode")=="" || $("#person").attr("keycode") ==null){
            $("#person").attr("keycode",$("#perId").val())
        }
        $.post("<%=request.getContextPath()%>/coursehonor/saveCoursehonorManage", {
            id:$("#courseManageId").val(),
            courseHonorId: $("#courseHonorId").val(),
            honorLevel: $("#f_honorLevel").val(),
            ownTime: $("#f_ownTime").val(),
            validTime: $("#f_validTime").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#coursehonor').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

