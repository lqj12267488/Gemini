<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/13
  Time: 16:46
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
                                <input id="requester"
                                       class="validate[required,maxSize[100]] form-control"/>
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
                    <%--<div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addDeviceUse()">办理
                        </button>
                        <br>
                    </div>--%>
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
    var roleTable;
    var td_FilesDownName = '点击查看文件';

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
        roleTable.on('click', 'tr a', function () {
            var data = roleTable.row($(this).parent()).data();
            var publicityDeliveryProcessId = data.id;
            //修改
            if (this.id == "uPublicityDeliveryProcess") {
                $.post("<%=request.getContextPath()%>/getStartState", {
                    tableName: "T_BG_PUBLICITYDELIVERY_WF",
                    businessId: publicityDeliveryProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "error"
                        });
                        //alert(msg.msg)
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toEditBusiness", {
                            businessId: publicityDeliveryProcessId,
                            tableName: "T_BG_PUBLICITYDELIVERY_WF",
                            url: "<%=request.getContextPath()%>/publicityDelivery/auditPublicityDeliveryEdit?id=" + publicityDeliveryProcessId,
                            backUrl: "<%=request.getContextPath()%>/publicityDelivery/process",
                        });
                    }
                })
            }
            //办理
            if (this.id == "handleAudit") {
                $.post("<%=request.getContextPath()%>/getRejectState", {
                    tableName: "T_BG_PUBLICITYDELIVERY_WF",
                    businessId: publicityDeliveryProcessId,
                }, function (msg) {
                    if (msg.status == 1) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                    } else {
                        $("#right").load("<%=request.getContextPath()%>/toAudit", {
                            businessId: publicityDeliveryProcessId,
                            tableName: "T_BG_PUBLICITYDELIVERY_WF",
                            url: "/publicityDelivery/auditPublicityDeliveryById?id=" + publicityDeliveryProcessId,
                            backUrl: "/publicityDelivery/process"
                        });
                    }
                })
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_PUBLICITYDELIVERY_WF');
                $('#dialogFile').modal('show');
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
        var requestDept = $("#dept").val();
        var requester = $("#requester").val();
        if (requestDept != "")
            requestDept = '%' + requestDept + '%';
        if (requester != "")
            requester = '%' + requester + '%';
        var date = $("#date").val();
        if(date != ""){
            date = '%' + date + '%';
        }
        roleTable = $('#publicityDeliveryGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/publicityDelivery/getPublicityDeliveryProcess',
                "data": {
                    requestDept: requestDept,
                    requester: requester,
                    requestDate: date
                }
            },
            "destroy": true,
            "columns": [
                {"data" : "id","visible" : false},
                {"data" : "createTime","visible" : false},
                {"data" : "distributionChannels","visible" : false},
                {"width": "13%",
                    "render": function(data,type,row,meta){
                        data = row.caption;
                        qtip_num = 4;
                        return qtip_td(data,type,row,meta,qtip_num,$('#publicityDeliveryGrid tr a'));
                    },"title": "标题"
                },
                {"width": "13%","data": "distributionChannelsShow","title": "发布渠道"},
                {"width": "13%","data": "requestDate", "title": "申请日期"},
                {"width": "13%","data": "requestDept", "title": "申请部门"},
                {"width": "12%","data": "requester", "title": "撰稿人"},
                /*{"width": "12%","title": "附件",render:function (data,type,row) {
                    return '<a href="#" onclick=("'+row.id+'")>'+td_FilesDownName+'</a>';
                }},*/
                {"width": "12%","data": "remark",
                    "render": function(data,type,row,meta){
                        data = row.remark;
                        return qtip_td(data,type,row,meta,qtip_num,$('#publicityDeliveryGrid tr a'));
                    },"title": "备注"
                },
                {"width" : "12%","title" : "操作","render" : function () {return "<a id='handleAudit' class='icon-file-text-alt' title='办理'></a>&nbsp;&nbsp;&nbsp;"  +
                    "<a id='uPublicityDeliveryProcess' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;"  +
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
    function turnFilesDownload(e) {
        /*if(completeFilesFlag){
         return alert('已经有文件上传过');
         }*/
        $('#dialogFile').load('<%=request.getContextPath()%>/files/lookFiles?personFilesId='+e);
        $('#dialogFile').modal('show');
    }


</script>


