<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/13
  Time: 16:50
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
                                <input id="dept"
                                       class="validate[required,maxSize[100]] form-control"/>
                            </div>
                            <div class="col-md-1 tar">
                                撰稿人：
                            </div>
                            <div class="col-md-2">
                                <input id="requester" />
                            </div>
                            <div class="col-md-1 tar">
                                申请时间：
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[100]] form-control"/>
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
                        <table id="publicityDeliveryGrid" cellpadding="0" cellspacing="0" width="100%"
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
    var publicityDeliveryTable;
    var td_FilesDownName = '查看';


    $(document).ready(function () {

        $.get("<%=request.getContextPath()%>/publicityDelivery/getDept", function (data) {
            $("#dept").autocomplete({
                source: data,
                select: function (event, ui) {
                    $("#dept").val(ui.item.label);
                    $("#dept").attr("keycode", ui.item.value);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                    .append("<a>" + item.label + "</a>")
                    .appendTo(ul);
            };
        })

        $.get("<%=request.getContextPath()%>/publicityDelivery/getPerson", function (data) {
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
        publicityDeliveryTable.on('click', 'tr a', function () {
            var data = publicityDeliveryTable.row($(this).parent()).data();
            var id = data.id;
            //查看流程轨迹
            if (this.id == "handleFlowTtrack") {
                $("#right").load("<%=request.getContextPath()%>/getWotkflowLog", {
                    businessId: id,
                    tableName: "T_BG_PUBLICITYDELIVERY_WF",
                    url: "<%=request.getContextPath()%>/publicityDelivery/auditPublicityDeliveryById?id=" + id,
                    backUrl: "/publicityDelivery/complete"
                });
            }
            //反馈
            if (this.id == "feedbackReport") {
                var data = publicityDeliveryTable.row($(this).parent()).data();
                var flag = data.feedbackFlag;
                if(flag == "未反馈"  || flag == undefined){
                    $.post("<%=request.getContextPath()%>/getBusinessStatus", {
                        tableName: "T_BG_PUBLICITYDELIVERY_WF",
                        businessId: id,
                    }, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "error"
                            });
                            //alert(msg.msg)
                        } else {
                            $("#right").load("<%=request.getContextPath()%>/getFeedback", {
                                businessId: id,
                                tableName: "T_BG_PUBLICITYDELIVERY_WF",
                                backUrl: "/publicityDelivery/complete"
                            });
                        }
                    })
                }else{
                    swal({title: "本申请已经完成反馈", type: "error"});
                    //alert("本申请已经完成反馈！");
                }

            }
        });
    })

    function searchClear() {
        $("#dept").val("");
        $("#requester").val("");
        $("#date").val("");
        search();
    }
    function search(){
        var dept = $("#dept").val();
        var requester = $("#requester").val();
        if (dept != "")
            dept = '%' + dept + '%';
        if (requester != "")
            requester = '%' + requester + '%';
        var requestDate = $("#date").val();
        if (requestDate != "")
            requestDate = '%'+ requestDate +'%';
        publicityDeliveryTable = $('#publicityDeliveryGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/publicityDelivery/getPublicityDeliveryComplete',
                "data": {
                    requestDept: dept,
                    requester: requester,
                    requestDate:requestDate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {"data": "distributionChannels", "visible": false},
                {"width": "8%",
                    "render": function(data,type,row,meta){
                        data = row.caption;
                        return qtip_td(data,type,row,meta,qtip_num,$('#publicityDeliveryGrid tr a'));
                    },"title": "标题"
                },
                {"width": "9%","data": "distributionChannelsShow","title": "发布渠道"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "9%","data": "requestDept", "title": "申请部门"},
                {"width": "8%","data": "requester", "title": "撰稿人"},
                {"width": "8%","data": "remark",
                    "render": function(data,type,row,meta){
                        data = row.remark;
                        return qtip_td(data,type,row,meta,qtip_num,$('#publicityDeliveryGrid tr a'));
                    },"title": "备注"
                },
                {"width": "7%","title": "附件",render:function (data,type,row) {
                    return '<a href="#" onclick=turnFilesDownload("'+row.id+'")>'+td_FilesDownName+'</a>';
                }},
                {"width": "10%", "data": "requestFlag", "title": "请求状态"},
                {"width": "10%", "data": "feedbackFlag", "title": "反馈状态"},
                {"width": "10%", "data": "feedback", "title": "反馈意见"},
                {
                    "width": "6%",
                    "title": "操作",
                    "render": function () {
                        return "<a id='handleFlowTtrack' class='icon-search' title='查看流程轨迹'></a>&nbsp;&nbsp;&nbsp;"+
                            "<a id='feedbackReport' class='icon-comments' title='反馈'></a>";
                    }
                }
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    function turnFilesDownload(e) {
        $('#dialogFile').load('<%=request.getContextPath()%>/files/lookFiles?personFilesId='+e);
        $('#dialogFile').modal('show');
    }

</script>









