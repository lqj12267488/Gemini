<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/25
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="/libs/css/stylesheets.css" rel="stylesheet" type="text/css">
<style>
</style>

<div class="modal-dialog" style="width: 62%;height: 60%;">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <span style="font-size: 14px">${head}</span>
        </div>
        <div class="modal-body clearfix" style="font-size: 15px;">
            <div id="layout" style="display:none;z-index:999;position:absolute;width: 100%;height: 100%;text-align: center"></div>
            <form id="form">
            <div class="controls" id="controls">
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>姓名
                    </div>
                    <div class="col-md-4">
                        <input id="person" type="text" value="${mm.personIdShow}"/>
                        <input id="perId" name="personId" type="hidden" value="${mm.personId}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教工号
                    </div>
                    <div class="col-md-4">
                        <input id="tnum" name="teacherNum" class="js-example-basic-single" value="${mm.teacherNum}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>所属系部
                    </div>
                    <div class="col-md-4">
                        <select id="departmentsId" name="departmentsId" onchange="changeMajor()"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>教师性质
                    </div>
                    <div class="col-md-4">
                        <select id="teacherCategory" name="teacherCategory"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>所属专业
                    </div>
                    <div class="col-md-4">
                        <select id="majorid" onchange="fillMajorCode()" name="majorId"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>专业代码
                    </div>
                    <div class="col-md-4">
                        <input id="staffId" readonly name="majorCode" type="text" value="${mm.majorCode}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>性别
                    </div>
                    <div class="col-md-4">
                        <select id="sex" name="sex" class="js-example-basic-single"></select>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>出生日期
                    </div>
                    <div class="col-md-4">
                        <input id="birthday" name="birthday" type="date" value="${mm.birthday}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学历
                    </div>
                    <div class="col-md-4">
                        <select id="nationality" name="education" type="text"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>学位
                    </div>
                    <div class="col-md-4">
                        <select id="xuewei" name="degree" type="text"/>
                        <%--<select id="xuewei" class="js-example-basic-single"></select>--%>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>工作单位
                    </div>
                    <div class="col-md-4">
                        <input id="wdept" name="workDept" type="text" value="${mm.workDept}"/>
                        <%--<select id="xuewei" class="js-example-basic-single"></select>--%>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>职务
                    </div>
                    <div class="col-md-4">
                        <input id="zhiwu" name="position" type="text" value="${mm.position}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>办公号码
                    </div>
                    <div class="col-md-4">
                        <input id="ghua" name="guHua" type="text" value="${mm.guHua}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 电子邮箱
                    </div>
                    <div class="col-md-4">
                        <input id="youxiang" name="email" type="text" value="${mm.email}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 专业带头人年限（年）
                    </div>
                    <div class="col-md-4">
                        <input id="zywd" name="zyWorkDate" type="text" value="${mm.zyWorkDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-12">专业技术职务:</div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span> 名称
                    </div>
                    <div class="col-md-4">
                        <input id="zhiwuming" name="positionName" type="text" value="${mm.positionName}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>等级
                    </div>
                    <div class="col-md-4">
                        <input id="dengji1" name="positionLeave" type="text" value="${mm.positionLeave}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>发证单位
                    </div>
                    <div class="col-md-4">
                        <input id="fazheng" name="office" type="text" value="${mm.office}"/>
                    </div>
                    <div class="col-md-2 tar">
                        <span class="iconBtx">*</span>获取日期
                    </div>
                    <div class="col-md-4">
                        <input id="fazhengDate" name="positionDate" type="month" value="${mm.positionDate}"/>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-md-11">代表性科研成果:</div>
                    <div class="col-md-1">
                        <button type="button" onclick="addResearch()" class="btn btn-small btn-success btn-clean" style="margin-left: 10px" >添加</button>
                    </div>
                </div>
                <!--mm为空说明为添加，研究成果list大小为0说明为修改页面且没录入科研成果-->
                <c:choose>
                    <c:when test="${mm==null||fn:length(researchResults)==0}">
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span>项目名称
                            </div>
                            <div class="col-md-4">
                                <input id="huodeName" name="huodeName" type="text"/>
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span>获奖等级
                            </div>
                            <div class="col-md-4">
                                <input id="huodeLv" name="huodeLv" type="text"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span>项目简介
                            </div>
                            <div class="col-md-10">
                                <input id="huodeInfo" name="huodeInfo" type="text"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span>获取时间
                            </div>
                            <div class="col-md-4">
                                <input id="shijian2" name="shijian2" type="month"/>
                            </div>
                            <div class="col-md-2 tar">
                                <span class="iconBtx">*</span> 合作情况
                            </div>
                            <div class="col-md-4 tar">
                                <input id="hezuo" name="hezuo" type="text"/>
                            </div>
                        </div>
                    </c:when>
                   <c:otherwise>
                       <c:forEach var="researchResult" items="${researchResults}" varStatus="researchResultStatus">
                           <c:set var="rrNum" value="${researchResultStatus.first?'':researchResultStatus.index}"/>
                           <div class="form-row">
                               <div class="col-md-2 tar">
                                   <span class="iconBtx">*</span>项目名称
                               </div>
                               <div class="col-md-4">
                                   <input id="huodeName${rrNum}" name="huodeName${rrNum}" type="text" value="${researchResult.name}"/>
                               </div>
                               <div class="col-md-2 tar">
                                   <span class="iconBtx">*</span>获奖等级
                               </div>
                               <div class="col-md-4">
                                   <input id="huodeLv${rrNum}" name="huodeLv${rrNum}" type="text" value="${researchResult.getPrizeClass}"/>
                               </div>
                           </div>
                           <div class="form-row">
                               <div class="col-md-2 tar">
                                   <span class="iconBtx">*</span>项目简介
                               </div>
                               <div class="col-md-10">
                                   <input id="huodeInfo${rrNum}" name="huodeInfo${rrNum}" type="text" value="${researchResult.detail}"/>
                               </div>
                           </div>
                           <div class="form-row">
                               <div class="col-md-2 tar">
                                   <span class="iconBtx">*</span>获取时间
                               </div>
                               <div class="col-md-4">
                                   <input id="shijian2${rrNum}" name="shijian2${rrNum}" type="month" value="${researchResult.getDate}"/>
                               </div>
                               <div class="col-md-2 tar">
                                   <span class="iconBtx">*</span> 合作情况
                               </div>
                               <div class="col-md-4 tar">
                                   <input id="hezuo${rrNum}" name="hezuo${rrNum}" type="text" value="${researchResult.cooperationDetail}"/>
                               </div>
                           </div>
                       </c:forEach>
                   </c:otherwise>
                </c:choose>
            </div>
        </form>
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
    //记录研究成果共有几个
    var researchNum=1;
    $(document).ready(function () {

        if('${researchResults}'!=''&&'${fn:length(researchResults)}'!=0){
            researchNum='${fn:length(researchResults)}';
        }
        $.get("<%=request.getContextPath()%>/stamp/autoCompleteEmployee", function (data) {
            $("#person").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#person").val(ui.item.label);
                    $("#person").attr("keycode", ui.item.value);
                    $("#perId").val(ui.item.value);
                    autocompeteOtherMsg(ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XL", function (data) {
            addOption(data, 'nationality', '${mm.education}');
        });
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XW", function (data) {
            addOption(data, 'xuewei', '${mm.degree}');
        });
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

        $.post("/major/getMajorById",{
            id: $("#majorid").val()
        },function (res) {
            $("#staffId").val(res.majorCode);
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
                title: "请填写姓名",
                type: "info"
            });
            return;
        }
        if ($("#sex option:selected").val() == "" || $("#sex option:selected").val() == null) {
            swal({
                title: "请选择性别",
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
        if ($("#tnum").val() == "" || $("#tnum").val() == null) {
            swal({
                title: "请填写教工号",
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

        if ($("#departmentsId").val() == "" || $("#departmentsId").val() == null) {
            swal({
                title: "请选择所属系部",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#staffId").val() == "" || $("#staffId").val() == null) {
            swal({
                title: "请填写专业代码",
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
        if ($("#teacherCategory").val() == "" || $("#teacherCategory").val() == null) {
            swal({
                title: "请选择教师性质",
                type: "info"
            });
            //alert("请选择人员性别");
            return;
        }
        if ($("#nationality").val() == "" || $("#nationality").val() == null) {
            swal({
                title: "请填写学历",
                type: "info"
            });
            return;
        }
        if ($("#xuewei").val() == "" || $("#xuewei").val() == null) {
            swal({
                title: "请填写学位",
                type: "info"
            });
            return;
        }
        if ($("#wdept").val() == "" || $("#wdept").val() == null) {
            swal({
                title: "请填写工作单位",
                type: "info"
            });
            return;
        }
        if ($("#ghua").val() == "" || $("#ghua").val() == null) {
            swal({
                title: "请填写办公号码",
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
        if ($("#zhiwuming").val() == "" || $("#zhiwuming").val() == null) {
            swal({
                title: "请填写专业技术职务： 名称",
                type: "info"
            });
            return;
        }
        if ($("#dengji1").val() == "" || $("#dengji1").val() == null) {
            swal({
                title: "请填写专业技术职务： 等级",
                type: "info"
            });
            return;
        }
        if ($("#fazheng").val() == "" || $("#fazheng").val() == null) {
            swal({
                title: "请填写专业技术职务： 发证单位",
                type: "info"
            });
            return;
        }

        if ($("#fazhengDate").val() == "" || $("#fazhengDate").val() == null) {
            swal({
                title: "请选择专业技术职务： 获取日期",
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
        if ($("#zywd").val() == "" || $("#zywd").val() == null) {
            swal({
                title: "请填写专业带头人工作年限（年）",
                type: "info"
            });
            return;
        }

        for(var i=0;i<researchNum;i++){
            var temp=(i==0?"":i);
            if ($("#huodeName"+temp).val() == "" || $("#huodeName"+temp).val() == null) {
                swal({
                    title: "请填写第"+(temp+1)+"个代表性科研成果： 项目名称",
                    type: "info"
                });
                return;
            }
            if ($("#huodeLv"+temp).val() == "" || $("#huodeLv"+temp).val() == null) {
                swal({
                    title: "请填写第"+(temp+1)+"个代表性科研成果： 获奖等级",
                    type: "info"
                });
                return;
            }

            if ($("#shijian2"+temp).val() == "" || $("#shijian2"+temp).val() == null) {
                swal({
                    title: "请选择第"+(temp+1)+"个代表性科研成果： 获取日期",
                    type: "info"
                });
                return;
            }
            if ($("#hezuo"+temp).val() == "" || $("#hezuo"+temp).val() == null) {
                swal({
                    title: "请填写第"+(temp+1)+"个代表性科研成果： 合作情况",
                    type: "info"
                });
                return;
            }
            if ($("#huodeInfo"+temp).val() == "" || $("#huodeInfo"+temp).val() == null) {
                swal({
                    title: "请填写第"+(temp+1)+"个代表性科研成果： 项目简介",
                    type: "info"
                });
                return;
            }
        }

        showSaveLoading();
        $.get("<%=request.getContextPath()%>/majorLeader/saveMajorLeader?"+$("#form").serialize()+"&researchNum="+researchNum+"&id="+$("#mid").val(), function (msg) {
            hideSaveLoading();
            if (msg.status == 1) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $("#dialog").modal("hide");
                if ($("#personType").val() == "1") {
                    mltable.ajax.reload();
                } else if ($("#personType").val() == "2") {
                    mrtable.ajax.reload();
                } else {
                    mmtable.ajax.reload();
                }
            }
        })
    }
    function autocompeteOtherMsg(id) {
        $.post("/majorLeader/getTeacherById",{
            tid: id
        },function (res) {
            $("#tnum").val(res.TEACHERNUM);
            $("#sex").val(res.TEACHERSEX);
            $("#birthday").val(res.BIRTHDAY);
        })
    }
    function addResearch() {
        $("#controls").append('<div class="form-row">\n' +
            '                    <div class="col-md-2 tar">\n' +
            '                        <span class="iconBtx">*</span>项目名称\n' +
            '                    </div>\n' +
            '                    <div class="col-md-4">\n' +
            '                        <input id="huodeName'+researchNum+'" name="huodeName'+researchNum+'" type="text"/>\n' +
            '                    </div>\n' +
            '                    <div class="col-md-2 tar">\n' +
            '                        <span class="iconBtx">*</span>获奖等级\n' +
            '                    </div>\n' +
            '                    <div class="col-md-4">\n' +
            '                        <input id="huodeLv'+researchNum+'" name="huodeLv'+researchNum+'" type="text"/>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <div class="form-row">\n' +
            '                    <div class="col-md-2 tar">\n' +
            '                        <span class="iconBtx">*</span>项目简介\n' +
            '                    </div>\n' +
            '                    <div class="col-md-10">\n' +
            '                        <input id="huodeInfo'+researchNum+'" name="huodeInfo'+researchNum+'" type="text"/>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '                <div class="form-row">\n' +
            '                    <div class="col-md-2 tar">\n' +
            '                        <span class="iconBtx">*</span>获取时间\n' +
            '                    </div>\n' +
            '                    <div class="col-md-4">\n' +
            '                        <input id="shijian2'+researchNum+'" name="shijian2'+researchNum+'" type="month"/>\n' +
            '                    </div>\n' +
            '                    <div class="col-md-2 tar">\n' +
            '                        <span class="iconBtx">*</span> 合作情况\n' +
            '                    </div>\n' +
            '                    <div class="col-md-4 tar">\n' +
            '                        <input id="hezuo'+researchNum+'" name="hezuo'+researchNum+'" type="text"/>\n' +
            '                    </div>\n' +
            '                </div>');
        researchNum++;
    }

</script>