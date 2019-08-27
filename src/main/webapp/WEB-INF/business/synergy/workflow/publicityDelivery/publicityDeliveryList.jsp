<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/13
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%--自适应style--%>
<style>
    @media screen and (max-width: 1050px){
        .tar{
            width: 68px !important;
        }
    }
</style>

<div class="container"><%--最外层div--%>
    <div class="row"><%--top_extend_div--%>
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                申请日期:
                            </div>
                            <div class="col-md-2">
                                <input id="date" type="date"
                                       class="validate[required,maxSize[20]] form-control"/>
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean" onclick="addPublicityDelivery()">新增</button>
                    </div>
                    <div class="form-row block" style="overflow-y: auto;">
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
<input id="tableName" hidden value="T_BG_PUBLICITYDELIVERY_WF">
<input id="workflowCode" hidden value="T_BG_PUBLICITYDELIVERY_WF01">
<input id="businessId" hidden>
<script>
    var fileBtnsNews = "点击上传文件";
    var p_fileLength;//来接收list的长度
    var p_fileName = new Array();
    var p_fileUrl = new Array();
    var publicityDeliveryTable;
    var td_FilesName = '点击上传附件';
    var completeFilesFlag = false;//需要定位到td才行,待定
    var tableName = "book";
    var businessType = "XT";
    var flagEdit = false;//是否点击修改

    $(document).ready(function () {
        search();
        publicityDeliveryTable.on('click', 'tr a', function () {
            var data = publicityDeliveryTable.row($(this).parent()).data();
            var id = data.id;
            if (this.id == "uPublicityDelivery") {
                fileBtnsNews = "点击修改已上传的文件";
                $("#dialog").load("<%=request.getContextPath()%>/publicityDelivery/getPublicityDeliveryById?id=" + id);
                /*$("#picture").text("点击修改已上传的文件");*/
                $("#dialog").modal("show");
                flagEdit = true;
            }
            if (this.id == "delPublicityDelivery") {
                //if (confirm("请确认是否要删除本条申请?")) {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "发布渠道："+data.distributionChannelsShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("<%=request.getContextPath()%>/publicityDelivery/deletePublicityDeliveryById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            //alert(msg.msg);
                            $('#publicityDeliveryGrid').DataTable().ajax.reload();
                        }
                    })
                })
            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_PUBLICITYDELIVERY_WF');
                $('#dialogFile').modal('show');
            }
        });
    });
    function addPublicityDelivery() {
        $("#dialog").load("<%=request.getContextPath()%>/publicityDelivery/editPublicityDelivery");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#date").val("");
        search();
    }
    function search(){
        var requestDate = $("#date").val();
        if (requestDate != "")
            requestDate = '%'+ requestDate +'%';
        publicityDeliveryTable = $('#publicityDeliveryGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/publicityDelivery/getPublicityDeliveryList',
                "data": {
                    requestDate:requestDate
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
                        return qtip_td(data,type,row,meta,qtip_num,$('#publicityDeliveryGrid tr a'));
                    },"title": "标题"
                },
                {"width": "13%","data": "distributionChannelsShow","title": "发布渠道"},
                {"width": "13%","data": "requestDate", "title": "申请日期"},
                {"width": "13%","data": "requestDept", "title": "申请部门"},
                {"width": "12%","data": "requester", "title": "撰稿人"},
                /*{"width": "12%","title": "附件",render:function (data,type,row) {
                    return '<a href="#" onclick=turnFilesUpload("'+row.id+'")>'+td_FilesName+'</a>';
                }},*/
                {"width": "12%","data": "remark",
                    "render": function(data,type,row,meta){
                        data = row.remark;
                        return qtip_td(data,type,row,meta,qtip_num,$('#publicityDeliveryGrid tr a'));
                    },"title": "备注"
                },
                {"width" : "12%","title" : "操作","render" : function () {return "<a id='uPublicityDelivery' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='delPublicityDelivery' class='icon-trash' title='删除' ></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='submit' class='icon-upload-alt' title='提交'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
    }

    function turnFilesUpload(e) {
        if(completeFilesFlag){
            swal({title: "已经有文件上传过", type: "error"});
            //return alert('已经有文件上传过');
        }
        $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?personFilesId='+e+'&businessType=TEST');
        $('#dialogFile').modal('show');
    }

    function getAuditer() {
        $("#dialog").modal().load("<%=request.getContextPath()%>/toSelectAuditer")
    }
    function audit() {
        var personId;
        var handleName;
        var select = $("#personId").html();
        if (select != undefined) {
            if (handleName == undefined) {
                handleName = $("#personId option:selected").text();
            }
            if (personId == undefined) {
                personId = $("#personId option:selected").val();
            }
        } else {
            if (handleName == undefined) {
                handleName = $("#name").val();
            }
            if (personId == undefined) {
                personId = $("#personIds").val();
            }
        }
        if (personId == '') {
            swal({title: '请选择人员！',type: "warning"});
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_BG_PUBLICITYDELIVERY_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    //alert(msg.msg);
                    $("#dialog").modal("hide");
                    $('#publicityDeliveryGrid').DataTable().ajax.reload();
                }
            })
    }
</script>

















