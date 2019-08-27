<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/7/31
  Time: 19:52
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
                            <div  class="col-md-1 tar">
                                单位名称:
                            </div>
                            <div class="col-md-2">
                                <input id="internshipUnitNames"   type="text" class="validate[required,maxSize[20]] form-control"/>
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
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addInternships()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="internshipsGrid" cellpadding="0" cellspacing="0"
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
    var roleTable;

    $(document).ready(function () {
        search();
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var internshipUnitId = data.internshipUnitId;
            var internshipUnitName = data.internshipUnitName;
            if (this.id == "getInternshipsById") {
                $("#dialog").load("<%=request.getContextPath()%>/internships/getInternshipsById?internshipUnitId=" + internshipUnitId);
                $("#dialog").modal("show");
            }
            if(this.id == "set"){
                $("#right").load("<%=request.getContextPath()%>/internships/internshipExtList?internshipUnitId="+internshipUnitId+"&internshipUnitName="+internshipUnitName);
            }
            if(this.id == "selectId"){
                $("#right").load("<%=request.getContextPath()%>/internships/getInternships?internshipUnitId=" + internshipUnitId);
            }
            if (this.id == "del") {
                $.get("<%=request.getContextPath()%>/internships/getInternshipsByInternshipUnitName?internshipUnitName=" + internshipUnitName, function (boolean) {
                    if (boolean == true) {
                        swal({
                            title: "实习单位已关联顶岗实习，不能删除",
                            type: "info"
                        });
                        return;
                    }else{
                        swal({
                            title: "您确定要删除本条信息?",
                            text: "单位名称："+internshipUnitName+"\n\n删除后将无法恢复，请谨慎操作！",
                            type: "warning",
                            showCancelButton: true,
                            cancelButtonText: "取消",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "删除",
                            closeOnConfirm: false
                        }, function () {
                            $.get("<%=request.getContextPath()%>/internships/deleteInternshipsById?internshipUnitId=" + internshipUnitId, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    $('#internshipsGrid').DataTable().ajax.reload();
                                }
                            })
                        });
                    }
                })

            }
        });
    })


    function addInternships() {
        $("#dialog").load("<%=request.getContextPath()%>/internships/addInternships");
        $("#dialog").modal("show");
    }

    function searchclear() {

        $("#internshipUnitNames").val("");

        search();
    }

    function search() {

        var classNameSel = $("#internshipUnitNames").val();
        if (classNameSel != "")
            classNameSel = '%' + classNameSel + '%';

        roleTable = $("#internshipsGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/internships/InternshipsAction',
                "data": {
                    internshipUnitName:classNameSel,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "internshipUnitId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "internshipUnitName", "title": "单位名称"},
                {"width": "10%", "data": "area", "title": "所在地区"},
                {"width": "10%", "data": "internshipWhetherRetentionShow", "title": "实习生是否留用"},
                {"width": "10%", "data": "cooperationTimeShow", "title": "合作时间"},
                {"width": "10%", "data": "enterprisePersonNumber", "title": "员工数"},
                {"width": "10%", "data": "registeredCapital", "title": "注册资金"},
                {"width": "10%", "data": "enterpriseNatureShow", "title": "企业性质"},
                {"width": "10%", "data": "legalPerson", "title": "法人代表"},
                {"width": "10%", "data": "enterpriseScaleShow", "title": "企业规模"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getInternshipsById' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='del' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='set' class='icon-cog' title='实习生实习设置'></a>&nbsp;&nbsp;&nbsp;";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
