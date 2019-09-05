<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/20
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-12" id="roleList">
            <div class="row">
                <div class="col-md-12">
                    <div class="block">
                        <div class="block block-drop-shadow">

                            <div class="content block-fill-white">

                                <div class="form-row">
                                    <div class="col-md-1 tar">
                                        申请人：
                                    </div>
                                    <div class="col-md-2">
                                        <input id="f_requester" type="text"
                                               class="validate[required,maxSize[20]] form-control"/>

                                    </div>
                                    <div class="col-md-1 tar">
                                        申请时间：
                                    </div>
                                    <div class="col-md-2">
                                        <input id="f_date" type="date"
                                               class="validate[required,maxSize[100]] form-control"/>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="button" class="btn btn-default btn-clean" onclick="search()">查询
                                        </button>
                                        <button type="button" class="btn btn-default btn-clean" onclick="searchclear()">
                                            清空
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="block block-drop-shadow content">
                            <div>
                                <div class="form-row block" style="overflow-y:auto;">
                                    <table id="studentReissueGrid" cellpadding="0" cellspacing="0" width="100%"
                                           style="max-height: 50%;min-height: 10%;"
                                           class="table table-bordered table-striped sortable_default">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var roleTable;

    var render = "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;" +
        "<a id='eidtLeaveProcess' class='icon-edit' title='修改'></a>"

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/studentProve/autoCompleteEmployee", function (data) {
            $("#f_requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#f_requester").val(ui.item.label);
                    $("#f_requester").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        roleTable = $("#studentReissueGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/studentReissue/getProcessList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "6%", "data": "requestDate", "title": "申请日期"},
                {"width": "6%", "data": "studentId", "title": "学生姓名"},
                {"width": "6%", "data": "nation", "title": "民族"},
                {"width": "6%", "data": "sex", "title": "性别"},
                {"width": "7%", "data": "classId", "title": "班级"},
                {"width": "7%", "data": "majorCode", "title": "专业"},
                {"width": "7%", "data": "studentNumber", "title": "学号"},
                {"width": "7%", "data": "idcard", "title": "身份证号"},
                {"width": "7%", "data": "rideZone", "title": "乘车区间"},
                {"width": "7%", "data": "familyAddress", "title": "家庭地址"},
                {"width": "7%", "data": "phone", "title": "电话"},
                {"width": "7%", "data": "nativePlace", "title": "籍贯"},
                {"width": "7%", "data": "requestProject", "title": "申请项目"},
                {"width": "7%", "data": "requestReason", "title": "申请理由"},
                {
                    "width": "6%", "title": "操作", "render": function () {
                        return render;
                    }
                },

            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var studentReissueProcessId = data.id;
//修改
            if (this.id == "eidtLeaveProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_XG_STUDENT_REISSUE_WF",
                    businessId: studentReissueProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: studentReissueProcessId,
                            tableName: "T_XG_STUDENT_REISSUE_WF",
                            url: "<%=request.getContextPath()%>/studentReissue/auditStudentReissueEdit?id=" + studentReissueProcessId,
                            backUrl: "<%=request.getContextPath()%>/studentReissue/process"
                        });
                    }
                })
            }
//办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_XG_STUDENT_REISSUE_WF",
                    businessId: studentReissueProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: studentReissueProcessId,
                            tableName: "T_XG_STUDENT_REISSUE_WF",
                            url: "/studentReissue/auditStudentReissueById?id=" + studentReissueProcessId, //2018年4月3日14:33:29修改url: "/studentReissue/auditLeaveById?id=" + studentReissueProcessId,
                            backUrl: "/studentReissue/process"
                        });
                    }
                })
            }

        });
    });

    function searchclear() {
        $("#f_dept").val("");
        $("#f_requester").val("");
        $("#f_date").val("");
        search();
    }

    function search() {
        var dept = $("#f_dept").val();
        if (dept != "")
            dept = '%' + dept + '%';
        var jbr = $("#f_requester").val();
        if (jbr != "")
            jbr = '%' + jbr + '%';
        var date = $("#f_date").val();
        if (date != "") {
            date = '%' + date + '%';
        }
        roleTable = $("#studentReissueGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/studentReissue/getProcessList',
                "data": {
                    requester: jbr,
                    requestDate: date,
                    requestDept: dept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "6%", "data": "requestDate", "title": "申请日期"},
                {"width": "6%", "data": "studentId", "title": "学生姓名"},
                {"width": "6%", "data": "nation", "title": "民族"},
                {"width": "6%", "data": "sex", "title": "性别"},
                {"width": "7%", "data": "classId", "title": "班级"},
                {"width": "7%", "data": "majorCode", "title": "专业"},
                {"width": "7%", "data": "studentNumber", "title": "学号"},
                {"width": "7%", "data": "idcard", "title": "身份证号"},
                {"width": "7%", "data": "rideZone", "title": "乘车区间"},
                {"width": "7%", "data": "familyAddress", "title": "家庭地址"},
                {"width": "7%", "data": "phone", "title": "电话"},
                {"width": "7%", "data": "nativePlace", "title": "籍贯"},
                {"width": "7%", "data": "requestProject", "title": "申请项目"},
                {"width": "7%", "data": "requestReason", "title": "申请理由"},
                {
                    "width": "6%", "title": "操作", "render": function () {
                        return render;
                    }
                },

            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });

    }

</script>


