<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/11
  Time: 10:09
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
                                单位名称：
                            </div>
                            <div class="col-md-2">
                                <input id="internshipUnitNames" type="text" class="validate[required,maxSize[20]] form-control"/>
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
                                onclick="addEmployments()">新增
                        </button>
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="internshipUnitObtain()">从实习单位获取
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="employmentsGrid" cellpadding="0" cellspacing="0"
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
            var employmentUnitId= data.employmentUnitId;
            var internshipUnitName= data.internshipUnitName;

            if (this.id == "getEmploymentsById") {
                $("#dialog").load("<%=request.getContextPath()%>/employments/getEmploymentsById?employmentUnitId=" + employmentUnitId);
                $("#dialog").modal("show");
            }
            if(this.id == "set"){
                $("#right").load("<%=request.getContextPath()%>/employments/employmentList?employmentUnitId="+employmentUnitId);

            }
            if (this.id == "del") {
                $.get("<%=request.getContextPath()%>/employments/getEmploymentsByInternshipUnitName?internshipUnitName=" + internshipUnitName, function (boolean) {
                    if (boolean == true) {
                        swal({
                            title: "就业单位已关联就业信息，不能删除！",
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
                            $.get("<%=request.getContextPath()%>/employments/deleteEmploymentsById?employmentUnitId=" + employmentUnitId, function (msg) {
                                if (msg.status == 1) {
                                    swal({
                                        title: msg.msg,
                                        type: "success"
                                    });
                                    $('#employmentsGrid').DataTable().ajax.reload();
                                }
                            })

                        });
                    }
                })


            }
        });
    })


    function addEmployments() {
        $("#dialog").load("<%=request.getContextPath()%>/employments/addEmployments");
        $("#dialog").modal("show");
    }
    function internshipUnitObtain(){
        $("#right").load("<%=request.getContextPath()%>/employments/obtainInternshipUnit");
    }
    function searchclear() {

        $("#internshipUnitNames").val("");

        search();
    }

    function search() {

        var classNameSel = $("#internshipUnitNames").val();
        if (classNameSel != "")
            classNameSel = '%' + classNameSel + '%';

        roleTable = $("#employmentsGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/employments/EmploymentsAction',
                "data": {
                    internshipUnitName:classNameSel,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "employmentUnitId", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "9%", "data": "internshipUnitName", "title": "单位名称"},
                {"width": "9%", "data": "unitEncoding", "title": "单位编码"},
                {"width": "9%", "data": "legalPerson", "title": "法人"},
                {"width": "9%", "data": "registeredCapital", "title": "注册资金"},
                {"width": "9%", "data": "personNumber", "title": "员工数"},
                {"width": "9%", "data": "unitPropertyShow", "title": "单位性质"},
                {"width": "9%", "data": "employmentIndustryShow", "title": "就业产业"},
                {"width": "9%", "data": "employmentPlaceShow", "title": "就业地点"},
                {"width": "9%", "data": "enterpriseCategoryShow", "title": "企业类别"},
                {"width": "9%", "data": "enterpriseScaleShow", "title": "企业规模"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='getEmploymentsById' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='del' class='icon-trash' title='删除'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='set' class='icon-search' title='查看详情'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }
</script>
