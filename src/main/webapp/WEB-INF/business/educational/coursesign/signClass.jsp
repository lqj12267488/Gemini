<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/8/21
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>


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
                            <select id="planSel"<%-- style="background-color: #ffffff" --%>/>
                        </div>
                        <div class="col-md-1 tar">
                            签课学期:
                        </div>
                        <div class="col-md-3">
                            <select id="termSel" />
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
                        <table id="signClassList" cellpadding="0" cellspacing="0"
                               width="100%" style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var classTable2;
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
            }
        );
        classTable2 = $('#signClassList').DataTable({
           "ajax": {
               "type": "post",
               "url": '<%=request.getContextPath()%>/coursesign/viewSignList',
           },
           "destroy": true,
           "columns": [
               {"width": "20%", "data": "planId", "title": "教学计划"},
               {"width": "10%", "data": "courseName", "title": "课程名称" },
               {"width": "10%", "data": "termId", "title": "教学学期" },
               {"width": "10%", "data": "personId", "title": "签课教师"},
               {"width": "10%", "data": "deptId", "title": "教师部门"},
               {"width": "10%", "data": "term", "title": "签课学期"},
               {"width": "20%", "data": "classId","title": "分配班级"},
               {
                   "width": "10%", "title": "操作",
                   "render": function (data, type, row) {
                       return  '<span class="icon-trash" title="取消签课" onclick=' +
                           'delSign("'+row.signId+'")/>&ensp;&ensp;'+
                           '<span class="icon-bullhorn" title="班级分配" onclick="classAllot(\''+ row.signId+ '\',\''+ row.planName+ '\')"/>&ensp;&ensp;' +
                           '<span class="icon-credit-card" title="查看签课人员" onclick=selectList("'+ row.termValue+ ','+row.signId+'")/>';
                   }
               }
           ],
           "dom": 'rtlip',
           language: language
       });
        search();
    });
    function delSign(signId) {
        swal({
            title: "确定要取消签课?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/coursesign/delSign", {
                signId: signId,
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type:"success"
                });
                $('#signClassList').DataTable().ajax.reload();
            });
        })
    }

    function classAllot(id,planId) {
        $("#dialog").load("<%=request.getContextPath()%>/coursesign/signClassTree?id="+id+"&planId="+planId);
        $("#dialog").modal("show");
    }

    function selectList(id) {
        var list = id.split(',');
        var termId = list[0];
        var signId = list[1];
        $("#dialog").load("<%=request.getContextPath()%>/coursesign/getSignList?termId="+termId+"&signId="+signId);
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
        classTable2.ajax.url("<%=request.getContextPath()%>/coursesign/viewSignList?"+
            "term=" + termSel +"&planId="+planSel
        ).load();
    }

    function searchclear() {
        $("#planSel option:selected").val("");
        $("#planSel").val("");
        $("#termSel option:selected").val("");
        $("#termSel").val("");
        search();
    }
</script>
