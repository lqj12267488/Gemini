<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/6/28
  Time: 9:56
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
                        <button type="button" class="btn btn-default btn-clean" onclick="addScreenUse()">新增</button>
                    </div>
                    <div class="form-row block" style="overflow-y: auto;">
                        <table id="screenUseGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_BG_SCREENUSE_WF">
<input id="workflowCode" hidden value="T_BG_SCREENUSE_WF01">
<input id="businessId" hidden>
<script>
    var screenUseTable;
    $(document).ready(function () {
        search();
        screenUseTable.on('click', 'tr a', function () {
            var data = screenUseTable.row($(this).parent()).data();
            var id = data.id;
            var screenShow = data.screenShow;
            var content = data.content;
            if (this.id == "uScreenUse") {
                $("#dialog").load("<%=request.getContextPath()%>/screenUse/getScreenUseById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delScreenUse") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "大屏幕："+screenShow+"\n\n删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.get("/screenUse/deleteScreenUseById?id=" + id, function (msg) {
                        if (msg.status == 1) {
                            swal({
                                title: msg.msg,
                                type: "success"
                            });
                            $('#screenUseGrid').DataTable().ajax.reload();
                        }
                    })

                });

            }
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer();
            }
            if (this.id == "upload"){
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_BG_SCREENUSE_WF');
                $('#dialogFile').modal('show');
            }
        });
    });
    function addScreenUse() {
        $("#dialog").load("<%=request.getContextPath()%>/screenUse/editScreenUse");
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
        screenUseTable = $('#screenUseGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/screenUse/getScreenUseList',
                "data": {
                    requestDate:requestDate
                }
            },
            "destroy": true,
            "columns": [
                {"data" : "id","visible" : false},
                {"data" : "createTime","visible" : false},
                {"data" : "screen","visible" : false},
                {"width": "14%","data":"content",
                    "render": function(data,type,row,meta){
                        data = row.content;
                        qtip_num = 4;
                        return qtip_td(data,type,row,meta,qtip_num,$('#screenUseGrid tr a'));
                    },"title": "申请内容"
                },
                {"width": "14%","data": "screenShow","title": "大屏幕"},
                {"width": "10%","data": "usingTime", "title": "使用日期"},
                {"width": "12%","data": "requestDept", "title": "申请部门"},
                {"width": "10%","data": "requester", "title": "经办人"},
                {"width": "10%","data": "requestDate", "title": "申请日期"},
                {"width": "14%","data": "remark",
                    "render":function(data,type,row,meta){
                        data = row.remark;
                        return qtip_td(data,type,row,meta,qtip_num,$('#screenUseGrid tr a'));
                    }, "title": "备注"
                },
                {"width" : "16%","title" : "操作","render" : function () {return "<a id='uScreenUse' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='delScreenUse' class='icon-trash' title='删除' ></a>&nbsp;&nbsp;&nbsp;"+
                    "<a id='submit' class='icon-upload-alt' title='提交'></a>";}}
            ],
            'order' : [1,'desc'],
            "dom": 'rtlip',
            language: language
        });
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
                tableName: "T_BG_SCREENUSE_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName,
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({
                        title: msg.msg,
                        type: "success"
                    });
                    $("#dialog").modal("hide");
                    $('#screenUseGrid').DataTable().ajax.reload();
                }
            })
    }
    //ajax参数自动提示框
    /*function qtip_td(data, type, row, meta) {
         var render_td = data;
         if (data.length > 8) {
             //"<a  title='"+data +"'>"+data.substring(0, 7) + "..."+"</a>";
             render_td = "<a  title='"+data +"'>"+data.substring(0, 7) + "..."+"</a>";
             return render_td;
         }
         return render_td;
     }*/

</script>
















