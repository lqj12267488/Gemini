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
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>
<div class="container">
    <input id="deptId" name="deptId" type="hidden" value="${deptId}">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                培训类别：
                            </div>
                            <div class="col-md-2">
                                <select id="type"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchclear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="reportDepartmentGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var table;


    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXLB", function (data) {
            addOption(data, 'type');
        });
        table = $("#reportDepartmentGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/training/department/upGetTrainingList?flag=1',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%","data": "trainingProjectName", "title": "培训项目名称"},
                {"width": "12%","data": "requestDept", "title": "申请部门"},
                {"width": "11%","data": "requester", "title": "经办人"},
                {"width": "11%","data": "requestDate", "title": "申请日期"},
                {"width": "11%","data": "trainingTypeShow", "title": "培训类别"},
                {"width": "11%","data": "trainingDate", "title": "培训日期"},
                {"width": "11%","data": "trainingPeopleNumber", "title": "培训人数"},
                {"width": "11%","data": "trainingApplyNumber", "title": "参加报名人数"},
                {"data":  "trainingDays", "visible": false},
                {"data":  "trainingPlace", "visible": false},
                { "title": "操作",
                    "render": function (date,type,row) {
                        return '<a class="icon-arrow-up" title="上报参培教师" id="reportTeacher" />';
                    }
                }

            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        table.on('click', 'tr a', function () {
            var data = table.row($(this).parent()).data();
            var id=data.id;
            var trainingProjectName = data.trainingProjectName;
            if(this.id == "reportTeacher"){
                $("#right").load("<%=request.getContextPath()%>/training/department/reportTeacherList?deptId=${deptId}&id="+id+"&trainingProjectName="+trainingProjectName);
            }
        });

    })


    function search() {
        var date = $("#date").val();
        var type = $("#type option:selected").val();
        if (type == "" && date == "") {

        } else{
            table.ajax.url("<%=request.getContextPath()%>/training/department/upGetTrainingList?flag=1"+"&trainingType="+type+"&requestDate="+date).load();
        }
    }

    function searchclear() {
        $("#date").val("");
        $("#type").val("");
        table.ajax.url("<%=request.getContextPath()%>/training/department/upGetTrainingList?flag=1").load();
    }



</script>
