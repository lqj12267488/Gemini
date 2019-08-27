<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width: 650px">
    <form id="dataForm" method="post" enctype="multipart/form-data">
        <div class="modal-content block-fill-white">
            <div class="modal-header">
                <button type="button" class="close" onclick="closedwindow()" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <span style="font-size: 14px">${head}</span>
                <input id="id" name="id" hidden value="${otherWorkload.id}">
                <input name="teacherId" hidden/>
                <input name="deptId" hidden/>
                <input name="time" hidden/>

            </div>
            <div class="modal-body clearfix">
                <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
                <div class="controls" >
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>教师姓名
                        </div>
                        <div class="col-md-9">
                            <input id="teacherId" value="${otherWorkload.nameShow}" keycode="${otherWorkload.deptId},${otherWorkload.teacherId}"/>
                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>工作内容
                        </div>
                        <div class="col-md-9">
                            <input id="f_workContent" name="workContent" type="type"
                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="100" placeholder="最多输入100个字"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${otherWorkload.workContent}"/>
                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>工作时间
                        </div>
                        <div class="col-md-9">
                            <input id="f_time" type="datetime-local"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${otherWorkload.time}"/>
                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>课时数
                        </div>
                        <div class="col-md-9">
                            <input id="f_classHours" name="classHours" type="number"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${otherWorkload.classHours}"/>
                        </div>
                    </div>
                    <div class="form-row">

                        <div class="col-md-3 tar">
                            <span class="iconBtx">*</span>工作量
                        </div>
                        <div class="col-md-9">
                            <input id="f_workload" name="workload" type="type"onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"maxlength="30" placeholder="最多输入30个字"
                                   class="validate[required,maxSize[100]] form-control"
                                   value="${otherWorkload.workload}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            附件上传
                        </div>
                        <div class="col-md-9">
                            <input type="button" name="file" value="点击上传" onclick="addFiles()"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3 tar">
                            附件名称
                        </div>
                        <div class="col-md-9">
                            <span>${filesName}</span>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button id="saveBtn" type="button" class="btn btn-success btn-clean" onclick="saveDept()">保存</button>
                <button type="button" class="btn btn-default btn-clean" data-dismiss="modal" onclick="closedwindow()">关闭</button>
            </div>
        </div>
    </form>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getPersonDept", function (data) {
            $("#teacherId").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#teacherId").val(ui.item.label);
                    $("#teacherId").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>").append("<a>" + item.label + "</a>").appendTo(ul);
            };
        })
    })

    function closedwindow(){
        $("input").removeAttr("readOnly");
    }

    function saveDept() {
        var date = $("#f_time").val();
        date = date.replace('T', '');
        var teacherId = $("#teacherId").attr("keycode").split(",")[1];
        var deptId = $("#teacherId").attr("keycode").split(",")[0];

        $("input[name=teacherId]").val(teacherId);
        $("input[name=deptId]").val(deptId);
        $("input[name=time]").val(date);

        if (teacherId == "" || teacherId == undefined || teacherId == null) {
            swal({
                title: "请填写教师名称！",
                type: "info"
            });
            return;
        }
        if($("#f_workContent").val()=="" ||  $("#f_workContent").val() ==null || $("#f_workContent").val() == undefined){
            swal({
                title: "请填写工作内容！",
                type: "info"
            });
            return;
        }
        if($("#f_time").val()=="" ||  $("#f_time").val() ==null || $("#f_time").val() == undefined){
            swal({
                title: "请填写工作时间！",
                type: "info"
            });
            return;
        }
        if($("#f_classHours").val()=="" ||  $("#f_classHours").val() ==null || $("#f_classHours").val() == undefined){
            swal({
                title: "请填写课时数！",
                type: "info"
            });
            return;
        }
        var reg = /^[0-9]+?[0-9]*$/;
        if(!reg.test($("#f_classHours").val())){
            swal({
                title: "课时数请填写整数！",
                type: "info"
            });
            return;
        }
        if($("#f_workload").val()=="" ||  $("#f_workload").val() ==null || $("#f_workload").val() == undefined){
            swal({
                title: "请填写工作量！",
                type: "info"
            });
            return;
        }

        showSaveLoading();
        var from = new FormData(document.getElementById("dataForm"));
        $.ajax({
            type: "post",
            url: "<%=request.getContextPath()%>/otherWorkload/updateOtherWorkloadById",
            processData: false,  //tell jQuery not to process the data
            contentType: false,  //tell jQuery not to set contentType
            data: from,
            success: function (msg) {
                hideSaveLoading();
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal('hide');
                    $('#otherWorkloadGrid').DataTable().ajax.reload();
                }
            }
        });
    }

</script>
<script type="text/javascript">//多选树z-tree.js数据格式 end

</script>



