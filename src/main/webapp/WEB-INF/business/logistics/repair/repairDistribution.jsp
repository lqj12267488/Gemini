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
                    <%--<button type="button" class="btn btn-default btn-clean" onclick="printDate()">打印
                    </button>--%>
                    <table id="repairTable" cellpadding="0" cellspacing="0" width="100%"
                           class="table table-bordered table-striped sortable_default">
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="repairID" hidden value="${repair.repairID}">
<input id="requestFlagSel" hidden value="${repair.requestFlag}">
<script>
    var repairTable;
    //维修任务分配主页面显示的数据
    $(document).ready(function () {

        repairTable = $("#repairTable").DataTable({
            "ajax": {
                "url": '<%=request.getContextPath()%>/repair/distributionInfo?repairID=' + $("#repairID").val(),
            },
            "destroy": true,
            "columns": [
                {"data": "repairID", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "repairType", "visible": false},
                {"data": "repairmanID", "visible": false},
                {"width": "10%", "data": "repairTypeShow", "title": "报修种类"},
                {"width": "10%", "data": "creatorName", "title": "申请人"},
                {"width": "10%", "data": "dept", "title": "所在部门"},
                {"width": "11%", "data": "itemNameShow", "title": "报修物品名称"},
                {"data": "itemName", "visible": false},
                {"width": "10%", "data": "repairAddress", "title": "维修地址"},
                {"width": "10%", "data": "faultDescription", "title": "故障描述"},
                {"width": "10%", "data": "contactNumber", "title": "联系人电话"},
                {"width": "10%", "data": "repairmanShow", "title": "维修员"},
                {"width": "9%", "data": "requestFlag", "title": "请求状态"},
                {"width": "10%", "data": "feedback", "title": "反馈意见"},
                {"width": "9%", "data": "feedbackFlag", "title": "反馈状态"},
                {
                    "width": "9%", "title": "操作", "render": function () {
                        return "<a id='submitRepair' class='icon-upload-alt' title='分配任务'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='dolw' class='icon-cloud-download' title='附件查看'></a>&nbsp;&nbsp;&nbsp;"
                            // + "<a id='selectId' class='icon-search' title='详情'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            "language": language
        });
        repairTable.on('click', 'tr a', function () {
            var data = repairTable.row($(this).parent()).data();
            var repairID = data.repairID;
            var itemName = data.itemName;
            var flag = data.requestFlag;
            //分配任务
            if (this.id == "submitRepair") {
                $.get("<%=request.getContextPath()%>/repair/getStatus?requestFlag=" + flag,function (msg) {
                    if (msg.status == 0) {
                        swal({
                            title: "此请求状态为维修完成，不可再进行分配任务！",
                            type: "error"
                        });
                        return;

                    } else {
                        $("#dialog").load("<%=request.getContextPath()%>/repair/getDistribution?repairID=" + repairID+"&repairmanID="+data.repairmanID);
                        $("#dialog").modal("show");
                    }
                })

            }
            //任务详情
            if (this.id == "searchFenPei") {
                $("#right").load("<%=request.getContextPath()%>/repair/searchFenPei?repairID=" + repairID);
                $("#dialog").modal("show");
            }
            if (this.id == "dolw") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload1?businessId=' + repairID + '&businessType=TEST&tableName=T_ZW_REPAIR');
                $('#dialogFile').modal('show');
            }

            <%--if(this.id == "selectId"){--%>
                <%--$("#dialog").load("<%=request.getContextPath()%>/repair/searchDetils?repairID=" + repairID);--%>
                <%--$("#dialog").modal("show");--%>
            <%--}--%>
            //删除
            if (this.id == "deleteRepair") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "报修物品：" + itemName + "\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "green",
                    confirmButtonText: "提交",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/repair/deleteRepairById", {
                        id: repairID
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#repairTable').DataTable().ajax.reload();

                    });

                });
            }
        });
    })

    function searchclear() {
        $("#rname").val("");
        $("#name").val("");
        search();
    }

    function search() {
        var itemName = $("#rname").val();
        repairTable.ajax.url("<%=request.getContextPath()%>/repair/distributionInfo?itemName=" + itemName).load();
    }
</script>

