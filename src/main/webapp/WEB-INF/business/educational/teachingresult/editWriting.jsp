<%--著作
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/1
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog"  style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" onclick="closeView()"  class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="w_id" hidden value="${writing.id}">
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名：
                    </div>
                    <div class="col-md-10">
                        <input id="w_personId" type="text" value="${writing.personId}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>是否为代表成果：
                    </div>
                    <div class="col-md-4">
                        <select id="w_typicalFlag" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>本人角色：
                    </div>
                    <div class="col-md-4">
                        <select id="w_role" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>著作名称：
                    </div>
                    <div class="col-md-4">
                        <input id="w_writingName" type="text" value="${writing.writingName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" maxlength="10" placeholder="最多输入10个字" >
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>出版日期：
                    </div>
                    <div class="col-md-4">
                        <input id="w_publishDate" type="date" value="${writing.publishDate}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>著作类别：
                    </div>
                    <div class="col-md-4">
                        <select id="w_writingType" class="js-example-basic-single" ></select>
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
                        <span class="iconBtx">*</span>出版社名称：
                    </div>
                    <div class="col-md-4">
                        <input id="w_pressName" type="text" value="${writing.pressName}" maxlength="10" placeholder="最多输入10个字" >
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>出版号：
                    </div>
                    <div class="col-md-4">
                        <input id="w_publishNum" type="text" value="${writing.publishNum}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>总字数：
                    </div>
                    <div class="col-md-4">
                        <input id="w_totalCount" type="text" value="${writing.totalCount}" maxlength="10" placeholder="最多输入5个字">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>撰写字数：
                    </div>
                    <div class="col-md-4">
                        <input id="w_wordCount" type="text" value="${writing.wordCount}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-10">
                        <textarea id="w_remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  maxlength="25" placeholder="最多输入25个字"
                                  value="${writing.remark}">${writing.remark}</textarea>
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
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveWriting()">保存</button>
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
            addOption(data, 'w_typicalFlag','${writing.typicalFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRJSZZ", function (data) {
            addOption(data, 'w_role','${writing.role}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZZLB", function (data) {
            addOption(data, 'w_writingType','${writing.writingType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XKLY", function (data) {
            addOption(data, 'w_subject','${writing.subject}');
        });
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${writing.id}',
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
            $("#w_personId").val("${writing.personId}");
            $("#w_personId").attr("keycode", "${writing.deptId}");
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

    function saveWriting() {
        var reg = /^[0-9]+.?[0-9]*$/;
        if($("#w_personId").attr("keycode")=="" || $("#w_personId").attr("keycode") =="0" || $("#w_personId").attr("keycode") == undefined){
            swal({
                title: "请选择姓名及所在部门！",
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
        if($("#w_writingName").val()=="" || $("#w_writingName").val() =="0" || $("#w_writingName").val() == undefined){
            swal({
                title: "请填写著作名称！",
                type: "info"
            });
            return;
        }
        if($("#w_publishDate").val()=="" || $("#w_publishDate").val() =="0" || $("#w_publishDate").val() == undefined){
            swal({
                title: "请选择出版日期！",
                type: "info"
            });
            return;
        }
        if($("#w_writingType").val()=="" || $("#w_writingType").val() == undefined){
            swal({
                title: "请选择著作类别！",
                type: "info"
            });
            return;
        }
        if($("#w_subject").val()=="" || $("#w_subject").val() =="0" || $("#w_subject").val() == undefined){
            swal({
                title: "请选择学科领域！",
                type: "info"
            });
            return;
        }
        if($("#w_pressName").val()=="" || $("#w_pressName").val() =="0" || $("#w_pressName").val() == undefined){
            swal({
                title: "请填写出版社名称！",
                type: "info"
            });
            return;
        }
        if($("#w_publishNum").val()=="" || $("#w_publishNum").val() =="0" || $("#w_publishNum").val() == undefined){
            swal({
                title: "请填写出版号！",
                type: "info"
            });
            return;
        }
        if($("#w_totalCount").val()=="" || $("#w_totalCount").val() =="0" || $("#w_totalCount").val() == undefined){
            swal({
                title: "请填写总字数！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#w_totalCount").val())){
            swal({
                title: "总字数请填写数字！",
                type: "info"
            });
            return;
        }
        if($("#w_wordCount").val()=="" || $("#w_wordCount").val() =="0" || $("#w_wordCount").val() == undefined){
            swal({
                title: "请填写撰写字数！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#w_wordCount").val())){
            swal({
                title: "撰写字数请填写数字！",
                type: "info"
            });
            return;
        }
        var pid = $("#w_id").val();
        var headT = $("#w_personId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult/writing", {
            id: pid,
            personId: headTList[1],
            deptId: headTList[0],
            writingName: $("#w_writingName").val(),
            role: $("#w_role").val(),
            writingType: $("#w_writingType").val(),
            subject: $("#w_subject").val(),
            typicalFlag: $("#w_typicalFlag").val(),
            publishDate: $("#w_publishDate").val(),
            pressName: $("#w_pressName").val(),
            publishNum: $("#w_publishNum").val(),
            totalCount: $("#w_totalCount").val(),
            wordCount: $("#w_wordCount").val(),
            remark: $("#w_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#writingGrid').DataTable().ajax.reload();
            }
        })
    }
</script>

