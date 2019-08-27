<%--文艺作品管理编辑
  Created by IntelliJ IDEA.
  User: wq
  Date: 2017/8/1
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" onclick="closeView()"  class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="w_id" hidden value="${art.id}">
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   姓名：
                    </div>
                    <div class="col-md-10">
                        <input id="w_personId" type="text"
                               value="${art.personId}" placeholder="最多输入30个字" maxlength="30">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  文艺作品名称：
                    </div>
                    <div class="col-md-10">
                        <input id="w_artName" type="text" value="${art.artName}"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  代表成果：
                    </div>
                    <div class="col-md-10">
                        <select id="w_typicalFlag" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   本人角色：
                    </div>
                    <div class="col-md-10">
                        <select id="w_role" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  文艺作品类别：
                    </div>
                    <div class="col-md-10">
                        <select id="w_artType" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>    完成时间：
                    </div>
                    <div class="col-md-10">
                        <input id="w_finishDate" type="date" value="${art.finishDate}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>    完成地点：
                    </div>
                    <div class="col-md-10">
                        <input id="w_finishPlace" type="text" value="${art.finishPlace}" placeholder="最多输入30个字" maxlength="30">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 本人工作描述：
                    </div>
                    <div class="col-md-10">
                        <input id="w_workDescribe" type="text" value="${art.workDescribe}" placeholder="最多输入80个字" maxlength="80">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注：
                    </div>
                    <div class="col-md-10">
                        <textarea id="w_remark" type="text"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${art.remark}" placeholder="最多输入300个字" maxlength="300">${art.remark}</textarea>
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
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveArt()">保存</button>
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
            addOption(data, 'w_typicalFlag','${art.typicalFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=BRJSYY", function (data) {
            addOption(data, 'w_role','${art.role}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=WYZPLB", function (data) {
            addOption(data, 'w_artType','${art.artType}');
        });
        $.post("<%=request.getContextPath()%>/files/getFilesByBusinessId", {
            businessId: '${art.id}',
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
            $("#w_personId").val("${art.personId}");
            $("#w_personId").attr("keycode", "${art.deptId}");
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

    function saveArt() {
        if($("#w_personId").attr("keycode")=="" || $("#w_personId").attr("keycode") =="0" || $("#w_personId").attr("keycode") == undefined){
            swal({
                title: "请选择姓名及所在部门！",
                type: "info"
            });
            return;
        }
        if($("#w_artName").val()=="" || $("#w_artName").val() =="0" || $("#w_artName").val() == undefined){
            swal({
                title: "请填写文艺作品名称！",
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
        if($("#w_artType").val()=="" || $("#w_artType").val() == undefined){
            swal({
                title: "请选择文艺作品类别！",
                type: "info"
            });
            return;
        }
        if($("#w_finishDate").val()=="" || $("#w_finishDate").val() =="0" || $("#w_finishDate").val() == undefined){
            swal({
                title: "请选择完成时间！",
                type: "info"
            });
            return;
        }
        if($("#w_finishPlace").val()=="" || $("#w_finishPlace").val() =="0" || $("#w_finishPlace").val() == undefined){
            swal({
                title: "请填写完成地点！",
                type: "info"
            });
            return;
        }
        if($("#w_workDescribe").val()=="" || $("#w_workDescribe").val() =="0" || $("#w_workDescribe").val() == undefined){
            swal({
                title: "请填写本人工作描述！",
                type: "info"
            });
            return;
        }
        var pid=$("#w_id").val();
        var headT = $("#w_personId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult/art", {
            id: pid,
            personId: headTList[1],
            deptId: headTList[0],
            artName: $("#w_artName").val(),
            typicalFlag: $("#w_typicalFlag").val(),
            role: $("#w_role").val(),
            artType: $("#w_artType").val(),
            finishDate: $("#w_finishDate").val(),
            finishPlace: $("#w_finishPlace").val(),
            workDescribe: $("#w_workDescribe").val(),
            remark: $("#w_remark").val()
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#artGrid').DataTable().ajax.reload();
            }
        })
    }
</script>


