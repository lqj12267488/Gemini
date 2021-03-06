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
<div class="modal-dialog" style="width: 1100px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px;">${head}&nbsp;</span>
            <input id="id" hidden value="${data.personId}"/>
        </div>
        <div class="modal-body clearfix">
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        姓名
                    </div>
                    <div class="col-md-3">
                        <input id="nameEdit" value="${data.name}" class="validate[required,maxSize[20]] form-control"
                               readonly/>
                    </div>
                    <div class="col-md-2 tar">
                        部门
                    </div>
                    <div class="col-md-3">
                        <input id="deptIdEdit" value="${data.deptShow}"
                               class="validate[required,maxSize[20]] form-control" readonly/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        证件号
                    </div>
                    <div class="col-md-3">
                        <input id="idcardEdit" value="${data.idcard}"
                               class="validate[required,maxSize[20]] form-control" readonly/>
                    </div>
                </div>
                <div id="data">
                    <div id="syq">
                        <div class="form-row">
                            试用期
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                开始时间
                            </div>
                            <div class="col-md-2">
                                <input id="syStartTimeEdit" type="date" value="${data.syStartTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2 tar">
                                截止时间
                            </div>
                            <div class="col-md-2">
                                <input id="syEndTimeEdit" type="date" value="${data.syEndTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                试用期限
                            </div>
                            <div class="col-md-2">
                                <select id="syContractPeriodEdit" value="${data.syContractPeriod}"
                                        class="validate[required,maxSize[20]] form-control">
                                    <option value="" selected>请选择</option>
                                    <option value="1月">1月</option>
                                    <option value="2月">2月</option>
                                    <option value="3月">3月</option>
                                </select>
                            </div>

                            <div class="col-md-2 tar">
                                转正日期
                            </div>
                            <div class="col-md-2">
                                <input id="positiveTimeEdit" type="date" value="${data.positiveTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                    </div>
                    <div id="ldht">
                        <div class="form-row">
                            劳动合同
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                第一次签订开始日期
                            </div>
                            <div class="col-md-2">
                                <input id="firstStartTimeEdit" type="date" value="${data.firstStartTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                第一次签订截止日期
                            </div>
                            <div class="col-md-2">
                                <input id="firstEndTimeEdit" type="date" value="${data.firstEndTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                合同期限
                            </div>
                            <div class="col-md-2">
                                <select id="firstContractPeriodEdit" type="date"
                                        class="validate[required,maxSize[20]] form-control">
                                    <option value="" selected>请选择</option>
                                    <option value="1年">1年</option>
                                    <option value="2年">2年</option>
                                    <option value="3年">3年</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                第二次签订开始日期
                            </div>
                            <div class="col-md-2">
                                <input id="secStartTimeEdit" type="date" value="${data.secStartTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                第二次签订截止日期
                            </div>
                            <div class="col-md-2">
                                <input id="secEndTimeEdit" type="date" value="${data.secEndTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                合同期限
                            </div>
                            <div class="col-md-2">
                                <select id="secContractPeriodEdit" type="date"
                                        class="validate[required,maxSize[20]] form-control">
                                    <option value="" selected>请选择</option>
                                    <option value="1年">1年</option>
                                    <option value="2年">2年</option>
                                    <option value="3年">3年</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-md-2 tar">
                                第三次签订开始日期
                            </div>
                            <div class="col-md-2">
                                <input id="thirdStartTimeEdit" type="date" value="${data.thirdStartTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                第三次签订截止日期
                            </div>
                            <div class="col-md-2">
                                <input id="thirdEndTimeEdit" type="date" value="${data.thirdEndTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                合同期限
                            </div>
                            <div class="col-md-2">
                                <select id="thirdContractPeriodEdit" type="date"
                                        class="validate[required,maxSize[20]] form-control">
                                    <option value="">请选择</option>
                                    <option value="1年">1年</option>
                                    <option value="2年">2年</option>
                                    <option value="3年">3年</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div id="jzxy">
                        <div class="form-row">
                            兼职协议
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                开始时间
                            </div>
                            <div class="col-md-2">
                                <input id="jzStartTimeEdit" type="date" value="${data.jzStartTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2 tar">
                                截止时间
                            </div>
                            <div class="col-md-2">
                                <input id="jzEndTimeEdit" type="date" value="${data.jzEndTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2 tar">
                                协议期限
                            </div>
                            <div class="col-md-2"><select id="jzContractPeriodEdit"
                                                          class="validate[required,maxSize[20]] form-control">
                                <option value="" selected>请选择</option>
                                <option value="6月">6月</option>
                                <option value="1年">1年</option>
                                <option value="2年">2年</option>
                            </select>

                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                人员性质
                            </div>
                            <div class="col-md-2">
                                <select id="personNatureEdit" class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                退休证明
                            </div>
                            <div class="col-md-2">
                                <input id="retireCertEdit" value="${data.retireCert}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                份数
                            </div>
                            <div class="col-md-2">
                                <input id="numsEdit" value="${data.nums}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-md-2 tar">
                                校龄
                            </div>
                            <div class="col-md-2">
                                <input id="schoolAgeEdit" value="${data.schoolAge}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                保密协议
                            </div>
                            <div class="col-md-2">
                                <select id="confidentAgreementEdit" class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2 tar">
                                试用期工资
                            </div>
                            <div class="col-md-2">
                                <input id="trpidSalaryEdit" value="${data.trpidSalary}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                转正工资
                            </div>
                            <div class="col-md-2">
                                <input id="positiveSalaryEdit" value="${data.positiveSalary}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2 tar">
                                转正系数
                            </div>
                            <div class="col-md-2">
                                <input id="positiveCoffEdit" value="${data.positiveCoff}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-2 tar">
                                离职日期
                            </div>
                            <div class="col-md-2">
                                <input id="retireTimeEdit" type="date" value="${data.retireTime}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
                    </div>
                    <div id="welfare">
                        <div class="form-row">
                            保险福利
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                退休
                            </div>
                            <div class="col-md-2">
                                <select id="retireNyEdit" class="validate[required,maxSize[20]] form-control">

                                </select>
                            </div>
                            <div class="col-md-2 tar">
                                社保号
                            </div>
                            <div class="col-md-2">
                                <input id="ssnumberEdit" value="${data.ssnumber}"
                                       class="validate[required,maxSize[20]] form-control" onblur="ssnumberChange()"/>
                            </div>
                            <div class="col-md-2 tar">
                                数量
                            </div>
                            <div class="col-md-2">
                                <input id="countsEdit" value="${data.counts}"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>
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
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSHT", function (data) {
            addOption(data, 'contractTypeEdit', '${data.contractType}');
            $("#syContractPeriodEdit").val("${data.syContractPeriod}")
            $("#firstContractPeriodEdit").val("${data.firstContractPeriod}")
            $("#secContractPeriodEdit").val("${data.secContractPeriod}")
            $("#thirdContractPeriodEdit").val("${data.thirdContractPeriod}")
            $("#jzContractPeriodEdit").val("${data.jzContractPeriod}");
            $("#retireNyEdit").val("${data.retireNy}");
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=RYXZ", function (data) {
            addOption(data, 'personNatureEdit', '${data.personNature}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'retireNyEdit', '${data.retireNy}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=YW", function (data) {
            addOption(data,'confidentAgreementEdit','${data.confidentAgreement}');
        })

        if ("${seeFlag}" == "1") {
            $("#save").hide();
            $("#data input").attr("readonly", "readonly")
            $("#data select").attr("disabled", "disabled")
        } else {
            $("#data input").removeAttr("readonly")
            $("#data select").removeAttr("disabled")
        }
    });

    function save() {
        $.post("<%=request.getContextPath()%>/TeacherContract/saveTeacherContract", {
            personId: "${data.personId}",
            syStartTime: $("#syStartTimeEdit").val(),
            syEndTime: $("#syEndTimeEdit").val(),
            syContractPeriod: $("#syContractPeriodEdit").val(),
            positiveTime: $("#positiveTimeEdit").val(),
            firstStartTime: $("#firstStartTimeEdit").val(),
            firstEndTime: $("#firstEndTimeEdit").val(),
            firstContractPeriod: $("#firstContractPeriodEdit").val(),
            secStartTime: $("#secStartTimeEdit").val(),
            secEndTime: $("#secEndTimeEdit").val(),
            secContractPeriod: $("#secContractPeriodEdit").val(),
            thirdStartTime: $("#thirdStartTimeEdit").val(),
            thirdEndTime: $("#thirdEndTimeEdit").val(),
            thirdContractPeriod: $("#thirdContractPeriodEdit").val(),
            jzStartTime: $("#jzStartTimeEdit").val(),
            jzEndTime: $("#jzEndTimeEdit").val(),
            jzContractPeriod: $("#jzContractPeriodEdit").val(),
            personNature: $("#personNatureEdit").val(),
            retireCert: $("#retireCertEdit").val(),
            nums: $("#numsEdit").val(),
            schoolAge: $("#schoolAgeEdit").val(),
            confidentAgreement: $("#confidentAgreementEdit").val(),
            trpidSalary: $("#trpidSalaryEdit").val(),
            positiveSalary: $("#positiveSalaryEdit").val(),
            positiveCoff: $("#positiveCoffEdit").val(),
            retireTime: $("#retireTimeEdit").val(),
            retireNy: $("#retireNyEdit").val(),
            ssnumber: $("#ssnumberEdit").val(),
            counts: $("#countsEdit").val(),
        }, function (msg) {
            swal({
                title: msg.msg,
                type: "success"
            }, function () {
                $("#dialog").modal('hide');
                $('#table').DataTable().ajax.reload();
            });
        });
    }
    function ssnumberChange() {
        if ($("#ssnumberEdit").val() != '' && $("#ssnumberEdit").val() != undefined) {
            if ($("#countsEdit").val() == '' || $("#countsEdit").val() == undefined) {
                $("#countsEdit").val("1");
            }
        }
    }
</script>



