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
    @media screen and (max-width: 1050px) {
        .tar {
            width: 68px !important;
        }
    }
</style>
<div class="container">
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
                                培训日期：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
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
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="auditGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var auditTable;

    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/common/getSysDict?name=PXLB", function (data) {
            addOption(data, 'type');
        });


        auditTable = $("#auditGrid").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/training/group/getAuditList',
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "12%","data": "trainingProjectName", "title": "培训项目名称"},
                {"width": "10%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "requester", "title": "经办人"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "10%","data": "trainingTypeShow", "title": "培训类别"},
                {"width": "10%","data": "trainingDate", "title": "培训日期"},
                {"data": "trainingDays", "visible": false},
                {"data": "trainingPlace", "visible": false},
                {"width": "10%", "title": "操作", "render": function () {return "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='eidtProcess' class='icon-edit' title='修改'></a>";}},

            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        auditTable.on('click', 'tr a', function () {
            var data = auditTable.row($(this).parent()).data();
            var id = data.id;
            //修改
            if (this.id == "eidtProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_RS_TRAINING_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: id,
                            tableName: "T_RS_TRAINING_WF",
                            url: "<%=request.getContextPath()%>/training/group/auditGroupEdit?id=" + id,
                            backUrl: "<%=request.getContextPath()%>/training/group/audit"
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_RS_TRAINING_WF",
                    businessId: id,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: id,
                            tableName: "T_RS_TRAINING_WF",
                            workflowCode: $("#workflowCode").val(),
                            url: "/training/group/auditGroupById?id=" + id,
                            backUrl: "/training/group/audit"
                        });
                    }
                })
            }

        });
    });

    function searchclear() {
        $("#dept").val("");
        $("#date").val("");
        auditTable.ajax.url("<%=request.getContextPath()%>/training/group/getAuditList").load();
    }

    function search() {
        var type = $("#type option:selected").val();
        var date = $("#date").val();
        if (type == "" && date== "" ) {

        } else{
            auditTable.ajax.url("<%=request.getContextPath()%>/training/group/getAuditList?trainingType="+type+"&trainingDate="+date).load();
        }


    }

</script>
