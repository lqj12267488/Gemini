<%--
  Created by IntelliJ IDEA.
  User: hanyu
  Date: 2017/6/28
  Time: 9:54
  To change this template use File | Settings | File Templates.
--%>
<%-- 已办 首页--%>
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
<div class="container" >
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestdate" type="date"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                姓名：
                            </div>
                            <div class="col-md-2">
                                <input id="nameSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                拟申报职称层次：
                            </div>
                            <div class="col-md-2">
                                <input id="appliedLevelSel" type="text"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="declare" cellpadding="0" cellspacing="0"
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
            var id = data.id;
            if (this.id == "handleDeclare") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_DECLARE_WF",
                    url: "<%=request.getContextPath()%>/declare/auditDeclareById?id=" + id,
                    backUrl: "/declare/complete"
                });
            }
            //反馈
            if (this.id == "delDeclare") {
                var data = roleTable.row($(this).parent()).data();
                var flag =  data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_DECLARE_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "error"});
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_DECLARE_WF",
                                backUrl: "/declare/complete"
                            });
                        }
                    })

                }else{
                    swal({
                        title: "本申请已经完成反馈！",
                        type: "info"
                    });
                }


            }
        });
    })

    function searchClear() {
        $("#requestdate").val("");
        $("#nameSel").val("");
        $("#appliedLevelSel").val("");
        search()
    }

    function search() {
        var name = $("#nameSel").val();
        var appliedLevel = $("#appliedLevelSel").val();
        var requestDate = $("#requestdate").val();
        if (requestDate != "")
            requestDate = '%' + requestDate + '%';

        roleTable = $("#declare").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/declare/getCompleteList',
                "data": {
                    requestDate: requestDate,
                    name: name,
                    appliedLevel: appliedLevel
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"width": "10%", "data": "requestDate", "title": "申请日期"},
                {"width": "10%", "data": "name", "title": "姓名"},
                {"width": "10%", "data": "sexShow", "title": "性别"},
                {"width": "10%", "data": "workDept", "title": "工作部门"},
                {"width": "10%", "data": "appliedLevel", "title": "拟申报职称层次"},
                {"width": "10%", "data": "requestFlag", "title": "请求状态"},
                {"width": "10%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "10%", "data": "feedBack", "title": "反馈意见"},
                {
                    "width": "10%",
                    "title": "操作",
                    "render": function () {
                        return  "<a id='handleDeclare' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='delDeclare' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
        /* $("div.toolbar").html('<button  type="button" class="btn btn-info btn-clean" onclick="addEmp()">新增</button>');*/
    }

</script>

