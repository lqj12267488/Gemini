<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal-dialog" style="width:700px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">${head}</h4>
        </div>
        <div class="modal-body clearfix">
            <div id="layout"
                 style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <form id="majorForm" action="<%=request.getContextPath()%>/major/saveMajor" method="post"
                      enctype="multipart/form-data">
                    <input id="majorId" hidden value="${major.majorId}" name="majorId"/>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>所属学院
                        </div>
                        <div class="col-md-4">
                            <select id="majorSchool" name="majorSchool" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>所属系部
                        </div>
                        <div class="col-md-4">
                            <select id="departmentsId" name="departmentsId" class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>专业名称
                        </div>
                        <div class="col-md-4">
                            <input id="majorName" name="majorName" type="text" value="${major.majorName}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>专业代码
                        </div>
                        <div class="col-md-4">
                            <input id="majorCode" name="majorCode" type="text" value="${major.majorCode}"
                                   onchange="sameChange()"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>专业方向名称
                        </div>
                        <div class="col-md-4">
                            <input id="majorDirection" name="majorDirection" class="js-example-basic-single"></input>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>专业方向代码
                        </div>
                        <div class="col-md-4">
                            <input id="majorDirectionCode" name="majorDirectionCode" type="text"
                                   value="${major.majorDirectionCode}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>培养层次
                        </div>
                        <div class="col-md-4">
                            <select id="trainingLevel" name="trainingLevel" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>修业年限
                        </div>
                        <div class="col-md-4">
                            <select id="maxyear" name="maxYear" type="text" value=""></select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 tar">
                            批准设置时间
                        </div>
                        <div class="col-md-4">
                            <input id="approvalTime" name="approvalTime" type="month" value="${major.approvalTime}"/>
                        </div>
                        <div class="col-md-2 tar">
                            首次招生时间
                        </div>
                        <div class="col-md-4">
                            <input id="firstRecruitTime" name="firstRecruitTime" type="month"
                                   value="${major.firstRecruitTime}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            停止招生时间
                        </div>
                        <div class="col-md-4">
                            <input id="endtime" name="endRecruittime" type="month" value="${major.endRecruittime}"/>
                        </div>
                        <div class="col-md-2 tar">
                            班级总数
                        </div>
                        <div class="col-md-4">
                            <input id="classNum" name="classNum" type="text" value="${major.classNum}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            重点专业
                        </div>
                        <div class="col-md-4">
                            <select id="focusCourseType" name="focusCourseType"
                                    class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2 tar">
                            特色专业
                        </div>
                        <div class="col-md-4">
                            <select id="uniqueCourseType" name="uniqueCourseType"
                                    class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            现在学徒制试点专业
                        </div>
                        <div class="col-md-4">
                            <select id="majorNow" name="majorNow" class="js-example-basic-single"></select>
                        </div>
                        <div class="col-md-2 tar">
                           国际合作专业
                        </div>
                        <div class="col-md-4">
                            <select id="majorGlobal" name="majorGlobal" class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            订单培养班级数
                        </div>
                        <div class="col-md-4">
                            <input id="ordersClassnum" name="ordersClassnum" type="text"
                                   value="${major.ordersClassnum}"/>
                        </div>
                        <div class="col-md-2 tar">
                                订单培养学生数
                        </div>
                        <div class="col-md-4">
                            <input id="ordersStudentnum" name="ordersStudentnum" type="text"
                                   value="${major.ordersStudentnum}"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>是否招生
                        </div>
                        <div class="col-md-4">
                            <select id="springAutumnFlag" name="springAutumnFlag" class="js-example-basic-single"></select>
                        </div>

                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>是否师范专业
                        </div>
                        <div class="col-md-4">
                            <select id="normalMajor" name="normalMajor" class="js-example-basic-single"></select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>教育形式
                        </div>
                        <div class="col-md-4">
                            <select id="eduform" name="eduform" class="js-example-basic-single">
                                <option value="" selected="selected">请选择</option>
                                <option value="全日制">全日制</option>
                                <option value="非全日制">非全日制</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            专业特点
                        </div>
                        <div class="col-md-10">
                            <textarea name="professionCharact" id="professionCharact" cols="30"
                                      rows="2">${major.professionCharact}</textarea>
                        </div>
                    </div>
                    <%--<div class="form-row">--%>
                    <%--<div class="col-md-2 tar">--%>
                    <%--<span class="iconBtx">*</span>专业设置批文--%>
                    <%--</div>--%>
                    <%--<div class="col-md-10">--%>
                    <%--<input name="file" id="file" type="file"/>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            备注
                        </div>
                        <div class="col-md-10">
                            <textarea name="remark" id="remark" cols="30" rows="2">${major.remark}</textarea>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveMajor()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
            id: " dept_id",
            text: " dept_name ",
            tableName: "T_SYS_DEPT",
            where: " WHERE DEPT_TYPE =8 ",
            orderby: "  "
        }, function (data) {
            addOption(data, "departmentsId", '${major.departmentsId}');
        });
        //学院类型 majorSchool
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XY", function (data) {
            addOption(data, 'majorSchool', '${major.majorSchool}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XYNX", function (data) {
            addOption(data, 'maxyear', '${major.maxYear}');
        });
        //专业学制 schoolSystem
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYXZ", function (data) {
            addOption(data, 'schoolSystem', '${major.schoolSystem}');
        });
        /*//专业方向 majorDirection
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYFX", function (data) {
            addOption(data, 'majorDirection', '${major.majorDirection}');
        });*/
        //培养层次 trainingLevel
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZXZYPYCC", function (data) {
            addOption(data, 'trainingLevel', '${major.trainingLevel}');
        });
        //是否春秋招生 springAutumnFlag
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'springAutumnFlag', '${major.springAutumnFlag}');
            addOption(data, 'majorNow', '${major.majorNow}');
            addOption(data, 'majorGlobal', '${major.majorGlobal}');
        });
        //重点专业 springAutumnFlag
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=ZDZY", function (data) {
            addOption(data, 'focusCourseType', '${major.focusCourseType}');
        });
        //特色专业 springAutumnFlag
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TSZY", function (data) {
            addOption(data, 'uniqueCourseType', '${major.uniqueCourseType}');
        });
        //是否师范专业
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=SF", function (data) {
            addOption(data, 'normalMajor', '${major.normalMajor}');
        });
        if (null != $("#majorId").val() && $("#majorId").val() != "") {
            $("#majorCode").attr("readonly", "readonly");
            $("#majorName").attr("readonly", "readonly");
            /*$("#majorDirection").attr("",);
            $("#trainingLevel").attr("",);*/
        }
        $("#eduform").val("${major.eduform}");
    });

    function checkmajorCode() {
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_name",
                text: " major_code ",
                tableName: " t_xg_major ",
                where: " WHERE valid_flag = '1' and major_name='" + $("#majorName").val() +
                "' and training_level='" + $("#trainingLevel").val() + "' ",
                orderby: " ",
            },
            function (data) {
                if (data != null && data.length != 0) {
                    var code = data[0];
                    $("#majorCode").val(code.text);
                    $("#majorCode").attr("readonly", "readonly");
                } else {
                    $("#majorCode").removeAttr("readonly");
                }
            });
    }

    $("#trainingLevel").blur(function () {
        if ($("#majorName").val() != "" && $("#trainingLevel").val() != "") {
            checkmajorCode();
        } else {
            $("#majorCode").removeAttr("readonly");
        }
    });

    $("#majorName").blur(function () {
        if ($("#majorName").val() != "" && $("#trainingLevel").val() != "") {
            checkmajorCode();
        } else {
            $("#majorCode").removeAttr("readonly");
        }
    });

    function saveMajor() {
        if ($("#majorSchool option:selected").val() == "") {
            swal({
                title: "请填写所属学院！",
                type: "info"
            });
            return;
        }
        if ($("#departmentsId option:selected").val() == "") {
            swal({
                title: "请填写所属系部！",
                type: "info"
            });
            return;
        }
        if ($("#majorName").val() == "") {
            swal({
                title: "请填写专业名称！",
                type: "info"
            });
            return;
        }
        if ($("#majorCode").val() == "") {
            swal({
                title: "请填写专业代码！",
                type: "info"
            });
            return;
        }
        // if ($("#schoolSystem option:selected").val() == "") {
        //     swal({
        //         title: "请选择专业学制！",
        //         type: "info"
        //     });
        //     return;
        // }
        // if ($("#springAutumnFlag option:selected").val() == "") {
        //     swal({
        //         title: "请选择是否春秋招生！",
        //         type: "info"
        //     });
        //     return;
        // }
        // if ($("#majorName").val() == "") {
        //     swal({
        //         title: "请填写专业名称！",
        //         type: "info"
        //     });
        //     return;
        // }
        if ($("#majorDirection option:selected").val() == "") {
            swal({
                title: "请选择专业方向！",
                type: "info"
            });
            return;
        }
        if ($("#majorDirectionCode").val() == "") {
            swal({
                title: "请填写专业方向代码！",
                type: "info"
            });
            return;
        }
        if ($("#trainingLevel option:selected").val() == "") {
            swal({
                title: "请选择培养层次！",
                type: "info"
            });
            return;
        }
        if ($("#maxyear").val() == "" || $("#maxyear").val() == null) {
            swal({
                title: "请选择修业年限！",
                type: "info"
            });
            return;
        }
       /* if ($("#approvalTime").val() == "") {
            swal({
                title: "请填写批准设置时间！",
                type: "info"
            });
            return;
        }
        if ($("#firstRecruitTime").val() == "") {
            swal({
                title: "请选择首次招生时间！",
                type: "info"
            });
            return;
        }*/
        // if ($("#approvalTime").val() < $("#firstRecruitTime").val()) {
        //     swal({
        //         title: "批准设置时间不可在首次招生时间之前！",
        //         type: "info"
        //     });
        //     return;
        // }
       /* if ($("#endtime").val() == "") {
            swal({
                title: "请选择停止招生时间！",
                type: "info"
            });
            return;
        }
        if ($("#firstRecruitTime").val() > $("#endtime").val()) {
            swal({
                title: "首次招生时间不可在停止招生时间之后！",
                type: "info"
            });
            return;
        }
        if ($("#classNum").val() == "") {
            swal({
                title: "请填写班级总数！",
                type: "info"
            });
            return;
        }
        if ($("#focusCourseType option:selected").val() == "") {
            swal({
                title: "请填写重点专业！",
                type: "info"
            });
            return;
        }
        if ($("#uniqueCourseType option:selected").val() == "") {
            swal({
                title: "请填写特色专业！",
                type: "info"
            });
            return;
        }
        if ($("#majorNow option:selected").val() == "" || $("#majorNow option:selected").val() == null) {
            swal({
                title: "请选择现在学徒制试点专业！",
                type: "info"
            });
            return;
        }
        if ($("#majorGlobal option:selected").val() == "" || $("#majorGlobal option:selected").val() == null) {
            swal({
                title: "请选择国际合作专业！",
                type: "info"
            });
            return;
        }
        if ($("#ordersClassnum").val() == "") {
            swal({
                title: "请填写订单培养班级数！",
                type: "info"
            });
            return;
        }
        if (parseInt($("#classNum").val()) <= parseInt($("#ordersClassnum").val())) {
            swal({
                title: "订单培养班级数不能大于班级总数！",
                type: "info"
            });
            return;
        }
        if ($("#ordersStudentnum").val() == "") {
            swal({
                title: "请填写订单培养学生数！",
                type: "info"
            });
            return;
        }
        if (parseInt($("#ordersClassnum").val()) >= parseInt($("#classNum").val())) {
            swal({
                title: "请填写订单培养学生数！",
                type: "info"
            });
            return;
        }
*/
        if ($("#springAutumnFlag option:selected").val() == "" || $("#springAutumnFlag option:selected").val() == null) {
            swal({
                title: "请选择是否招生！",
                type: "info"
            });
            return;
        }
        if ($("#normalMajor option:selected").val() == "" || $("#normalMajor option:selected").val() == null) {
            swal({
                title: "请选择是否师范专业！",
                type: "info"
            });
            return;
        }
        if ($("#eduform").val() == "" || $("#eduform").val() == null) {
            swal({
                title: "请选择教育形式！",
                type: "info"
            });
            return;
        }
      /*  if ($("#professionCharact").val() == "") {
            swal({
                title: "请填写专业特点！",
                type: "info"
            });
            return;
        }*/
        // if ($("#file").val() == "") {
        //     swal({
        //         title: "请填写专业设置批文！",
        //         type: "info"
        //     });
        //     return;
        // }
      /*  if ($("#remark").val() == "") {
            swal({
                title: "请填写备注！",
                type: "info"
            });
            return;
        }*/
        var majorPrincipalList = $("#majorPrincipal").attr("keycode");
        if (typeof (majorPrincipalList) == 'undefined') {
            majorPrincipalList = ',';
        }
        var mPList = majorPrincipalList.split(",");
        var majorLeaderList = $("#majorLeader").attr("keycode");
        if (typeof (majorLeaderList) == 'undefined') {
            majorLeaderList = ',';
        }
        var mLList = majorLeaderList.split(",");
        var from = new FormData(document.getElementById("majorForm"));
        $.post("<%=request.getContextPath()%>/major/checkMajorName", {
            majorId: $("#majorId").val(),
            majorCode: $("#majorCode").val(),
            majorName: $("#majorName").val(),
            trainingLevel: $("#trainingLevel").val(),
            majorDirection: $("#majorDirection option:selected").val(),
            majorDirectionShow: $("#majorDirection option:selected").text(),
            trainingLevelShow: $("#trainingLevel option:selected").text(),
        }, function (msg1) {
            if (msg1.status == 1) {
                alert(msg1.msg);
            } else {
                $.post("<%=request.getContextPath()%>/major/checkMajorCode", {
                    majorId: $("#majorId").val(),
                    majorCode: $("#majorCode").val()
                }, function (msg1) {
                    if (msg1.status == 1) {
                        var al = $("#majorCode").val() + "专业代码已存在"
                        swal({
                            title: al + msg1.msg,
                            type: "error"
                        });
                    } else {
                        $.ajax({
                            type: "post",
                            url: "<%=request.getContextPath()%>/major/saveMajor",
                            processData: false,  //tell jQuery not to process the data
                            contentType: false,  //tell jQuery not to set contentType
                            data: from,
                            success: function (msg) {
                                hideSaveLoading();
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    $("#dialog").modal('hide');
                                    $('#majorGrid').DataTable().ajax.reload();
                                }
                            }
                        });
                        showSaveLoading();
                    }
                })
            }
        });


        function sameChange() {
            var majorCode = $("#majorCode").val();
            document.getElementById("majorDirectionCode").value = majorCode;
        }
    }
</script>