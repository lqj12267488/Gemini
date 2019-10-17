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
<div class="modal-dialog" style="width: 900px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.id}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls" id="data">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>基地名称
                    </div>
                    <div class="col-md-4">
                        <input id="opraNameEdit" value="${data.opraName}"  class="validate[required,maxSize[20]] form-control"/>
                    </div>

                    <div class="col-md-2 tar">
                        建立日期
                    </div>
                    <div class="col-md-4">
                        <input id="buildTimeEdit" value="${data.buildTime}" type="date"  class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    依托单位:
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        名称
                    </div>
                    <div class="col-md-4">
                        <input id="opraUnitEdit" value="${data.opraUnit}"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        在岗职工总数
                    </div>
                    <div class="col-md-4">
                        <input id="opraEmpNumEdit" value="${data.opraEmpNum}"
                               class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>

                <div class="form-row">
                    面向专业:
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        总数
                    </div>
                    <div class="col-md-4">
                        <input id="opraMajorNumEdit" value="${data.opraMajorNum}"  class="validate[required,maxSize[20]] form-control" placeholder="单位:个"/>
                    </div>
                    <div class="col-md-2 tar">
                        主要专业
                    </div>
                    <div class="col-md-4">
                        <input id="mainOpraMajorEdit" value="${data.mainOpraMajor}"  class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>

                <div class="form-row">
                    实习实训项目
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        总数
                    </div>
                    <div class="col-md-4">
                        <input id="opraProNumEdit" value="${data.opraProNum}"  class="validate[required,maxSize[20]] form-control"
                               placeholder="单位：个"/>
                    </div>
                    <div class="col-md-2 tar">
                        主要项目
                    </div>
                    <div class="col-md-4">
                        <input id="opraProNameEdit" value="${data.opraProName}"  class="validate[required,maxSize[20]] form-control"
                        placeholder="全称"/>
                    </div>
                </div>
                <br>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        接待学生量
                    </div>
                    <div class="col-md-4">
                        <input id="opraStdNumEdit" value="${data.opraStdNum}"  class="validate[required,maxSize[20]] form-control"
                        placeholder="人次"/>
                    </div>
                    <div class="col-md-2 tar">
                        基地使用天数
                    </div>
                    <div class="col-md-4">
                        <input id="baseUseDayEdit" value="${data.baseUseDay}"  class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        接收半年顶岗实习学生数
                    </div>
                    <div class="col-md-4">
                        <input id="internNumEdit" value="${data.internNum}"  class="validate[required,maxSize[20]] form-control"
                        placeholder="单位：人"/>
                    </div>
                    <div class="col-md-2 tar">
                        是否有住宿条件
                    </div>
                    <div class="col-md-4">
                        <input id="sfDormEdit" value="${data.sfDorm}"  class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        基地是否发放学生实习补贴
                    </div>
                    <div class="col-md-4">
                        <input id="sfSubEdit" value="${data.sfSub}"  class="validate[required,maxSize[20]] form-control">
                    </div>
                    <div class="col-md-2 tar">
                        学校向基地支付专项实习经费
                    </div>
                    <div class="col-md-4">
                        <input id="itnCostEdit" value="${data.itnCost}"  class="validate[required,maxSize[20]] form-control"
                        placeholder="单位：元/生"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        学校派指导教师/学生管理人员
                    </div>
                    <div class="col-md-4">
                        <input id="sendMgeEdit" value="${data.sendMge}"  class="validate[required,maxSize[20]] form-control"/>
                    </div>
                    <div class="col-md-2 tar">
                        接收应届毕业生就业数
                    </div>
                    <div class="col-md-4">
                        <input id="accGradEdit" value="${data.accGrad}"  class="validate[required,maxSize[20]] form-control"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button id="save" type="button" class="btn btn-success btn-clean" onclick="save()">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        if ("${seeFlag}" == "1"){
            $("#data input").attr("readonly","readonly")
            $("#data select").attr("disabled","disabled")
            $("#save").hide();
        }else {
            $("#data input").removeAttr("readonly")
            $("#data select").removeAttr("disabled")
            $("#save").show();
        }
    });

    function save() {
        if ($("#opraNameEdit").val() == "" || $("#opraNameEdit").val() == undefined || $("#opraNameEdit").val() == null) {
            swal({
                title: "请填写基地名称！",
                type: "warning"
            });
            return;
        }

        // if ($("#opraUnitEdit").val() == "" || $("#opraUnitEdit").val() == undefined || $("#opraUnitEdit").val() == null) {
        //     swal({
        //         title: "请填写依托单位	名称！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#opraEmpNumEdit").val() == "" || $("#opraEmpNumEdit").val() == undefined || $("#opraEmpNumEdit").val() == null) {
        //     swal({
        //         title: "请填写在岗职工总数！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#buildTimeEdit").val() == "" || $("#buildTimeEdit").val() == undefined || $("#buildTimeEdit").val() == null) {
        //     swal({
        //         title: "请填写建立日期！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#opraMajorNumEdit").val() == "" || $("#opraMajorNumEdit").val() == undefined || $("#opraMajorNumEdit").val() == null) {
        //     swal({
        //         title: "请填写面向专业总数！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#mainOpraMajorEdit").val() == "" || $("#mainOpraMajorEdit").val() == undefined || $("#mainOpraMajorEdit").val() == null) {
        //     swal({
        //         title: "请填写主要专业！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#opraProNumEdit").val() == "" || $("#opraProNumEdit").val() == undefined || $("#opraProNumEdit").val() == null) {
        //     swal({
        //         title: "请填写实习实训项目	总数！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#opraProNameEdit").val() == "" || $("#opraProNameEdit").val() == undefined || $("#opraProNameEdit").val() == null) {
        //     swal({
        //         title: "请填写主要项目(全称)！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#opraStdNumEdit").val() == "" || $("#opraStdNumEdit").val() == undefined || $("#opraStdNumEdit").val() == null) {
        //     swal({
        //         title: "请填写接待学生量（人次）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#baseUseDayEdit").val() == "" || $("#baseUseDayEdit").val() == undefined || $("#baseUseDayEdit").val() == null) {
        //     swal({
        //         title: "请填写基地使用天数！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#internNumEdit").val() == "" || $("#internNumEdit").val() == undefined || $("#internNumEdit").val() == null) {
        //     swal({
        //         title: "请填写接收半年顶岗实习学生树！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sfDormEdit").val() == "" || $("#sfDormEdit").val() == undefined || $("#sfDormEdit").val() == null) {
        //     swal({
        //         title: "请填写是否有住宿条件！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sfSubEdit").val() == "" || $("#sfSubEdit").val() == undefined || $("#sfSubEdit").val() == null) {
        //     swal({
        //         title: "请填写基地是否方法学生实习补贴！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#itnCostEdit").val() == "" || $("#itnCostEdit").val() == undefined || $("#itnCostEdit").val() == null) {
        //     swal({
        //         title: "请填写学校向基地支付专项实习经费（元/生）！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#sendMgeEdit").val() == "" || $("#sendMgeEdit").val() == undefined || $("#sendMgeEdit").val() == null) {
        //     swal({
        //         title: "请填写学校派指导教师/学生管理人员(人次)！",
        //         type: "warning"
        //     });
        //     return;
        // }
        // if ($("#accGradEdit").val() == "" || $("#accGradEdit").val() == undefined || $("#accGradEdit").val() == null) {
        //     swal({
        //         title: "请填写接收应届毕业生就业数！",
        //         type: "warning"
        //     });
        //     return;
        // }
        $.post("<%=request.getContextPath()%>/OutCampusPra/saveOutCampusPra", {
            id: "${data.id}",
            opraUnit: $("#opraUnitEdit").val(),
            opraEmpNum: $("#opraEmpNumEdit").val(),
            buildTime: $("#buildTimeEdit").val(),
            opraMajorNum: $("#opraMajorNumEdit").val(),
            mainOpraMajor: $("#mainOpraMajorEdit").val(),
            opraProNum: $("#opraProNumEdit").val(),
            opraProName: $("#opraProNameEdit").val(),
            opraStdNum: $("#opraStdNumEdit").val(),
            baseUseDay: $("#baseUseDayEdit").val(),
            internNum: $("#internNumEdit").val(),
            sfDorm: $("#sfDormEdit").val(),
            sfSub: $("#sfSubEdit").val(),
            itnCost: $("#itnCostEdit").val(),
            sendMge: $("#sendMgeEdit").val(),
            accGrad: $("#accGradEdit").val(),
            opraName: $("#opraNameEdit").val(),
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



