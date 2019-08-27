<%--
  Created by IntelliJ IDEA.
  User: go
  Date: 2019/6/19
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                学院：
                            </div>
                            <div class="col-md-2">
                                <input id="majorSchoolSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部：
                            </div>
                            <div class="col-md-2">
                                <input id="deptSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业：
                            </div>
                            <div class="col-md-2">
                                <input id="majorSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                班级：
                            </div>
                            <div class="col-md-2">
                                <input id="classSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="col-md-1 tar">
                                课程：
                            </div>
                            <div class="col-md-2">
                                <input id="courseSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="peopleSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>

                            <div class="col-md-1 tar">
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="applicantDateSel" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>

                            <div class="col-md-1 tar">
                                系部审批人员：
                            </div>
                            <div class="col-md-2">
                                <input id="approveDptPersonSel" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                系部审批时间：
                            </div>
                            <div class="col-md-2">
                                <input id="approveDptDate" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>

                            <div class="col-md-1 tar">
                                教务处审批人员：
                            </div>
                            <div class="col-md-2">
                                <input id="approveOfficePersonSel" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>

                            <div class="col-md-1 tar">
                                教务审批时间：
                            </div>
                            <div class="col-md-2">
                                <input id="approveOfficeDate" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>

                            <div class="col-md-1 tar">
                                状态：
                            </div>
                            <div class="col-md-2">
                                <select id="statusType" ></select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-2 tar">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="rescheduleGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=TTKZT", function (data) {
            addOption(data,'statusType');
        });
        //初始化下拉菜单信息
            $("#rescheduleGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/rescheduleCourse/getRCQueryList',
                "data": {
                    majorSchoolShow: $("#majorSchoolSel").val(),
                    deptId:$("#deptSel").val(),
                    majorShow:$("#majorSel").val(),
                    courseId:$("#courseSel").val(),
                    classId:$("#classSel").val(),
                    applicantPersonId:$("#peopleSel").val(),
                    applicantDate:$("#applicantDateSel").val(),
                    approveDptPersonId:$("#approveDptPersonSel").val(),
                    approveDptDate:$("#approveDptDate").val(),
                    approveOfficePersonId:$("#approveOfficePersonSel").val(),
                    approveOfficeDate:$("#approveOfficeDate").val(),
                    status:$("#statusType").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "5%","data": "majorSchool", "title": "学院"},
                {"width": "5%","data": "majorCode", "title": "专业"},
                {"width": "5%","data": "deptId", "title": "系部"},
                {"width": "5%","data": "classId", "title": "班级"},
                {"width": "5%","data": "courseId", "title": "课程"},
                {"width": "5%","data": "oringalWeek", "title": "原定上课周次"},
                {"width": "5%","data": "oringalDate", "title": "原定上课日期"},
                {"width": "5%","data": "oringalWeekday", "title": "原定上课星期"},
                {"width": "5%","data": "oringalClassTime", "title": "原定上课节次"},
                {"width": "5%","data": "rescheduleWeek", "title": "改调上课周次"},
                {"width": "5%","data": "rescheduleDate", "title": "改调上课日期"},
                {"width": "5%","data": "rescheduleWeekday", "title": "改调上课星期"},
                {"width": "5%","data": "rescheduleClassTime", "title": "改调上课节次"},
                {"width": "5%","data": "applicantPersonId", "title": "申请人"},
                {"width": "5%","data": "applicantReason", "title": "申请理由"},
                {"width": "5%","data": "applicantDate", "title": "申请日期"},
                {"width": "5%","data": "approveDptPersonId", "title": "系部审批人"},
                {"width": "5%","data": "approveDptDate", "title": "系部审批时间"},
                {"width": "5%","data": "approveOfficePersonId", "title": "教务处审批人"},
                {"width": "5%","data": "approveOfficeDate", "title": "教务处审批时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                            return'<a  href="<%=request.getContextPath()%>/rescheduleCourse/toExportRC?id=' + row.id + '">' +
                        '<span class="icon-cloud-download" title="导出课程表" /></a>';
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    })

    //查询
    function search() {
        $("#rescheduleGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/rescheduleCourse/getRCQueryList',
                "data": {
                    majorSchoolShow: $("#majorSchoolSel").val(),
                    deptId:$("#deptSel").val(),
                    majorShow:$("#majorSel").val(),
                    courseId:$("#courseSel").val(),
                    classId:$("#classSel").val(),
                    applicantPersonId:$("#peopleSel").val(),
                    applicantDate:$("#applicantDateSel").val(),
                    approveDptPersonId:$("#approveDptPersonSel").val(),
                    approveDptDate:$("#approveDptDate").val(),
                    approveOfficePersonId:$("#approveOfficePersonSel").val(),
                    approveOfficeDate:$("#approveOfficeDate").val(),
                    status:$("#statusType").val()
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"width": "5%","data": "majorSchool", "title": "学院"},
                {"width": "5%","data": "majorCode", "title": "专业"},
                {"width": "5%","data": "deptId", "title": "系部"},
                {"width": "5%","data": "classId", "title": "班级"},
                {"width": "5%","data": "courseId", "title": "课程"},
                {"width": "5%","data": "oringalWeek", "title": "原定上课周次"},
                {"width": "5%","data": "oringalDate", "title": "原定上课日期"},
                {"width": "5%","data": "oringalWeekday", "title": "原定上课星期"},
                {"width": "5%","data": "oringalClassTime", "title": "原定上课节次"},
                {"width": "5%","data": "rescheduleWeek", "title": "改调上课周次"},
                {"width": "5%","data": "rescheduleDate", "title": "改调上课日期"},
                {"width": "5%","data": "rescheduleWeekday", "title": "改调上课星期"},
                {"width": "5%","data": "rescheduleClassTime", "title": "改调上课节次"},
                {"width": "5%","data": "applicantPersonId", "title": "申请人"},
                {"width": "5%","data": "applicantReason", "title": "申请理由"},
                {"width": "5%","data": "applicantDate", "title": "申请日期"},
                {"width": "5%","data": "approveDptPersonId", "title": "系部审批人"},
                {"width": "5%","data": "approveDptDate", "title": "系部审批时间"},
                {"width": "5%","data": "approveOfficePersonId", "title": "教务处审批人"},
                {"width": "5%","data": "approveOfficeDate", "title": "教务处审批时间"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return'<a  href="<%=request.getContextPath()%>/rescheduleCourse/toExportRC?id=' + row.id + '">' +
                            '<span class="icon-cloud-download" title="导出课程表" /></a>';
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function searchClear() {
        $("#majorSchoolSel").val("");
        $("#deptSel").val("");
        $("#majorSel").val("");
        $("#courseSel").val("");
        $("#classSel").val("");
        $("#peopleSel").val("");
        $("#applicantDateSel").val("");
        $("#approveDptPersonSel").val("");
        $("#approveDptDate").val("");
        $("#approveOfficePersonSel").val("");
        $("#approveOfficeDate").val("");
        $("#statusType").val("")
        search();
    }
</script>
