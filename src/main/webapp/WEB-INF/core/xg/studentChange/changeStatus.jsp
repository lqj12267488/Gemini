<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">修改</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    学生姓名：
                </div>
                <div class="col-md-4 ">
                    ${student.name}
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    现学籍状态：
                </div>
                <div class="col-md-4 ">
                    ${student.studentStatusShow}
                </div>
            </div>
            <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 人员状态异动：
                </div>
                <div class="col-md-4 ">
                    <select id="studentStatusSelect"  onchange="changeStuStatus(value)"/>
                    <input id="sStatus" value="${student.studentStatus}" hidden >
                </div>
            </div>

            <div class="form-row" id="xx">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 休退学主要原因：
                </div>
                <div class="col-md-4 ">
                    <select id="retireReason" class="validate[required,maxSize[100]] form-control"/>
                </div>
            </div>
            <div class="form-row" id="cx">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 辍学原因：
                </div>
                <div class="col-md-4 ">
                    <select id="dropOutReason" />
                </div>
            </div>
            <div class="form-row" id="dx">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 辍学日期：
                </div>
                <div class="col-md-4 ">
                    <input id="statusDate" type="date" value="${student.statusDate}"/>
                </div>
            </div>
            <div class="form-row" id="bx">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span> 毕业去向：
                </div>
                <div class="col-md-4 ">
                    <select id="graduaDestina">
                        <option value="" selected="selected">请选择</option>
                        <option value="就业">就业</option>
                        <option value="创业">创业</option>
                        <option value="专升本">专升本</option>
                        <option value="留学">留学</option>
                        <option value="参军">参军</option>
                        <option value="正在求职">正在求职</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" id="saveBtn" onclick="updateStatus()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input hidden id="studentId" value="${studentId}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XTXYY", function (data) {
            addOption(data, 'retireReason','${student.retireReason}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=CXYY", function (data) {
            addOption(data, 'dropOutReason','${student.dropOutReason}');
        });

        if ('${flag}'=='0'){
            $("#xx").hide();
            $("#cx").hide();
            $("#dx").hide();
            $("#bx").hide();

        }

        if ('${flag}' == '1'){
            $("#xx").show();
            $("#cx").hide();
            $("#dx").hide();
            $("#bx").hide();

        }
        if ('${flag}' == '2'){
            $("#xx").hide();
            $("#cx").show();
            $("#dx").show();
            $("#bx").hide();

        }
        if ('${flag}' == '3'){
            $("#xx").show();
            $("#cx").show();
            $("#dx").show();
            $("#bx").hide();
        }
        if ('${flag}' == '4'){
            $("#xx").hide();
            $("#cx").hide();
            $("#dx").hide();
            $("#bx").show();
        }

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XSZT", function (data) {
            addOption(data, 'studentStatusSelect','${student.studentStatus}');
        });
        $("#graduaDestina").val("${student.graduaDestina}");
    });

    function changeStuStatus(value){
    
        /**
         * value = 2,5
         */
        if (value == 2 || value ==5 ){
            $("#xx").show();
            $("#cx").hide();
            $("#dx").hide();
            $("#bx").hide();

        }else if (value == 12 && '${student.studentStatus}'!= 12 && '${student.studentStatus}'!= 2 && '${student.studentStatus}'!= 5){
            $("#xx").hide();
            $("#cx").show();
            $("#dx").show();
            $("#bx").hide();

        }else if(value == 12 && ('${student.studentStatus}' == 12 || '${student.studentStatus}' == 2 || '${student.studentStatus}' == 5)){
            $("#xx").show();
            $("#cx").show();
            $("#dx").show();
            $("#bx").hide();

        } else if(value == 6 && '${student.studentStatus}'!= 6 && '${student.studentStatus}'!= 2 && '${student.studentStatus}'!= 5){
            $("#xx").hide();
            $("#cx").hide();
            $("#dx").hide();
            $("#bx").show();

        }else{
            $("#xx").hide();
            $("#cx").hide();
            $("#dx").hide();
            $("#bx").hide();
        }
    }

    function updateStatus() {
        var staffStatus = $("#studentStatusSelect option:selected").val();
        if(null == staffStatus || staffStatus ==""){
            swal({
                title: "请选择人员状态!",
                type: "info"
            });
            return;
        }
        if( staffStatus ==$("#sStatus").val()){
            if (staffStatus == "2" || staffStatus == "5" || staffStatus == "12"||staffStatus == "6"){
                if (staffStatus == "2"|| staffStatus == "5"){
                    if ($("#retireReason").val() == undefined || '' == $("#retireReason").val()) {
                        swal({
                            title: "请选择休退学原因!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (staffStatus == "12") {
                    if ($("#dropOutReason").val() == undefined || '' == $("#dropOutReason").val()) {
                        swal({
                            title: "请选择辍学原因!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (staffStatus == "12") {
                    if ($("#statusDate").val() == undefined || '' == $("#statusDate").val()) {
                        swal({
                            title: "请填写辍学日期!",
                            type: "info"
                        });
                        return;
                    }
                }
                if (staffStatus == "6") {
                    if ($("#graduaDestina").val() == undefined || '' == $("#graduaDestina").val()) {
                        swal({
                            title: "请填写毕业去向!",
                            type: "info"
                        });
                        return;
                    }
                }

                $.post('<%=request.getContextPath()%>/studentChangeLog/updateReason', {
                    studentId: $('#studentId').val(),
                    retireReason: $("#retireReason").val(),
                    dropOutReason: $("#dropOutReason").val(),
                    statusDate:$("#statusDate").val(),
                    graduaDestina:$("#graduaDestina").val()
                }, function (msg) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal("hide");
                    $('#studentChangeGrid').DataTable().ajax.reload();
                })
            } else {
            swal({
                title: "请更改人员状态!",
                type: "info"
            });
            return;
            }
        }else {
            showSaveLoading();
            $.post('<%=request.getContextPath()%>/studentChangeLog/updateStatus', {
                studentId: $('#studentId').val(),
                studentStatus: staffStatus,
                retireReason: $("#retireReason").val(),
                dropOutReason: $("#dropOutReason").val(),
                statusDate:$("#statusDate").val(),
                graduaDestina:$("#graduaDestina").val()
            }, function (msg) {
                hideSaveLoading();
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal("hide");
                $('#studentChangeGrid').DataTable().ajax.reload();
            })
        }
    }
</script>