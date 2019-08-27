<%--项目(课题)管理编辑
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/24
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"  onclick="closeView()">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" >
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 姓名：
                    </div>
                    <div class="col-md-10">
                        <input id="w_personId" type="text" value="${project.personId}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 项目名称：
                    </div>
                    <div class="col-md-4">
                        <input id="w_projectName" type="text" value="${project.projectName}"
                               maxlength="10" placeholder="最多输入10个字"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="50" placeholder="最多输入50个字">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>项目中本人角色：
                    </div>
                    <div class="col-md-4">
                        <select id="w_projectRole" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        项目类型：
                    </div>
                    <div class="col-md-4">
                        <select id="w_projectType" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学科领域：
                    </div>
                    <div class="col-md-4">
                        <select id="w_subject" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>是否为代表项目：
                    </div>
                    <div class="col-md-4">
                        <select id="w_typicalFlag" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>本人排名：
                    </div>
                    <div class="col-md-4">
                        <select id="w_ranking" class="js-example-basic-single" ></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>项目批准号：
                    </div>
                    <div class="col-md-4">
                        <input id="w_approveNum" type="text"
                               maxlength="20" placeholder="最多输入20个字"
                               value="${project.approveNum}">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>项目经费额度：
                    </div>
                    <div class="col-md-4">
                        <input id="w_fundsAmount" type="text"
                               maxlength="5" placeholder="最多输入5个字"
                               value="${project.fundsAmount}">
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 开始日期：
                    </div>
                    <div class="col-md-4">
                        <input id="w_startDate" type="date" value="${project.startDate}">
                    </div>
                    <div class="col-md-2 tar">
                        结束日期：
                    </div>
                    <div class="col-md-4">
                        <input id="w_endDate" type="date" value="${project.endDate}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 项目来源：
                    </div>
                    <div class="col-md-4">
                        <select id="w_projectSource" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 项目委托单位：
                    </div>
                    <div class="col-md-4">
                        <input id="w_projectClient" type="text"
                               maxlength="10" placeholder="最多输入10个字" value="${project.projectClient}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-10">
                        <textarea id="w_remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  maxlength="30" placeholder="最多输入30个字"
                                  value="${project.remark}">${project.remark}</textarea>
                    </div>
                </div>
                <div id="file" class="form-row" hidden>
                    <div class="col-md-2 tar">
                        &nbsp;&nbsp;&nbsp;&nbsp;附件：
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn"  type="button" class="btn btn-success btn-clean" onclick="saveProject()">保存</button>
            <button type="button" onclick="closeView()" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
    <input id="w_id" hidden value="${project.id}">
    <input id="flag" type="hidden" value="${flag}">
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        //项目所有人及所属部门模糊查询下拉选择
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#w_personId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#w_personId").val(ui.item.label);
                    $("#w_personId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SDBXXM", function (data) {
            addOption(data, 'w_typicalFlag','${project.typicalFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XMLX", function (data) {
            addOption(data, 'w_projectType','${project.projectType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRJSXM", function (data) {
            addOption(data, 'w_projectRole','${project.projectRole}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRPM", function (data) {
            addOption(data, 'w_ranking','${project.ranking}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XKLY", function (data) {
            addOption(data, 'w_subject','${project.subject}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XMLY", function (data) {
            addOption(data, 'w_projectSource','${project.projectSource}');
        });
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${project.id}',
        }, function (data) {
            if (data.data.length == 0) {
                $("#file").append('<div class="form-row">' +
                    '<div class="col-md-3 tar"></div>' +
                    '<div class="col-md-9">' +
                    '无' +
                    '</div>' +
                    '</div>')
            } else {
                $.each(data.data, function (i, val) {
                    $("#file").append('<div class="form-row">' +
                        '<div class="col-md-3 tar"></div>' +
                        '<div class="col-md-9">' +
                        '<a href="' +'<%=request.getContextPath()%>'+ val.fileUrl + '" target="_blank">' + val.fileName + '</a>' +
                        '</div>' +
                        '</div>');
                })
            }
        })
        var ppid = $("#w_id").val();
        if(ppid!=""){
            $("#w_personId").val("${project.personId}");
            $("#w_personId").attr("keycode", "${project.deptId}");
        }
        if($("#flag").val()=='on'){
            $("#saveBtn").hide();
            $("input").attr('readonly','readonly');
            $("select").attr('disabled','disabled');
            $("textarea").attr('readonly','readonly');
            $("#file").removeAttr('hidden');
        }
    })

    function closeView(){
        $("input").removeAttr('readonly');
        $("select").removeAttr('disabled');
        $("textarea").removeAttr('readonly');
    }

    function saveProject() {
        var startDate = $("#w_startDate").val();
        var endDate = $("#w_endDate").val();
        startDate = startDate.replace('T','');
        endDate = endDate.replace('T','');
        if($("#w_personId").attr("keycode")=="" || $("#w_personId").attr("keycode") =="0" || $("#w_personId").attr("keycode") == undefined){
            swal({
                title: "请选择姓名及所在部门！",
                type: "info"
            });
            return;
        }
        if($("#w_projectName").val()=="" || $("#w_projectName").val() =="0" || $("#w_projectName").val() == undefined){
            swal({
                title: "请填写项目名称！",
                type: "info"
            });
            return;
        }
        if($("#w_projectRole").val()=="" || $("#w_projectRole").val() =="0" || $("#w_projectRole").val() == undefined){
            swal({
                title: "请选择项目中本人角色！",
                type: "info"
            });
            return;
        }
        /*if($("#w_projectType").val()=="" || $("#w_projectType").val() == undefined){
            swal({
                title: "请选择项目类型！",
                type: "info"
            });
            return;
        }*/
        if($("#w_subject").val()=="" || $("#w_subject").val() =="0" || $("#w_subject").val() == undefined){
            swal({
                title: "请选择学科领域！",
                type: "info"
            });
            return;
        }
        if($("#w_typicalFlag").val()=="" || $("#w_typicalFlag").val() == undefined){
            swal({
                title: "请选择是否为代表性项目！",
                type: "info"
            });
            return;
        }
        if($("#w_ranking").val()=="" || $("#w_ranking").val() == undefined){
            swal({
                title: "请选择本人排名！",
                type: "info"
            });
            return;
        }
        if($("#w_approveNum").val()=="" || $("#w_approveNum").val() =="0" || $("#w_approveNum").val() == undefined){
            swal({
                title: "请填写项目批准号！",
                type: "info"
            });
            return;
        }
        if($("#w_fundsAmount").val()=="" || $("#w_fundsAmount").val() =="0" || $("#w_fundsAmount").val() == undefined){
            swal({
                title: "请填写项目经费额度！",
                type: "info"
            });
            return;
        }
        if($("#w_startDate").val()=="" || $("#w_startDate").val() =="0" || $("#w_startDate").val() == undefined){
            swal({
                title: "请选择开始日期！",
                type: "info"
            });
            return;
        }
       /* if($("#w_endDate").val()=="" || $("#w_endDate").val() =="0" || $("#w_endDate").val() == undefined){
            swal({
                title: "请选择结束日期！",
                type: "info"
            });
            return;
        }*/
        /*if(startDate>endDate){
            swal({
                title: "结束日期应晚于开始日期！",
                type: "info"
            });
            return;
        }*/
        if($("#w_projectSource").val()=="" || $("#w_projectSource").val() =="0" || $("#w_projectSource").val() == undefined){
            swal({
                title: "请选择项目来源！",
                type: "info"
            });
            return;
        }
        if($("#w_projectClient").val()=="" || $("#w_projectClient").val() =="0" || $("#w_projectClient").val() == undefined){
            swal({
                title: "请填写项目委托单位！",
                type: "info"
            });
            return;
        }
        var pid = $("#w_id").val();
        var headT = $("#w_personId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult/project", {
            id: pid,
            personId: headTList[1],
            deptId: headTList[0],
            typicalFlag: $("#w_typicalFlag").val(),
            projectType: $("#w_projectType").val(),
            projectName: $("#w_projectName").val(),
            projectRole: $("#w_projectRole").val(),
            ranking: $("#w_ranking").val(),
            subject: $("#w_subject").val(),
            approveNum: $("#w_approveNum").val(),
            fundsAmount: $("#w_fundsAmount").val(),
            startDate: startDate,
            endDate: endDate,
            projectSource: $("#w_projectSource").val(),
            projectClient: $("#w_projectClient").val(),
            remark: $("#w_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#projectGrid').DataTable().ajax.reload();
            }
        })
    }
</script>