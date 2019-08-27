<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/8/17
  Time: 14:39
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
                                onclick="back()">返回
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
            if(this.id == "change"){
                $("#dialog").load("<%=request.getContextPath()%>/internships/changeEmployment?internshipUnitId="+internshipUnitId);
                $("#dialog").modal("show");
            }
            if(this.id == "selectId"){
                $.get("<%=request.getContextPath()%>/internshipExt/selectInterInfo?internshipUnitId=" + internshipUnitId, function (msg) {
                    if (msg.status == 0) {
                        $("#right").load("<%=request.getContextPath()%>/internships/getInternshipsId1?internshipUnitId=" + internshipUnitId);
                    }else {
                        swal({
                            title:"实习生实习未设置，无法查看详情。",
                            type: "error"
                        });
                        roleTable.ajax.url("<%=request.getContextPath()%>/internships/InternshipsActionList").load();
                    }
                })

            }
        });
    })


    function back() {
        $("#right").load("<%=request.getContextPath()%>/employments/request");

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
                "url": '<%=request.getContextPath()%>/internships/InternshipsActionList',
                "data": {
                    internshipUnitName:classNameSel,
                }
            },
            "destroy": true,
            "columns": [
                {"data": "internshipUnitId","visible": false},
                {"data": "createTime", "visible": false},
                {"width": "7%", "data": "internshipUnitName", "title": "单位名称"},
                {"width": "7%", "data": "area", "title": "所在地区"},
                {"width": "6%", "data": "address", "title": "地址"},
                {"width": "7%", "data": "contactPerson", "title": "联系人"},
                {"width": "7%", "data": "contactNumber", "title": "联系电话"},
                {"width": "12%", "data": "internshipWhetherRetentionShow", "title": "实习生是否留用"},
                {"width": "7%", "data": "cooperationTimeShow", "title": "合作时间"},
                {"width": "8%", "data": "enterprisePersonNumber", "title": "企业员工数"},
                {"width": "8%", "data": "registeredCapital", "title": "注册资金"},
                {"width": "8%", "data": "enterpriseNatureShow", "title": "企业性质"},
                {"width": "8%", "data": "legalPerson", "title": "法人代表"},
                {"width": "7%", "data": "enterpriseScaleShow", "title": "企业规模"},
                {
                    "width": "8%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='change' class='icon-share' title='转为就业单位'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='selectId' class='icon-search' title='详情'></a>";
                    }
                }
            ],
            'order' : [[1,'desc'],[2,'desc']],
            "dom": 'rtlip',
            language: language
        });
    }


</script>
