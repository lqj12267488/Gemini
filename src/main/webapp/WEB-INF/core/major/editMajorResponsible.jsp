<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<style>
</style>

<div class="modal-dialog" style="width: 800px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">新增</h4>
        </div>
        <div class="modal-body clearfix" style="font-size: 15px;">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <div class="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-4">
                        <input id="person" type="text" value="${mm.personIdShow}"/>
                        <input id="perId" type="hidden" value="${mm.personId}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>性别
                    </div>
                    <div class="col-md-4">
                        <select id="sex" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>出生日期
                    </div>
                    <div class="col-md-4">
                        <input id="birthday" type="date" value="${mm.birthday}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学历
                    </div>
                    <div class="col-md-4">
                        <select id="nationality" class="js-example-basic-single"></select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学位
                    </div>
                    <div class="col-md-4">
                        <select id="xuewei" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 工作单位名称（全称）
                    </div>
                    <div class="col-md-4">
                        <input id="danwei" type="text" value="${mm.workDept}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>所属系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" onchange="changeMajor()"/>
                    </div>

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业名称
                    </div>
                    <div class="col-md-4">
                        <select onchange="fillMajorCode()" id="majorid"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业代码
                    </div>
                    <div class="col-md-4">
                        <input id="staffId" readonly type="text" value="${mm.majorCode}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教师性质
                    </div>
                    <div class="col-md-4">
                        <select id="teacherCategory"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教工号
                    </div>
                    <div class="col-md-4">
                        <input id="jiaogonghao" type="text" value="${mm.teacherNum}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>职务
                    </div>
                    <div class="col-md-4">
                        <input id="zhiwu" type="text" value="${mm.position}"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>区号-固定电话
                    </div>
                    <div class="col-md-4">
                        <input id="guhua" type="text" value="${mm.guhua}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 担任专业负责人年限
                    </div>
                    <div class="col-md-4">
                        <input id="nianxian" type="text" value="${mm.zyWorkdate}"/>
                    </div>
                </div>
                <div class="form-row">

                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 电子邮箱
                    </div>
                    <div class="col-md-10">
                        <input id="youxiang" type="text" value="${mm.email}"/>
                    </div>
                </div>

                <div class="form-row" style="border: #0A0B0C solid 1px;padding-bottom: 10px">
                    <div class="form-row" style="text-align: center">
                        专业技术职务（最高）
                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>等级
                        </div>
                        <div class="col-md-4">
                            <input id="dengji2" type="text" value="${mm.positionLeave}"/>
                        </div>
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>名称（全称）
                        </div>
                        <div class="col-md-4">
                            <input id="quancheng" type="text" value="${mm.positionName}"/>
                        </div>

                    </div>
                    <div class="form-row">
                        <div class="col-md-2 tar">
                            <span class="iconBtx">*</span>发证机关
                        </div>
                        <div class="col-md-4">
                            <input id="fazheng" type="text" value="${mm.office}"/>
                        </div>
                        <div class="col-md-2 tar">
                            获得时间
                        </div>
                        <div class="col-md-4">
                            <input id="shijian2" type="date" value="${mm.positionDate}"/>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div class="modal-footer">
            <button type="button" id="saveBtn" class="btn btn-success btn-clean" onclick="saveEmp()">保存</button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
