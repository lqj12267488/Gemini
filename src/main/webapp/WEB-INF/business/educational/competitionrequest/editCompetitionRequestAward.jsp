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
            <input id="id" hidden value="${competitionRequest.id}">
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">

                <div class="form-row">
                    <div class="col-md-3 tar" >
                        <span class="iconBtx">*</span> 竞赛名称：
                    </div>
                    <div class="col-md-9">
                        <input id="teacherInfoName" type="text" value="${competitionRequest.competitionNameShow}" readonly="readonly"/>
                        <input id="perId" type="hidden" value="${competitionRequest.competitionName}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        分赛项
                    </div>
                    <div class="col-md-9">
                        <input id="f_branchMatch" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.branchMatch}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        系部
                    </div>
                    <div class="col-md-9">
                        <select id="f_department" onchange="changeMajor()" disabled="disabled"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        专业
                    </div>
                    <div class="col-md-9">
                        <select id="f_major" disabled="disabled"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        指导教师
                    </div>
                    <div class="col-md-9">
                        <input id="f_instructor" type="text" onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.instructor}" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        参赛性质
                    </div>
                    <div class="col-md-9">
                        <select id="f_competitionNature" disabled="disabled"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        参赛时间
                    </div>
                    <div class="col-md-9">
                        <input id="f_time" type="month" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.time}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        组织单位
                    </div>
                    <div class="col-md-9">
                        <input id="f_organizationUnit"  type="text"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字" readonly="readonly"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.organizationUnit}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        级别
                    </div>
                    <div class="col-md-9">
                        <select id="f_grade" />
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>
                        成绩
                    </div>
                    <div class="col-md-9">
                        <input id="f_score"  type="text"  onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
                               maxlength="30" placeholder="最多输入30个字"
                               class="validate[required,maxSize[20]] form-control"
                               value="${competitionRequest.score}"/>
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
        $.get("<%=request.getContextPath()%>/competition/competitionName", function (data) {
            $("#teacherInfoName").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherInfoName").val(ui.item.label);
                    $("#teacherInfoName").attr("keycode", ui.item.value);
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
            id:"dept_id",
            text:"dept_name",
            tableName:"T_SYS_DEPT",
            where:"WHERE dept_type = 8 ",
            orderBy:""
        }, function (data) {
            addOption(data, 'f_department','${competitionRequest.department}');
        });
        $("#f_department").change(function () {
            if($("#f_department").val() != null){
                $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"WHERE departments_id = '" + $("#f_department").val() +"' ",
                    orderBy:""
                }, function (data) {
                    addOption(data, 'f_major');
                });
            }
        })

        $.get("/common/getSysDict?name=CSXZ", function (data) {
            addOption(data, 'f_competitionNature','${competitionRequest.competitionNature}');
        });
        $.get("/common/getSysDict?name=JSJB", function (data) {
            addOption(data, 'f_grade','${competitionRequest.grade}');
        });
        if("" != '${competitionRequest.major}' ){
            $.get("<%=request.getContextPath()%>/common/getTableDict",{
                    id:"major_code",
                    text:"major_name",
                    tableName:"T_XG_MAJOR",
                    where:"",
                    orderBy:""
                }
                , function (data) {
                    addOption(data, 'f_major','${competitionRequest.major}');
                });
        }


    })
    function saveDept() {
        var reg = new RegExp("^[0-9]*$");
        if ($("#f_grade").val() == "" || $("#f_grade").val() == "0") {
            swal({
                title: "请选择级别！",
                type: "info"
            });
            return;
        }
        if($("#f_score").val()=="" || $("#f_score").val() == undefined || $("#f_score").val() == null){
            swal({
                title: "请填写成绩！",
                type: "info"
            });
            return;
        }

        if($("#teacherInfoName").attr("keycode")=="" || $("#teacherInfoName").attr("keycode") ==null){
            $("#teacherInfoName").attr("keycode",$("#perId").val())
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/competitionRequest/saveCompetitionRequest", {
            id: $("#id").val(),
            competitionName: $("#teacherInfoName").attr("keycode"),
            branchMatch: $("#f_branchMatch").val(),
            department: $("#f_department").val(),
            major: $("#f_major").val(),
            instructor: $("#f_instructor").val(),
            competitionNature: $("#f_competitionNature").val(),
            time: $("#f_time").val(),
            organizationUnit: $("#f_organizationUnit").val(),
            score: $("#f_score").val(),
            grade: $("#f_grade").val(),
        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#competitionRequestAward').DataTable().ajax.reload();
            }
        })
        showSaveLoading();
    }

</script>

