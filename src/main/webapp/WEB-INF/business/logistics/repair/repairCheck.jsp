<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 14:09
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
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                报修物品名称：
                            </div>
                            <div class="col-md-2">
                                <input id="rname" type="text"
                                       class="validate[required,maxSize[100]] form-control"/>
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
                <div class="content">
                    <%--<div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addRepair()">新增
                        </button>
                        <br>
                    </div>--%>
                    <table id="repairTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="repairID" hidden value="${repair.repairID}">
<script>
    var repairTable;
    //主页面显示的条件
    $(document).ready(function () {
        repairTable = $("#repairTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repair/checkInfo',
            },
            "destroy": true,
            "columns": [
                {"data": "repairID", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "repairType", "visible": false},
                { "width": "10%", "data":"repairTypeShow", "title": "报修种类"},
                { "width": "10%", "data":"dept", "title": "所在部门"},
                { "width": "10%", "data":"itemNameShow", "title": "报修物品名称"},
                { "width": "10%", "data":"repairAddress", "title": "维修地址"},
                { "width": "10%", "data":"faultDescription", "title": "故障描述"},
                { "width": "10%", "data":"contactNumber", "title": "联系人电话"},
                { "width": "10%", "data":"checkFlag", "title": "回检状态"},
                /*{ "width": "9%", "data":"checkResult", "title": "回检结果"},*/
                { "width": "10%", "data":"feedbackFlag", "title": "反馈状态"},
                {"width": "10%","title": "操作", "render":
                        function () {return "<a id='editRepair' class='icon-edit' title='回检分配'></a>&nbsp;&nbsp;&nbsp;";}
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            "language": language
        });
        repairTable.on('click', 'tr a', function () {
            var data = repairTable.row($(this).parent()).data();
            var repairID = data.repairID;
            //修改
            if (this.id == "editRepair") {
                $("#dialog").load("<%=request.getContextPath()%>/repair/addCheckMan?repairID=" + repairID);
                $("#dialog").modal("show");
            }

        });
    })
    function searchclear() {
        $("#rname").val("");
        search();
    }

    function search() {
       var itemName = $("#rname").val();
        repairTable.ajax.url("<%=request.getContextPath()%>/repair/checkInfo?itemName="+itemName).load();
    }
</script>

