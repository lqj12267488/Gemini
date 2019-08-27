<%--论文管理编辑
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/1
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog"  style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" onclick="closeView()" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="w_id" hidden value="${paper.id}">
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 姓名：
                    </div>
                    <div class="col-md-4">
                        <input id="w_personId" type="text" value="${paper.personId}">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  论文名称：
                    </div>
                    <div class="col-md-4">
                        <input id="w_paperName" type="text" maxlength="10" placeholder="最多输入10个字" value="${paper.paperName}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 是否为代表成果：
                    </div>
                    <div class="col-md-4">
                        <select id="w_typicalFlag" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 本人角色：
                    </div>
                    <div class="col-md-4">
                        <select id="w_role" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学科领域：
                    </div>
                    <div class="col-md-4">
                        <select id="w_subject" class="js-example-basic-single" ></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>论文收录情况：
                    </div>
                    <div class="col-md-4">
                        <select id="w_embodySituation" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 发表刊物名称：
                    </div>
                    <div class="col-md-4">
                        <input id="w_journalName" type="text" maxlength="10" placeholder="最多输入10个字" value="${paper.journalName}">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 发表年月：
                    </div>
                    <div class="col-md-4">
                        <input id="w_publishDate" type="date" value="${paper.publishDate}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 卷号：
                    </div>
                    <div class="col-md-4">
                        <input id="w_volumeNum" type="text" maxlength="10" placeholder="最多输入10个字" value="${paper.volumeNum}">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 期号：
                    </div>
                    <div class="col-md-4">
                        <input id="w_issueNum" type="text" maxlength="10" placeholder="最多输入10个字" value="${paper.issueNum}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 起始页码：
                    </div>
                    <div class="col-md-4">
                        <input id="w_startNum" type="text" maxlength="5" placeholder="最多输入5个字" value="${paper.startNum}">
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 结束页码：
                    </div>
                    <div class="col-md-4">
                        <input id="w_endNum" type="text"  maxlength="5" placeholder="最多输入5个字" value="${paper.endNum}">
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
                                  value="${paper.remark}">${paper.remark}</textarea>
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
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="savePaper()">保存</button>
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
            addOption(data, 'w_typicalFlag','${paper.typicalFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRJSLW", function (data) {
            addOption(data, 'w_role','${paper.role}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XKLY", function (data) {
            addOption(data, 'w_subject','${paper.subject}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=LWSLQK", function (data) {
            addOption(data, 'w_embodySituation','${paper.embodySituation}');
        });
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${paper.id}',
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
            $("#w_personId").val("${paper.personId}");
            $("#w_personId").attr("keycode", "${paper.deptId}");
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

    function savePaper() {
        var reg = /^[0-9]+.?[0-9]*$/;
        if($("#w_personId").attr("keycode")=="" || $("#w_personId").attr("keycode") =="0" || $("#w_personId").attr("keycode") == undefined){
            swal({
                title: "请选择姓名及所在部门！",
                type: "info"
            });
            return;
        }
        if($("#w_paperName").val()=="" || $("#w_paperName").val() =="0" || $("#w_paperName").val() == undefined){
            swal({
                title: "请填写论文名称！",
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
        if($("#w_subject").val()=="" || $("#w_subject").val() =="0" || $("#w_subject").val() == undefined){
            swal({
                title: "请选择学科领域！",
                type: "info"
            });
            return;
        }
        if($("#w_embodySituation").val()=="" || $("#w_embodySituation").val() =="0" || $("#w_embodySituation").val() == undefined){
            swal({
                title: "请选择论文收录情况！",
                type: "info"
            });
            return;
        }
        if($("#w_journalName").val()=="" || $("#w_journalName").val() =="0" || $("#w_journalName").val() == undefined){
            swal({
                title: "请填写发表刊物名称！",
                type: "info"
            });
            return;
        }
        if($("#w_publishDate").val()=="" || $("#w_publishDate").val() =="0" || $("#w_publishDate").val() == undefined){
            swal({
                title: "请选择发表日期！",
                type: "info"
            });
            return;
        }
        if($("#w_volumeNum").val()=="" || $("#w_volumeNum").val() =="0" || $("#w_volumeNum").val() == undefined){
            swal({
                title: "请填写卷号！",
                type: "info"
            });
            return;
        }
        if($("#w_issueNum").val()=="" || $("#w_issueNum").val() =="0" || $("#w_issueNum").val() == undefined){
            swal({
                title: "请填写期号！",
                type: "info"
            });
            return;
        }
        if($("#w_startNum").val()=="" || $("#w_startNum").val() =="0" || $("#w_startNum").val() == undefined){
            swal({
                title: "请填写起始页码！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#w_startNum").val())){
            swal({
                title: "起始页码请填写数字！",
                type: "info"
            });
            return;
        }
        if($("#w_endNum").val()=="" || $("#w_endNum").val() =="0" || $("#w_endNum").val() == undefined){
            swal({
                title: "请填写结束页码！",
                type: "info"
            });
            return;
        }
        if(!reg.test($("#w_endNum").val())){
            swal({
                title: "结束页码请填写数字！",
                type: "info"
            });
            return;
        }
        var pid = $("#w_id").val();
        var headT = $("#w_personId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult/paper", {
            id: pid,
            personId: headTList[1],
            deptId: headTList[0],
            paperName: $("#w_paperName").val(),
            publishDate: $("#w_publishDate").val(),
            typicalFlag: $("#w_typicalFlag").val(),
            role: $("#w_role").val(),
            journalName: $("#w_journalName").val(),
            volumeNum: $("#w_volumeNum").val(),
            issueNum: $("#w_issueNum").val(),
            startNum: $("#w_startNum").val(),
            endNum: $("#w_endNum").val(),
            subject: $("#w_subject").val(),
            embodySituation: $("#w_embodySituation").val(),
            remark: $("#w_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#paperGrid').DataTable().ajax.reload();
            }
        })
    }
</script>

