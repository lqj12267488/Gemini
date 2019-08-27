<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
            <input id="id" hidden value="${teachingResult.id}">
            <input id="dept"  type="hidden" value="${teachingResult.resultPersonDeptId}">
        </div>
        <div class="modal-body clearfix">

            <div class="controls" >

                <div class="form-row">
                    <div class="col-md-3 tar">
                        成果对象：
                    </div>
                    <div class="col-md-9">
                        <select id="t_resultObject" class="js-example-basic-single" onchange="autoComplete()"></select>
                    </div>
                </div>


                <div class="form-row">
                    <div class="col-md-3 tar">
                        教研成果类别：
                    </div>
                    <div class="col-md-9">
                        <select id="t_resultType" class="js-example-basic-single" ></select>                        <%-- <select  id="suppliesname" />--%>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        教研成果级别：
                    </div>
                    <div class="col-md-9">
                        <select id="t_resultLevel" class="js-example-basic-single" ></select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        成果所有人：
                    </div>
                    <div class="col-md-9">
                        <input id="t_resultPersonId" type="text"value="${teachingResult.resultPersonId}">
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-3 tar">
                        成果获得时间：
                    </div>
                    <div class="col-md-9">
                        <input id="t_resultTime" type="date"
                               class="validate[required,maxSize[20]] form-control"
                               value="${teachingResult.resultTime}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        备注
                    </div>
                    <div class="col-md-9">
                        <textarea id="t_remark" type="text"
                               class="validate[required,maxSize[20]] form-control"
                                  value="${teachingResult.remark}"></textarea>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="saveResult()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭</button>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CGDX", function (data) {
            addOption(data, 't_resultObject','${teachingResult.resultObject}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYCGLB", function (data) {
            addOption(data, 't_resultType','${teachingResult.resultType}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JYCGJB", function (data) {
            addOption(data, 't_resultLevel','${teachingResult.resultLevel}');
        });
        })

    function autoComplete(){
        if($("#t_resultObject option:selected").val() =='1'){
            $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
                $("#t_resultPersonId").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#t_resultPersonId").val(ui.item.label);
                        $("#t_resultPersonId").attr("keycode", ui.item.value);
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        }else{
            $.get("<%=request.getContextPath()%>/common/getStudentClass", function (data) {
                $("#t_resultPersonId").autocomplete({
                    source: data,
                    select: function (event, ui) {
                        $("#t_resultPersonId").val(ui.item.label);
                        $("#t_resultPersonId").attr("keycode", ui.item.value);
                        return false;
                    }
                }).data("ui-autocomplete")._renderItem = function (ul, item) {
                    return $("<li>")
                        .append("<a>" + item.label + "</a>")
                        .appendTo(ul);
                };
            })
        }
    }

    function saveResult() {
        var v_requestDate = $("#t_resultTime").val();
        v_requestDate = v_requestDate.replace('T','');
        var ppid = $("#id").val();
        if(ppid!=""){
            $("#t_resultPersonId").val("${rewards.rewordPersonId}");
            $("#t_resultPersonId").attr("keycode", "${rewards.rewordPersonDeptId}");
        }
        if( $("#t_resultObject option:selected").val() =="" ||  $("#t_resultObject option:selected").val() =="0" || $("#t_resultObject option:selected").val() == undefined){
            swal({
                title: "请选择成果对象！",
                type: "info"
            });
            return;
        }
        if($("#t_resultType option:selected").val()=="" ||  $("#t_resultType option:selected").val() =="0" || $("#t_resultType option:selected").val() == undefined){
            swal({
                title: "请选择成果类别！",
                type: "info"
            });
            return;
        }
        if($("#t_resultTime").val()=="" ||  $("#t_resultTime").val() =="0" || $("#t_resultTime").val() == undefined){
            swal({
                title: "请填写成果获得时间！",
                type: "info"
            });
            return;
        }
        if($("#t_resultLevel option:selected").val()=="" ||  $("#t_resultLevel option:selected").val() =="0" || $("#t_resultLevel option:selected").val() == undefined){
            swal({
                title: "选择成果级别级别！",
                type: "info"
            });
            return;
        }
        if($("#t_resultPersonId").val()=="" ||  $("#t_resultPersonId").val() =="0" || $("#t_resultPersonId").val() == undefined){
            swal({
                title: "请填写成果所有人！",
                type: "info"
            });
            return;
        }
        if($("#t_remark").val()=="" ||  $("#t_remark").val() =="0" || $("#t_remark").val() == undefined){
            swal({
                title: "请填写备注！",
                type: "info"
            });
            return;
        }
        var headT = $("#t_resultPersonId").attr("keycode");
        var headTList = headT.split(",");
        $.post("<%=request.getContextPath()%>/teacherResult/saveTeachingResult", {
            id: $("#id").val(),
            resultPersonId: headTList[1],
            resultPersonDeptId: headTList[0],
            resultObject: $("#t_resultObject option:selected").val(),
            resultType: $("#t_resultType option:selected").val(),
            resultLevel: $("#t_resultLevel option:selected").val(),
            resultTime: v_requestDate,
            remark: $("#t_remark").val()
        }, function (msg) {
            if (msg.status == 1 ) {
                swal({title: msg.msg, type: "success"});
                $("#dialog").modal('hide');
                $('#resultGrid').DataTable().ajax.reload();
            }
        })
    }

</script>


