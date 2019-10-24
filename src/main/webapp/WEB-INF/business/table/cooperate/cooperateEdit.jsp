<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <style type="text/css">
        textarea {
            resize: none;
        }
    </style>
</head>
<div class="modal-dialog">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                <div class="col-md-3 tar">
                    <span class="iconBtx">*</span>专业名称
                </div>
                <div class="col-md-9" id="divId">
                    <%--<input id="mojorNameEdit" value="${data.mojorName}"/>--%>
                </div>
                <div class="form-row">
                </div>

                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>共同开发课程数（门）
                    </div>
                    <div class="col-md-9">
                        <input id="developmentcoursenumEdit" value="${data.developmentcoursenum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>共同开发教材数（种）
                    </div>
                    <div class="col-md-9">
                        <input id="developmentteachingnumEdit" value="${data.developmentteachingnum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>支持学校兼职教师数（人）
                    </div>
                    <div class="col-md-9">
                        <input id="parttimeteachernumEdit" value="${data.parttimeteachernum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>接受顶岗实习学生数（人）
                    </div>
                    <div class="col-md-9">
                        <input id="traineenumEdit" value="${data.traineenum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>对学校捐赠设备总值（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="equipmentmoneyEdit" value="${data.equipmentmoney}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>对学校准捐赠设备总值(万元)
                    </div>
                    <div class="col-md-9">
                        <input id="quasidonationmoneyEdit" value="${data.quasidonationmoney}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>接受毕业生就业数（人）
                    </div>
                    <div class="col-md-9">
                        <input id="employmentnumberEdit" value="${data.employmentnumber}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校为企业技术服务年收入（万元）
                    </div>
                    <div class="col-md-9">
                        <input id="annualincomeEdit" value="${data.annualincome}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>学校为企业年培训员工数（人天）
                    </div>
                    <div class="col-md-9">
                        <input id="employeesnumEdit" value="${data.employeesnum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>企业1合作开始日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="business1starttimeEdit" value="${data.business1starttimeStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>企业2合作开始日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="business2starttimeEdit" value="${data.business2starttimeStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>企业3合作开始日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="business3starttimeEdit" value="${data.business3starttimeStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>企业4合作开始日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="business4starttimeEdit" value="${data.business4starttimeStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>企业5合作开始日期（年月）
                    </div>
                    <div class="col-md-9">
                        <input type="date" id="business5starttimeEdit" value="${data.business5starttimeStr}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>是否合作开展学徒制专业
                    </div>
                    <div class="col-md-9">
                        <%--<input id="apprenticeshipEdit" value="${data.apprenticeship}"/>--%>
                        <select id="apprenticeshipEdit">
                            <option value="是">是</option>
                            <option value="否">否</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>产学合作企业总数(个)
                    </div>
                    <div class="col-md-9">
                        <input id="centerprisenumEdit" value="${data.centerprisenum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-3 tar">
                        <span class="iconBtx">*</span>订单培养总数（人）
                    </div>
                    <div class="col-md-9">
                        <input id="culturenumEdit" value="${data.culturenum}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $("#apprenticeshipEdit").val("${data.apprenticeship}");

        $.ajax({
            url:"<%=request.getContextPath()%>/cooperate/selectMajorName",
            type:"post",
            dataType:"json",
            success:function (msg) {
               var div =  document.getElementById("divId");
               var divHtmlCode = "<select id='mojorNameEdit'>";
                for (var i = 0;i<msg.length;i++){
                    divHtmlCode += "<option value='"+msg[i]+"'>"+msg[i]+"</option>";
                }
                divHtmlCode +="</select>";
                div.innerHTML = divHtmlCode;
                $("#mojorNameEdit").val("${data.MAJORNAME}");
            }
        });

    });

    function save() {
        if ($("#mojorNameEdit").val() == "" || $("#mojorNameEdit").val() == undefined || $("#mojorNameEdit").val() == null) {
            swal({
                title: "请选择专业名称！",
                type: "warning"
            });
            return;
        }
        if ($("#developmentcoursenumEdit").val() == "" || $("#developmentcoursenumEdit").val() == undefined || $("#developmentcoursenumEdit").val() == null) {
            swal({
                title: "请填写共同开发课程数（门）！",
                type: "warning"
            });
            return;
        }
        if ($("#developmentteachingnumEdit").val() == "" || $("#developmentteachingnumEdit").val() == undefined || $("#developmentteachingnumEdit").val() == null) {
            swal({
                title: "请填写共同开发教材数（种）！",
                type: "warning"
            });
            return;
        }
        if ($("#parttimeteachernumEdit").val() == "" || $("#parttimeteachernumEdit").val() == undefined || $("#parttimeteachernumEdit").val() == null) {
            swal({
                title: "请填写支持学校兼职教师数（人）！",
                type: "warning"
            });
            return;
        }
        if ($("#traineenumEdit").val() == "" || $("#traineenumEdit").val() == undefined || $("#traineenumEdit").val() == null) {
            swal({
                title: "请填写接受顶岗实习学生数（人）！",
                type: "warning"
            });
            return;
        }
        if ($("#equipmentmoneyEdit").val() == "" || $("#equipmentmoneyEdit").val() == undefined || $("#equipmentmoneyEdit").val() == null) {
            swal({
                title: "请填写对学校捐赠设备总值（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#quasidonationmoneyEdit").val() == "" || $("#quasidonationmoneyEdit").val() == undefined || $("#quasidonationmoneyEdit").val() == null) {
            swal({
                title: "请填写对学校准捐赠设备总值(万元)！",
                type: "warning"
            });
            return;
        }
        if ($("#employmentnumberEdit").val() == "" || $("#employmentnumberEdit").val() == undefined || $("#employmentnumberEdit").val() == null) {
            swal({
                title: "请填写接受毕业生就业数（人）！",
                type: "warning"
            });
            return;
        }
        if ($("#annualincomeEdit").val() == "" || $("#annualincomeEdit").val() == undefined || $("#annualincomeEdit").val() == null) {
            swal({
                title: "请填写学校为企业技术服务年收入（万元）！",
                type: "warning"
            });
            return;
        }
        if ($("#employeesnumEdit").val() == "" || $("#employeesnumEdit").val() == undefined || $("#employeesnumEdit").val() == null) {
            swal({
                title: "请填写学校为企业年培训员工数（人天）！",
                type: "warning"
            });
            return;
        }
        if ($("#business1starttimeEdit").val() == "" || $("#business1starttimeEdit").val() == undefined || $("#business1starttimeEdit").val() == null) {
            swal({
                title: "请填写企业1合作开始日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#business2starttimeEdit").val() == "" || $("#business2starttimeEdit").val() == undefined || $("#business2starttimeEdit").val() == null) {
            swal({
                title: "请填写企业2合作开始日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#business3starttimeEdit").val() == "" || $("#business3starttimeEdit").val() == undefined || $("#business3starttimeEdit").val() == null) {
            swal({
                title: "请填写企业3合作开始日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#business4starttimeEdit").val() == "" || $("#business4starttimeEdit").val() == undefined || $("#business4starttimeEdit").val() == null) {
            swal({
                title: "请填写企业4合作开始日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#business5starttimeEdit").val() == "" || $("#business5starttimeEdit").val() == undefined || $("#business5starttimeEdit").val() == null) {
            swal({
                title: "请填写企业5合作开始日期（年月）！",
                type: "warning"
            });
            return;
        }
        if ($("#apprenticeshipEdit").val() == "" || $("#apprenticeshipEdit").val() == undefined || $("#apprenticeshipEdit").val() == null) {
            swal({
                title: "请填写是否合作开展学徒制专业！",
                type: "warning"
            });
            return;
        }
        if ($("#centerprisenumEdit").val() == "" || $("#centerprisenumEdit").val() == undefined || $("#centerprisenumEdit").val() == null) {
            swal({
                title: "请填写产学合作企业总数(个)！",
                type: "warning"
            });
            return;
        }
        if ($("#culturenumEdit").val() == "" || $("#culturenumEdit").val() == undefined || $("#culturenumEdit").val() == null) {
            swal({
                title: "请填写订单培养总数（人）！",
                type: "warning"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/cooperate/saveCooperate", {
            id: "${data.id}",
            MAJORNAME:$("#mojorNameEdit").val(),
            developmentcoursenum: $("#developmentcoursenumEdit").val(),
            developmentteachingnum: $("#developmentteachingnumEdit").val(),
            parttimeteachernum: $("#parttimeteachernumEdit").val(),
            traineenum: $("#traineenumEdit").val(),
            equipmentmoney: $("#equipmentmoneyEdit").val(),
            quasidonationmoney: $("#quasidonationmoneyEdit").val(),
            employmentnumber: $("#employmentnumberEdit").val(),
            annualincome: $("#annualincomeEdit").val(),
            employeesnum: $("#employeesnumEdit").val(),
            business1starttime: $("#business1starttimeEdit").val(),
            business2starttime: $("#business2starttimeEdit").val(),
            business3starttime: $("#business3starttimeEdit").val(),
            business4starttime: $("#business4starttimeEdit").val(),
            business5starttime: $("#business5starttimeEdit").val(),
            apprenticeship: $("#apprenticeshipEdit").val(),
            centerprisenum: $("#centerprisenumEdit").val(),
            culturenum: $("#culturenumEdit").val(),
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        })
    }
</script>