</div>
<input id="mid" type="text" hidden value="${mm.id}">
<input id="did" hidden value="${mm.departmentsId}">
<input id="personType" hidden value="${personType}">
<script>
    $("#layout").load("<%=request.getContextPath()%>/common/commonSaveLoading");
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'nationality', '${mm.education}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XW", function (data) {
            addOption(data, 'xuewei', '${mm.degree}');
        });

        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    autoFillOtherMsg(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsId', '${mm.departmentsId}');
        });

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XB", function (data) {
            addOption(data, 'sex', '${mm.sex}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=JSLB", function (data) {
            addOption(data, 'teacherCategory', '${mm.teacherCategory}');
        });

        if ($("#did").val() != null && $("#did").val() != "") {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " major_id",
                    text: " major_name ",
                    tableName: "T_XG_MAJOR",
                    where: " WHERE departments_id =" + $("#did").val()
                },
                function (data) {
                    addOption(data, "majorid", '${mm.majorId}');
                });
        }
    });

    function fillMajorCode() {
        $.post("/major/getMajorById", {
            id: $("#majorid").val()
        }, function (res) {
            $("#staffId").val(res.majorCode);
        })
    }

    function autoFillOtherMsg(id) {
        $.post("/majorLeader/getTeacherById", {
            tid:id
        }, function (res) {
            $("#jiaogonghao").val(res.TEACHERNUM);
            $("#sex").val(res.TEACHERSEX);
            $("#birthday").val(res.BIRTHDAY);
        });
    }

    function changeMajor() {
        var deptId = $("#departmentsId").val();
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " major_id",
                text: " major_name ",
                tableName: "T_XG_MAJOR",
                where: " WHERE departments_id =" + deptId
            },
            function (data) {
                addOption(data, "majorid", '${mm.majorId}');
            });
    }


    function saveEmp() {
        if ($("#perId").val() == "" || $("#perId").val() == undefined || $("#perId").val() == null) {
            swal({
                title: "请填写人员姓名",
                type: "info"
            });
            return;
        }
        if ($("#sex option:selected").val() == "" || $("#sex option:selected").val() == null) {
            swal({
                title: "请选择人员性别",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#birthday").val() == "" || $("#birthday").val() == null) {
            swal({
                title: "请选择出生日期",
                type: "info"
            });
            //alert("请选择人员出生日期");
            return;
        }
        var myDate = new Date();
        var nowTime = myDate.getTime();
        var birthday = new Date($("#birthday").val()).getTime();
        if (birthday > nowTime) {
            swal({
                title: "出生日期不可晚于当前日期",
                type: "info"
            });
            return;
        }


        if ($("#nationality").val() == "" || $("#nationality").val() == null) {
            swal({
                title: "请选择学历",
                type: "info"
            });
            return;
        }
        if ($("#xuewei").val() == "" || $("#xuewei").val() == null) {
            swal({
                title: "请选择学位",
                type: "info"
            });
            return;
        }
        if ($("#danwei").val() == "" || $("#danwei").val() == null) {
            swal({
                title: "请填写工作单位名称",
                type: "info"
            });
            return;
        }
        if ($("#departmentsId").val() == "" || $("#departmentsId").val() == null) {
            swal({
                title: "请选择系部",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#majorid").val() == "" || $("#majorid").val() == null) {
            swal({
                title: "请选择专业",
                type: "info"
            });
            //alert("请填写身份证号码");
            return;
        }
        if ($("#staffId").val() == "" || $("#staffId").val() == null) {
            swal({
                title: "请填写专业代码",
                type: "info"
            });
            return;
        }
        if ($("#teacherCategory").val() == "" || $("#teacherCategory").val() == null) {
            swal({
                title: "请选择教师性质",
                type: "info"
            });
            return;
        }

        if ($("#jiaogonghao").val() == "" || $("#jiaogonghao").val() == null) {
            swal({
                title: "请填写教工号",
                type: "info"
            });
            return;
        }
        if ($("#zhiwu").val() == "" || $("#zhiwu").val() == null) {
            swal({
                title: "请填写职务",
                type: "info"
            });
            return;
        }
        if ($("#guhua").val() == "" || $("#guhua").val() == null) {
            swal({
                title: "请填写固定电话",
                type: "info"
            });
            return;
        }
        if ($("#nianxian").val() == "" || $("#nianxian").val() == null) {
            swal({
                title: "请填写担任专业负责人年限",
                type: "info"
            });
            return;
        }
        if ($("#youxiang").val() == "" || $("#youxiang").val() == null) {
            swal({
                title: "请填写邮箱",
                type: "info"
            });
            return;
        }

        if ($("#dengji2").val() == "" || $("#dengji2").val() == null) {
            swal({
                title: "请填写等级",
                type: "info"
            });
            return;
        }
        if ($("#quancheng").val() == "" || $("#quancheng").val() == null) {
            swal({
                title: "请填写名称（全称）",
                type: "info"
            });
            return;
        }

        if ($("#fazheng").val() == "" || $("#fazheng").val() == null) {
            swal({
                title: "请填写发证机关",
                type: "info"
            });
            return;
        }
        showSaveLoading();
        $.post("<%=request.getContextPath()%>/majorResponsible/saveMajorResponsible", {
            id: $("#mid").val(),
            personId: $("#perId").val(),
            sex: $("#sex option:selected").val(),
            birthday: $("#birthday").val(),
            education: $("#nationality").val(),
            degree: $("#xuewei").val(),
            workDept: $("#danwei").val(),
            departmentsId: $("#departmentsId").val(),
            majorId: $("#majorid").val(),
            majorCode: $("#staffId").val(),
            teacherCategory: $("#teacherCategory").val(),
            teacherNum: $("#jiaogonghao").val(),
            position: $("#zhiwu").val(),
            guhua: $("#guhua").val(),
            zyWorkdate: $("#nianxian").val(),
            email: $("#youxiang").val(),
            positionLeave: $("#dengji2").val(),
            positionName: $("#quancheng").val(),
            office: $("#fazheng").val(),
            positionDate: $("#shijian2").val(),


        }, function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal("hide");
                if ($("#personType").val() == "1") {
                    /*mltable.ajax.reload();*/
                    $('#mltable').DataTable().ajax.reload();
                } else if ($("#personType").val() == "2") {
                    /*mrtable.ajax.reload();*/
                    $('#mrtable').DataTable().ajax.reload();
                } else {
                    $('#mmtable').DataTable().ajax.reload();
                    /*mmtable.ajax.reload();*/
                }
            }
        })
    }
</script>