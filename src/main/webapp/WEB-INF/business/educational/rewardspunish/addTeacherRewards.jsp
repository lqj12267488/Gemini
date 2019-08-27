<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 1000px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" onclick="closedwindow()" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="pid" hidden value="${rewards.id}">
            <input id="flag" type="hidden" value="${flag}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  获奖人
                    </div>
                    <div class="col-md-4">
                        <input id="edit_rewordPersonId" type="text"
                               class="validate[required,maxSize[100]] form-control"
                               value="${rewards.rewordPersonId}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  奖励类别
                    </div>
                    <div class="col-md-4">
                        <select id="edit_rewordTtype"
                                class="validate[required,maxSize[100]] form-control"
                                value="${rewards.rewordTtype}"/>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  奖励名称
                    </div>
                    <div class="col-md-4">

                        <input id="edit_rewordName" type="text" value="${rewards.rewordName}" class="validate[required,maxSize[20]] form-control"
                               onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"/>
                        <%-- <select  id="suppliesname" />--%>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  奖项等级
                    </div>
                    <div class="col-md-4">
                        <select id="edit_rewordGrade"
                                class="validate[required,maxSize[100]] form-control"
                                value="${rewards.rewordGrade}"/>
                    </div>
                </div>

                <div class="form-row">

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 荣誉称号
                    </div>
                    <div class="col-md-4">
                        <input id="edit_honoraryTitle" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${rewards.honoraryTitle}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 奖项类别
                    </div>
                    <div class="col-md-4">
                        <select id="edit_rewordNameType"
                                class="validate[required,maxSize[100]] form-control"
                                value="${rewards.rewordNameType}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  奖励级别
                    </div>
                    <div class="col-md-4">
                        <select id="edit_rewordLevel" class="validate[required,maxSize[100]] form-control"/>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 本人排名
                    </div>
                    <div class="col-md-4">
                        <select id="edit_personalRankings" class="validate[required,maxSize[100]] form-control"/>

                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>   奖励方式
                    </div>
                    <div class="col-md-4">
                        <select id="edit_rewordStyle" class="validate[required,maxSize[100]] form-control"/>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  授奖国家
                    </div>
                    <div class="col-md-4">
                        <select id="edit_awardCountry" class="validate[required,maxSize[100]] form-control"/>
                    </div>
                </div>



                <div class="form-row">

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  是否为代表性成果
                    </div>
                    <div class="col-md-4">
                        <select id="edit_representativeFlag"
                                class="validate[required,maxSize[100]] form-control"
                                value="${rewards.representativeFlag}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  获奖日期
                    </div>
                    <div class="col-md-4">
                        <input id="edit_rewordTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${rewards.rewordTime}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 获奖项目
                    </div>
                    <div class="col-md-10">
                        <input id="edit_rewordProject" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${rewards.rewordProject}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>  颁奖单位
                    </div>
                    <div class="col-md-10">
                        <input id="edit_awardUnit" type="text"
                               class="validate[required,maxSize[20]] form-control"
                               value="${rewards.awardUnit}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 奖励原因
                    </div>
                    <div class="col-md-10">
                        <textarea id="edit_rewordReason"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${rewards.rewordReason}">${rewards.rewordReason}</textarea>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 奖励内容
                    </div>
                    <div class="col-md-10">
                        <textarea id="edit_rewordContent"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${rewards.rewordContent}">${rewards.rewordContent}</textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        备注
                    </div>
                    <div class="col-md-10">
                        <textarea id="edit_remark"
                                  class="validate[required,maxSize[20]] form-control"
                                  value="${rewards.remark}">${rewards.remark}</textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLLB", function (data) {
            addOption(data, 'edit_rewordTtype', '${rewards.rewordTtype}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLMC", function (data) {
            addOption(data, 'edit_rewordNameType', '${rewards.rewordNameType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLDJ", function (data) {
            addOption(data, 'edit_rewordGrade', '${rewards.rewordGrade}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=GJ", function (data) {
            addOption(data, 'edit_awardCountry', '${rewards.awardCountry}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'edit_representativeFlag', '${rewards.representativeFlag}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLPM", function (data) {
            addOption(data, 'edit_personalRankings', '${rewards.personalRankings}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLJB", function (data) {
            addOption(data, 'edit_rewordLevel', '${rewards.rewordLevel}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSJLFS", function (data) {
            addOption(data, 'edit_rewordStyle', '${rewards.rewordStyle}');
        });
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#edit_rewordPersonId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#edit_rewordPersonId").val(ui.item.label);
                    $("#edit_rewordPersonId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };

        })
        var ppid = $("#pid").val();
        if(ppid!=""){
            $("#edit_rewordPersonId").val("${rewards.rewordPersonId}");
            $("#edit_rewordPersonId").attr("keycode", "${rewards.rewordPersonDeptId}");
        }

        if($("#flag").val()=='1'||$("#flag").val()==1){
            $("#saveBtn").hide();
            $("input").attr('readOnly','readOnly');
            $("select").attr('disabled','disabled');
            $("textarea").attr('readOnly','readOnly');
        }

    })

    function closedwindow(){
        $("input").removeAttr("readOnly");
    }

    function saveDept() {
        if($("#edit_rewordPersonId").attr("keycode") =="" || $("#edit_rewordPersonId").attr("keycode") =="0" || $("#edit_rewordPersonId").attr("keycode") == undefined){
            swal({
                title: "请填写并选择获奖人姓名！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordTtype").val()==""  || $("#edit_rewordTtype").val() == undefined){
            swal({
                title: "请选择奖励类别！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordName").val()=="" ||  $("#edit_rewordName").val() =="0" || $("#edit_rewordName").val() == undefined){
            swal({
                title: "请填写奖励名称！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordGrade").val()=="" ||  $("#edit_rewordGrade").val() =="0" || $("#edit_rewordGrade").val() == undefined){
            swal({
                title: "请选择奖项等级！",
                type: "info"
            });
            return;
        }
        if($("#edit_honoraryTitle").val()=="" ||  $("#edit_honoraryTitle").val() =="0" || $("#edit_honoraryTitle").val() == undefined){
            swal({
                title: "请填写荣誉称号！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordNameType").val()=="" ||  $("#edit_rewordNameType").val() =="0" || $("#edit_rewordNameType").val() == undefined){
            swal({
                title: "请选择奖项类别！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordLevel").val()==""  || $("#edit_rewordLevel").val() == undefined) {
            swal({
                title: "请选择奖励级别！",
                type: "info"
            });
            return;
        }
        if($("#edit_personalRankings").val()=="" ||   $("#edit_personalRankings").val() == undefined){
            swal({
                title: "请选择本人排名！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordStyle").val()=="" ||  $("#edit_rewordStyle").val() =="0" || $("#edit_rewordStyle").val() == undefined){
            swal({
                title: "请选择奖励方式！",
                type: "info"
            });
            return;
        }
        if($("#edit_awardCountry").val()=="" ||   $("#edit_awardCountry").val() == undefined){
            swal({
                title: "请选择授奖国家！",
                type: "info"
            });
            return;
        }
        if($("#edit_representativeFlag").val()=="" ||   $("#edit_representativeFlag").val() == undefined){
            swal({
                title: "请选择是否是代表性成果和项目！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordTime").val()=="" ||  $("#edit_rewordTime").val() =="0" || $("#edit_rewordTime").val() == undefined){
            swal({
                title: "请填写获奖日期！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordProject").val()=="" ||  $("8#edit_rewordProject").val() =="0" || $("#edit_rewordProject").val() == undefined){
            swal({
                title: "请填写获奖项目！",
                type: "info"
            });
            return;
        }
        if($("#edit_awardUnit").val()=="" ||  $("#edit_awardUnit").val() =="0" || $("#edit_awardUnit").val() == undefined){
            swal({
                title: "请填写颁奖单位！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordReason").val()=="" ||  $("#edit_rewordReason").val() =="0" || $("#edit_rewordReason").val() == undefined){
            swal({
                title: "请填写奖励原因！",
                type: "info"
            });
            return;
        }
        if($("#edit_rewordContent").val()=="" ||  $("#edit_rewordContent").val() =="0" || $("#edit_rewordContent").val() == undefined){
            swal({
                title: "请填写奖励内容！",
                type: "info"
            });
            return;
        }
        var pid=$("#pid").val();
        var headT = $("#edit_rewordPersonId").attr("keycode");
        var headTList = headT.split(",");
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/rewards/updaterewardsById", {
            id: pid,
            rewordPersonId: headTList[1],
            rewordPersonDeptId: headTList[0],
            rewordName: $("#edit_rewordName").val(),
            rewordTime: $("#edit_rewordTime").val(),
            rewordLevel: $("#edit_rewordLevel").val(),
            rewordStyle: $("#edit_rewordStyle").val(),
            rewordProject: $("#edit_rewordProject").val(),
            rewordReason: $("#edit_rewordReason").val(),
            rewordContent: $("#edit_rewordContent").val(),
            awardUnit: $("#edit_awardUnit").val(),
            honoraryTitle: $("#edit_honoraryTitle").val(),
            remark: $("#edit_remark").val(),
            rewordTtype: $("#edit_rewordTtype").val(),
            rewordNameType: $("#edit_rewordNameType").val(),
            rewordGrade: $("#edit_rewordGrade").val(),
            awardCountry: $("#edit_awardCountry").val(),
            representativeFlag: $("#edit_representativeFlag").val(),
            personalRankings: $("#edit_personalRankings").val()

        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#rewardsGrid').DataTable().ajax.reload();
            }
        })
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end

</script>



