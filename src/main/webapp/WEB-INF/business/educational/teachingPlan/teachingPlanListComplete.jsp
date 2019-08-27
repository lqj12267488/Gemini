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
                                计划名称：
                            </div>
                            <div class="col-md-2">
                                <input id="name" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                学期：
                            </div>
                            <div class="col-md-2">
                                <select id="ss_term" />
                            </div>
                            <div class="col-md-1 tar">
                                创建年份：
                            </div>
                            <div class="col-md-2">
                                <select id="ss_year" />
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
                            <table id="table" cellpadding="0" cellspacing="0"
                                   width="100%" style="max-height: 50%;min-height: 10%;"
                                   class="table table-bordered table-striped sortable_default">
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input id="businessId" hidden>
    <input id="tableName" hidden value="T_JW_TEACHINGPLAN">
</div>
<script>
    var table;
    $(document).ready(function () {
        $.get("/common/getSysDict?name=ND", function (data) {
            addOption(data, 'ss_year');
        });
        $.get("/common/getSysDict?name=KKJHXQ", function (data) {
            addOption(data,'ss_term');
        });
        search();
    })

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>/teachingPlan/toAdd")
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/teachingPlan/del", {
                id: id
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#table').DataTable().ajax.reload();
            });
        })
    }
    function searchclear() {
        $("#name").val("");
        $("#ss_term").val("");
        $("#ss_year").val("");
        search();
    }
    function search() {
        table = $("#table").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/teachingPlan/getCompleteList',
                "data":{
                    planName: $("#name").val(),
                    year: $("#ss_year").val(),
                    term:$("#ss_term").val()
                }
            },
            "destroy": true,
            "columns": [
                {"width": "9%", "data": "planName", "title": "计划名称"},
                {"width": "9%", "data": "departmentsId", "title": "系部名称"},
                {"width": "9%", "data": "majorCode", "title": "专业名称"},
                {"width": "9%", "data": "courseId", "title": "课程名称"},
                {"width": "9%", "data": "textbookId", "title": "教材名称"},
                {"width": "9%", "data": "year", "title": "创建年份"},
                {"width": "9%", "data": "className", "title": "班级名称"},
                {"width": "5%", "data": "term", "title": "学期"},
                {"width": "9%", "data": "requestFlag", "title": "请求状态"},
                {"width": "9%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "9%", "data": "feedback", "title": "反馈意见"},
                {"width": "5%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="查看流程轨迹" onclick=edit("' + row.id + '")/>&ensp;&ensp;' +
                            '<span class="icon-comments" title="反馈" onclick=feedbackReport("' + row.id + '")/>';
                    }
                }
            ],
            paging: true,
            "dom": 'rtlip',
            language: language
        });
    }
    function toPlanDetail(id,planName) {
        $("#right").load("<%=request.getContextPath()%>/teachingPlan/teachingPlanDetail/toList2?planId=" + id + "&planName="+planName);
    }

    function feedbackReport(id) {
        $.post("<%=request.getContextPath()%>/getBusinessStatus", {
            tableName: "T_JW_TEACHINGPLAN",
            businessId: id,
        }, function (msg) {
            if (msg.status == 1) {
                swal({title: msg.msg, type: "error"});
            } else {
                $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                    businessId: id,
                    tableName: "T_JW_TEACHINGPLAN",
                    backUrl: "/teachingPlan/complete"
                });
            }
        })
    }

    function edit(id) {
        $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
            businessId: id,
            tableName: "T_JW_TEACHINGPLAN",
            url: "<%=request.getContextPath()%>/teachingPlan/toAuditTeachingPlan?id=" + id,
            backUrl: "/teachingPlan/complete"
        });
    }

</script>