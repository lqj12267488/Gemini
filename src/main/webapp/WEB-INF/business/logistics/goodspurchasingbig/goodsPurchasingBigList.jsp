<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/7/31
  Time: 15:38
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
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="search()">查询
                                </button>
                                <button type="button" class="btn btn-default btn-clean"
                                        onclick="searchClear()">清空
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="addGoodsPurchasingBig()">新增
                        </button>
                    </div>
                    <div class="form-row block" style="overflow-y: auto;">
                        <table id="goodsPurchasingBigGrid" cellpadding="0" cellspacing="0"
                               width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input id="tableName" hidden value="T_ZW_GOODSPURCHASINGBIG_WF">
<input id="workflowCode" hidden value="T_ZW_GOODSPURCHASINGBIG_WF">
<input id="businessId" hidden>
<script>
    var goodsPurchasingBigTable;
    //var td_FilesName = '点击上传附件';
    var completeFilesFlag = false;//需要定位到td才行,待定

    $(document).ready(function () {
        search();
        goodsPurchasingBigTable.on('click', 'tr a', function () {
            var data = goodsPurchasingBigTable.row($(this).parent()).data();
            var id = data.id;
            var goodsBigName = data.goodsBigName;
            if (this.id == "submit") {
                $("#businessId").val(id);
                getAuditer(data.budget);
            }
            if (this.id == "uGoodsPurchasingBig") {
                $("#dialog").load("<%=request.getContextPath()%>/goodsPurchasingBig/getGoodsPurchasingBigById?id=" + id);
                $("#dialog").modal("show");
            }
            if (this.id == "delGoodsPurchasingBig") {
                swal({
                    title: "您确定要删除本条信息?",
                    text: "采购物品：" + goodsBigName + "\n\n删除后将无法恢复，请谨慎操作",
                    type: "warning",
                    showCancelButton: true,
                    cancelButtonText: "取消",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    closeOnConfirm: false
                }, function () {
                    $.post("<%=request.getContextPath()%>/goodsPurchasingBig/deleteGoodsPurchasingBigById", {
                        id: id
                    }, function (msg) {
                        swal({
                            title: msg.msg,
                            type: "success"
                        });
                        $('#goodsPurchasingBigGrid').DataTable().ajax.reload();

                    });

                });
            }
            if (this.id == "upload") {
                $('#dialogFile').load('<%=request.getContextPath()%>/files/filesUpload?businessId=' + id + '&businessType=TEST&tableName=T_ZW_GOODSPURCHASINGBIG_WF');
                $('#dialogFile').modal('show');
            }
        });
    });

    /*公共刷新方法*/
    function flushGrid() {
        //TODO
    }

    function addGoodsPurchasingBig() {
        $("#dialog").load("<%=request.getContextPath()%>/goodsPurchasingBig/editGoodsPurchasingBig");
        $("#dialog").modal("show");
    }

    function searchClear() {
        $("#date").val("");
        search();
    }

    function search() {
        var requestDate = $("#date").val();
        if (requestDate != "")
            requestDate = '%' + requestDate + '%';
        goodsPurchasingBigTable = $('#goodsPurchasingBigGrid').DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/goodsPurchasingBig/getGoodsPurchasingBigList',
                "data": {
                    requestDate: requestDate
                }
            },
            "destroy": true,
            "columns": [
                {"data": "id", "visible": false},
                {"data": "createTime", "visible": false},
                {
                    "width": "10%", "data": "goodsBigName", "title": "采购物品",
                    "render": function (data, type, row, meta) {
                        if(row.goodsBigName!=null || row.goodsBigName!=undefined || row.goodsBigName!=0){
                            var tt=row.goodsBigName +"";
                            return "<span title='" + tt + "'>" + tt.substr(0, 10) + "</span>";
                        }
                    }
                },
                {"width": "10%", "data": "goodsBigNum", "title": "采购数量"},
                {"width": "10%", "data": "unit", "title": "物品单位"},
                {
                    "width": "10%", "data": "reason", "title": "申请事由",
                    "render": function (data, type, row, meta) {
                        if(row.reason!=null || row.reason!=undefined || row.reason!=0){
                            var tt=row.reason +"";
                            return "<span title='" + tt + "'>" + tt.substr(0, 10) + "</span>";
                        }
                    }
                },
                {"width": "11%", "data": "budget", "title": "预算(万元)"},
                {"width": "10%", "data": "requestDate", "title": "申请日期"},
                {"width": "10%", "data": "requestDept", "title": "申请部门"},
                {"width": "10%", "data": "requester", "title": "申请人"},
                {
                    "width": "10%", "data": "remark", "title": "备注",

                },
                {
                    "width": "9%", "title": "操作",
                    "render": function () {
                        return "<a id='uGoodsPurchasingBig' class='icon-edit' title='修改'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='upload' class='icon-cloud-upload' title='上传附件'></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='delGoodsPurchasingBig' class='icon-trash' title='删除' ></a>&nbsp;&nbsp;&nbsp;" +
                            "<a id='submit' class='icon-upload-alt' title='提交'></a>";
                    }
                }
            ],
            'order': [1, 'desc'],
            "dom": 'rtlip',
            language: language
        });
    }
function getAuditer(e) {
        if ( e < 5) {
            $('#workflowCode').val('T_ZW_GOODSPURCHASINGBIG_WF02');
        }else{
            $('#workflowCode').val('T_ZW_GOODSPURCHASINGBIG_WF01');
        }
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
        if(personId==null || personId=="" || personId==undefined)
        {
            swal({
                title: "请选择办理人!",
                type: "info"
            });
            return;
        }
        $.post("<%=request.getContextPath()%>/submit", {
                businessId: $("#businessId").val(),
                tableName: "T_ZW_GOODSPURCHASINGBIG_WF",
                workflowCode: $("#workflowCode").val(),
                handleUser: personId,
                handleName: handleName
            },
            function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg, type: "success"});
                    $("#dialog").modal("hide");
                    $('#goodsPurchasingBigGrid').DataTable().ajax.reload();
                }
            })
    }
</script>








