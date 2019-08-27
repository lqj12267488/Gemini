<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <div class="col-md-1 tar">
                            教学计划:
                        </div>
                        <div class="col-md-3">
                            <select id="planSel" />
                        </div>
                        <div class="col-md-1 tar">
                            签课学期:
                        </div>
                        <div class="col-md-3">
                            <select id="termSel"/>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="search()">查询
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="searchclear()">清空
                            </button>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="signList" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <input id="person" value="${personId}" hidden>
        <input id="dept" value="${deptId}" hidden>
    </div>
</div>
<script>
    var signList;
    var personId =$("#person").val();
    var deptId= $("#dept").val();

        $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=XQ", function (data) {
            addOption(data, 'termSel');
        });
        $.get("<%=request.getContextPath()%>/common/getTableDict", {
                id: " PLAN_ID",
                text: " PLAN_NAME ",
                tableName: " T_JW_COURSEPLAN ",
                where: " WHERE 1 = 1 ",
                orderby: "  "
            },
            function (data) {
                addOption(data, "planSel" );
            });


        signList = $("#signList").DataTable({
            /*"ajax": {
                "type": "post",
                "url": '/coursesign/viewSignList',
                "data": {
                    personId: personId,
                    deptId: deptId,
                }
            },*/
            "destroy": true,
            "columns": [
                {"data": "planId", "title": "教学计划"},
                {"data": "courseName", "title": "课程名称" },
                {"data": "termId", "title": "教学学期" },
                {"data": "personId", "title": "签课教师"},
                {"data": "deptId", "title": "教师部门"},
                {"data": "term", "title": "签课学期"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改签课" onclick=' +
                            'updateCourseSign("'+row.signId+'")/>&ensp;&ensp;'+
                            '<span class="icon-trash" title="取消签课" onclick=' +
                                            'delSign("'+row.signId+'")/>&ensp;&ensp;'+
                            '<span class="icon-credit-card" title="查看签课人员" onclick=selectList("'+ row.termValue+ '")/>';
                    }
                }
            ],
            "dom": 'rtlip',
            language: language
        });
        search();
    });

    function updateCourseSign(signId) {
        $("#dialog").load("<%=request.getContextPath()%>/coursesign/signEditTeacher?signId="+signId);
        $("#dialog").modal("show");
    }

    function delSign(signId) {
        swal({
            title: "确定要取消签课?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确定",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/coursesign/delSign", {
                signId: signId,
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                $('#signList').DataTable().ajax.reload();
            });
        })
    }

    function selectList(id) {
        $("#dialog").load("<%=request.getContextPath()%>/coursesign/getSignList?termId="+id);
        $("#dialog").modal("show");
    }

    function search() {
        var termSel = $("#termSel option:selected").val();
        if(termSel == undefined || termSel == null ){
            termSel ="";
        }
        var planSel = $("#planSel option:selected").val();
        if(planSel == undefined || planSel == null ){
            planSel ="";
        }
        signList.ajax.url("<%=request.getContextPath()%>/coursesign/viewSignList?"+
            "term=" + termSel +"&planId="+planSel+
            "&personId="+personId+"&deptId="+deptId
        ).load();
    }

    function searchclear() {
        $("#planSel option:selected").val("")
        $("#planSel").val("")
        $("#termSel option:selected").val("")
        $("#termSel").val("")
        search();
    }

</script>