<%--
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/7/27
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button"  onclick="closeView()"  class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="w_id" hidden value="${standard.id}">
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 姓名：
                    </div>
                    <div class="col-md-10">
                        <input id="w_personId" type="text"
                               value="${standard.personId}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 标准号：
                    </div>
                    <div class="col-md-10">
                        <input id="w_standardNum" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               value="${standard.standardNum}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>发布日期：
                    </div>
                    <div class="col-md-10">
                        <input id="w_publishDate" type="date" value="${standard.publishDate}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>代表项目：
                    </div>
                    <div class="col-md-10">
                        <select id="w_typicalFlag" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>本人角色：
                    </div>
                    <div class="col-md-10">
                        <select id="w_role" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 发布单位：
                    </div>
                    <div class="col-md-10">
                        <input id="w_publishUnit" type="text" value="${standard.publishUnit}">
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
                                  value="${standard.remark}">${standard.remark}</textarea>
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
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveStandard()">保存</button>
            <button type="button" onclick="closeView()" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
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
            addOption(data, 'w_typicalFlag','${standard.typicalFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRJSLW", function (data) {
            addOption(data, 'w_role','${standard.role}');
        });
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${standard.id}',
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
            $("#w_personId").val("${standard.personId}");
            $("#w_personId").attr("keycode", "${standard.deptId}");
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

    function saveStandard() {
        var publishDate = $("#w_publishDate").val();
        if($("#w_personId").attr("keycode")=="" || $("#w_personId").attr("keycode") =="0" || $("#w_personId").attr("keycode") == undefined){
            swal({
                title: "请选择姓名及所在部门！",
                type: "info"
            });
            return;
        }
        if($("#w_standardNum").val()=="" || $("#w_standardNum").val() =="0" || $("#w_standardNum").val() == undefined){
            swal({
                title: "请填写标准号！",
                type: "info"
            });
            return;
        }
        if($("#w_publishDate").val()=="" || $("#w_publishDate").val() =="0" || $("#w_publishDate").val() == undefined){
            swal({
                title: "请选择发布日期！",
                type: "info"
            });
            return;
        }
        if($("#w_typicalFlag").val()=="" || $("#w_typicalFlag").val() == undefined){
            swal({
                title: "请选择是否为代表性成果！",
                type: "info"
            });
            return;
        }
        if($("#w_role").val()=="" || $("#w_role").val() =="0" || $("#w_role").val() == undefined){
            swal({
                title: "请选择本人角色！",
                type: "info"
            });
            return;
        }
        if($("#w_publishUnit").val()=="" || $("#w_publishUnit").val() =="0" || $("#w_publishUnit").val() == undefined){
            swal({
                title: "请填写发布单位！",
                type: "info"
            });
            return;
        }
        var pid=$("#w_id").val();
        var headT = $("#w_personId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult/standard", {
            id: pid,
            personId: headTList[1],
            deptId: headTList[0],
            standardNum: $("#w_standardNum").val(),
            typicalFlag: $("#w_typicalFlag").val(),
            role: $("#w_role").val(),
            publishDate: publishDate,
            publishUnit: $("#w_publishUnit").val(),
            remark: $("#w_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#standardGrid').DataTable().ajax.reload();
            }
        })
    }
</script>
