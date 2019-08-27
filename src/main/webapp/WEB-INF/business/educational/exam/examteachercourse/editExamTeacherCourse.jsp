<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/9/19
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span> 会员名称
                    </div>
                    <div class="col-md-9">
                        <input  id="personIdShow" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>会员编号
                    </div>
                    <div class="col-md-9">
                        <input id="f_memberNumber" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"  value="${unionMember.memberNumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>工会职务
                    </div>
                    <div class="col-md-9">
                        <input id="f_unionDuties" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" value="${unionMember.unionDuties}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>入会时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_joinTime" type="datetime-local" value="${unionMember.joinTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <input id="remark" type="text" value="${unionMember.remark}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="saveSalary()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="id" hidden value="${unionMember.id}">

<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
        $("#personIdShow").autocomplete({
            source: data,
            select: function (event, ui) {
                $("#personIdShow").val(ui.item.label);
                $("#personIdShow").attr("keycode", ui.item.value);
                return false;
            }
        }).data("ui-autocomplete")._renderItem = function (ul, item) {
            return $("<li>")
                .append("<a>" + item.label + "</a>")
                .appendTo(ul);
        };
    })
    function saveSalary() {
        var personDept = $("#personIdShow").attr("keycode");
        var personId = "";
        var deptId = "";
        if (null != personDept && personDept != ""){
            var lis = personDept.split(",");
            personId =lis[1];
            deptId = personDept.substring(0,6);
        }

        if(personId!=""||personId==null){

        }else{
            swal({
                title: "请填写会员",
                type: "info"
            });
            return;
        }
        if ($("#f_memberNumber").val()=="" || $("#f_memberNumber").val() == "0" || $("#f_memberNumber").val() == undefined) {
            swal({
                title: "填写会员编号",
                type: "info"
            });
            //alert("填写会员编号");
            return;
        }
        if ($("#f_unionDuties").val()=="" || $("#f_unionDuties").val() == "0" || $("#f_unionDuties").val() == undefined) {
            swal({
                title: "填写工会职务",
                type: "info"
            });
            //alert("填写工会职务");
            return;
        }
        if ($("#f_joinTime").val()=="" || $("#f_joinTime").val() == "0") {
            swal({
                title: "填写入会时间",
                type: "info"
            });
            //alert("填写入会时间");
            return;
        }

        var joinTime = $("#f_joinTime").val().replace('T',' ');
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/unionMember/saveUnionMember", {

            id: $("#id").val(),
            personId: personId,
            deptId: deptId,
            memberNumber: $("#f_memberNumber").val(),
            unionDuties: $("#f_unionDuties").val(),
            joinTime:joinTime,
            remark: $("#remark").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $('#unionMemberGrid').DataTable().ajax.reload();
            }
        })


    }

</script>

