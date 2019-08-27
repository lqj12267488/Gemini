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
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                培养方案：
                            </div>
                            <div class="col-md-2">
                                <input id="tname"/>
                            </div>
                            <div class="col-md-1 tar">
                                系部
                            </div>
                            <div class="col-md-2">
                                <select id="departmentsIdSearch"
                                        onchange="changeSearchMajor()"/>
                            </div>
                            <div class="col-md-1 tar">
                                专业
                            </div>
                            <div class="col-md-2">
                                <select id="majorCodeSearch"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchclear()">
                                    清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="tableProcess" cellpadding="0" cellspacing="0"
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
    var tableProcess;
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getSelectDept?type=8", function (data) {
            addOption(data, 'departmentsIdSearch');
        });
        $("#majorCodeSearch").append("<option value='' selected>请选择</option>")

        tableProcess = $("#tableProcess").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/major/talentTrainListProcess',
            },
            "destroy": true,
            "columns": [
                {"data":"id","visible":false},
                {"data": "createTime", "visible": false},
                {"data": "trainPlan", "title": "培养方案"},
                {"data": "departmentsIdShow", "title": "系部名称"},
                {"data": "majorIdShow", "title": "专业名称"},
                {"data": "requestFlag", "title": "审批状态"},
                {

                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-file-text-alt" title="审核" onclick=edit("' + row.id +'","' + row.requestFlag + '")/>&ensp;&ensp;'+
                            '<span class="icon-search" title="查看关联教学计划" onclick=relation("' + row.id +'","'+ row.planName +'")/>&ensp;&ensp;'+
                            "<a id='upload' class='icon-cloud-upload' title='查看附件'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
             paging: true,
            "dom": 'rtlip',
            language: language
        });
        tableProcess.on('click', 'tr a', function () {
            var data = tableProcess.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + id + '&businessType=TEST&tableName=T_JW_TALENTTRAIN');
                $('#dialogFile').modal('show');
            }
        });
    })

    function changeSearchMajor() {
        var deptId = $("#departmentsIdSearch").val();
        $.get("<%=request.getContextPath()%>/course/getMajorByDeptId?deptId=" + deptId, function (data) {
            addOption(data, 'majorCodeSearch');
        });
    }
    function edit(id,requestFlag) {
            $("#dialog").load("<%=request.getContextPath()%>/major/talentProcess?id=" + id);
            $("#dialog").modal("show");
    }
    function search() {
        var planName = $("#tname").val();
        planName=encodeURI(encodeURI(planName));
        var departmentsId = $("#departmentsIdSearch").val();
        var majorid = $("#majorCodeSearch").val();
        tableProcess.ajax.url("<%=request.getContextPath()%>/major/talentTrainListProcess?planName="+planName+"&departmentsId="+
            departmentsId+"&majorId="+majorid).load();
    }

    function searchclear() {
        $("#tname").val("");
        $("#departmentsIdSearch").val("");
        $("#majorCodeSearch").val("");
        search();
    }

    function relation(id) {
        $("#right").load("<%=request.getContextPath()%>/major/searchRelation",{
            id:id
        });
    }
</script>