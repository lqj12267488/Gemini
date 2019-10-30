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
                "url": '<%=request.getContextPath()%>/repair/repairDefine',
            },
            "destroy": true,
            "columns": [
                {"data": "repairID", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "repairType", "visible": false},
                {"data": "repairmanID", "visible": false},
                { "width": "9%", "data":"repairTypeShow", "title": "报修种类"},
                // { "width":"9%", "data": "assetsID", "title": "资产编号"},
                // { "width":"9%", "data": "position", "title": "所在位置"},
                { "width": "8%", "data":"creatorName", "title": "申请人"},
                { "width": "8%", "data":"dept", "title": "所在部门"},
                { "width": "9%", "data":"itemNameShow", "title": "报修物品名称"},
                { "width": "9%", "data":"repairAddress", "title": "维修地址"},
                { "width": "9%", "data":"faultDescription", "title": "故障描述"},
                { "width": "9%", "data":"contactNumber", "title": "联系人电话"},
                { "width": "9%", "data":"requestFlag", "title": "请求状态"},
                { "width": "11%", "data":"suppliesFlag", "title": "是否使用耗材"},
                { "width": "8%", "data":"feedback", "title": "反馈意见"},
                { "width": "8%", "data":"feedbackFlag", "title": "反馈状态"},
                // { "width": "8%", "data":"contactNumber", "title": "联系人电话"},
                // { "width": "8%", "data":"requestFlag", "title": "请求状态"},
                {"width":"7%","data":"assignTime","title":"分配时间"},
                //{ "width": "8%", "data":"suppliesFlag", "title": "是否使用耗材"},
                /*{ "width": "8%", "data":"feedback", "title": "反馈意见"},
                { "width": "6%", "data":"feedbackFlag", "title": "反馈状态"},*/
                {"width": "8%","title": "操作", "render": function () {
                    return "<a id='editRepair' class='icon-edit' title='确认维修'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='addSupplies' class='icon-plus' title='添加耗材'></a>&nbsp;&nbsp;&nbsp;"+
                        "<a id='upload' class='icon-cloud-upload' title='上传维修附件'></a>&nbsp;&nbsp;&nbsp;" +
                        "<a id='dolw' class='icon-eye-open' title='维修附件查看'></a>";
                }}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            "language": language
        });
        repairTable.on('click', 'tr a', function () {
            var data = repairTable.row($(this).parent()).data();
            var repairID = data.repairID;
            //提交
            if (this.id == "editRepair") {
                if(data.requestFlag=="维修完成"){
                    swal({
                        title: "此维修任务已完成,不可重复提交！",
                        type: "error"
                    });
                    return;
                }
                else {
                    $.post("<%=request.getContextPath()%>/repair/checkRequestFlag",{
                        repairID:repairID
                    },function(msg) {
                        if(msg.status == 1){
                            swal({
                                title: "您以确认维修,不可重复确认！",
                                type: "info"
                            });
                        }else {
                            $("#dialog").load("<%=request.getContextPath()%>/repair/repairContent?repairID=" + repairID);
                            $("#dialog").modal("show");
                        }
                    })
                }
            }
            if (this.id == "addSupplies") {
                $("#right").load("<%=request.getContextPath()%>/repair/addSupplies?repairID=" +repairID);
            }

            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + getBusinessId(repairID,data.repairmanID)+ '&businessType=TEST&tableName=T_ZW_REPAIR');
                $('#dialogFile').modal('show');
            }

            if (this.id == "dolw") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + getBusinessId(repairID,data.repairmanID) + '&businessType=TEST&tableName=T_ZW_REPAIR');
                $('#dialogFile').modal('show');
            }

        });
    })
    function searchclear() {
        $("#rname").val("");
        search();
    }

    function search() {
       var itemName = $("#rname").val();
        repairTable.ajax.url("<%=request.getContextPath()%>/repair/repairDefine?itemName=" +itemName).load();
    }


    function getBusinessId(repairID,repairmanID) {
        return repairID.substring(0,24)+repairmanID.substring(24,36);
    }
</script>

