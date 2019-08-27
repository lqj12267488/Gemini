<%--指导学生参加竞赛获奖管理编辑
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/1
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" onclick="closeView()" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="w_id" hidden value="${guide.id}">
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
                               value="${guide.personId}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 奖励名称：
                    </div>
                    <div class="col-md-10">
                        <input id="w_prizeName" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               value="${guide.prizeName}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>奖励等级：
                    </div>
                    <div class="col-md-10">
                        <input id="w_prizeRank" type="text"
                               maxlength="10" placeholder="最多输入10个字"
                               value="${guide.prizeRank}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 获奖年月：
                    </div>
                    <div class="col-md-10">
                        <input id="w_prizeDate" type="date" value="${guide.prizeDate}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 代表成果：
                    </div>
                    <div class="col-md-10">
                        <select id="w_typicalFlag" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 本人角色：
                    </div>
                    <div class="col-md-10">
                        <select id="w_role" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>工作描述：
                    </div>
                    <div class="col-md-10">
                        <input id="w_workDescribe" type="text"
                               maxlength="30" placeholder="最多输入30个字"
                               value="${guide.workDescribe}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注：
                    </div>
                    <div class="col-md-10">
                        <textarea id="w_remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  maxlength="30" placeholder="最多输入30个字"
                                  value="${guide.remark}">${guide.remark}</textarea>
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
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveGuide()">保存</button>
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
            addOption(data, 'w_typicalFlag','${guide.typicalFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRJSZD", function (data) {
            addOption(data, 'w_role','${guide.role}');
        });
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${guide.id}',
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
            $("#w_personId").val("${guide.personId}");
            $("#w_personId").attr("keycode", "${guide.deptId}");
        }
        if($("#flag").val()=='on'){
            $("#btn").hide();
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
    function saveGuide() {
        if($("#w_personId").attr("keycode")=="" || $("#w_personId").attr("keycode") =="0" || $("#w_personId").attr("keycode") == undefined){
            swal({
                title: "请选择姓名及所在部门！",
                type: "info"
            });
            return;
        }
        if($("#w_prizeName").val()=="" || $("#w_prizeName").val() =="0" || $("#w_prizeName").val() == undefined){
            swal({
                title: "请填写奖励名称！",
                type: "info"
            });
            return;
        }
        if($("#w_prizeRank").val()=="" || $("#w_prizeRank").val() =="0" || $("#w_prizeRank").val() == undefined){
            swal({
                title: "请填写奖项等级！",
                type: "info"
            });
            return;
        }
        if($("#w_prizeDate").val()=="" || $("#w_prizeDate").val() =="0" || $("#w_prizeDate").val() == undefined){
            swal({
                title: "请选择获奖年月！",
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
        if($("#w_workDescribe").val()=="" || $("#w_workDescribe").val() =="0" || $("#w_workDescribe").val() == undefined){
            swal({
                title: "请填写工作描述！",
                type: "info"
            });
            return;
        }
        var pid=$("#w_id").val();
        var headT = $("#w_personId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult/guide", {
            id: pid,
            personId: headTList[1],
            deptId: headTList[0],
            prizeName: $("#w_prizeName").val(),
            prizeRank: $("#w_prizeRank").val(),
            prizeDate: $("#w_prizeDate").val(),
            typicalFlag: $("#w_typicalFlag").val(),
            role: $("#w_role").val(),
            workDescribe: $("#w_workDescribe").val(),
            remark: $("#w_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#guideGrid').DataTable().ajax.reload();
            }
        })
    }
</script>

