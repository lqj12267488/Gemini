<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/26
  Time: 9:53
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
                                申请部门：
                            </div>
                            <div class="col-md-2">
                                <input id="requestDept"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请人：
                            </div>
                            <div class="col-md-2">
                                <input id="requester"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="requestDate" type="date"
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
                        <table id="photographyGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>
    var photographyTable;

    $(document).ready(function () {
        //申请部门名称模糊查询下拉显示
        $.get("<%=request.getContextPath()%>/photography/getDept", function (data) {
            $("#requestDept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requestDept").val(ui.item.label);
                    $("#requestDept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })
        //申请人员姓名模糊程序
        $.get("<%=request.getContextPath()%>/photography/getPerson", function (data) {
            $("#requester").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#requester").val(ui.item.label);
                    $("#requester").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        search();

        photographyTable.on('click', 'tr a', function () {
            var data = photographyTable.row($(this).parent()).data();
            var id = data.id;
            //查看流程轨迹
            if (this.id == "sePhotography") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_PHOTOGRAPHY_WF",
                    url: "<%=request.getContextPath()%>/photography/auditPhotographyById?id=" + id,
                    backUrl: "/photography/complete"
                });
            }
            //反馈
            if (this.id == "delRole") {
                var data = photographyTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_PHOTOGRAPHY_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({title: msg.msg, type: "error"});
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_PHOTOGRAPHY_WF",
                                backUrl: "/photography/complete"
                            });
                        }
                    })
                }else{
                    swal({
                        title: "本申请已经完成反馈",
                        type: "info"
                    });
                   // alert("本申请已经完成反馈！");
                }
            }
        });
    });
    //查询条件清空
    function searchclear() {
        $("#requestDate").val("");
        $("#requester").val("");
        $("#requestDept").val("");
        search();
    }
    //按条件查询
    function search() {
        var requestDept = $("#requestDept").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        var requester = $("#requester").val();
        if (requester != "")
            requester = '%' + requester + '%';
        var requestDate = $("#requestDate").val();
        if (requestDate != "") {
            requestDate = '%' + requestDate + '%';
        }
        photographyTable = $("#photographyGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/photography/getPhotographyListComplete',
                "data": {
                    requester: requester,
                    requestDate: requestDate,
                    requestDept: requestDept
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                { "width": "7%", "data": "shootDate", "title": "拍摄时间"},
                { "width": "7%", "data": "shootingLocation", "title": "拍摄地点"},
                { "width": "7%", "data": "shootingMethod", "title": "拍摄方法"},
                { "width":"15%", "data": "machineNumber", "title": "摄影机机位数"},
                { "width":"8%", "data": "content","title": "活动内容"},
                { "width":"8%", "data": "requestDept", "title": "申请部门"},
                { "width": "8%", "data": "requester", "title": "申请人"},
                { "width": "8%", "data": "requestDate", "title": "申请日期"},
                {"width": "8%", "data": "requestFlag", "title": "请求状态"},
                {"width": "8%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "8%", "data": "feedBack", "title": "反馈意见"},
                {"width": "8%","title": "操作","render": function () {return "<a id='sePhotography' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;" +
                    "<a id='delRole' class='icon-comments' title='反馈'></a>";}}
            ],
            'order': [1, 'desc'],
            "dom": '<"rtlip">rtlip',
            language: language
        });
    }
</script>

