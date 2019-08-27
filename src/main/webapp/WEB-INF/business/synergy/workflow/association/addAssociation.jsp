<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2017/4/14
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal-dialog" style="width: 1200px">
    <div class="modal-content block-fill-white">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;
            </button>
            <h4 class="modal-title">关联已办结业务</h4>
        </div>
        <div class="modal-body clearfix">

            <div class="form-row">
                <div class="col-md-1 tar">
                    工作流业务:
                </div>
                <div class="col-md-2">
                    <select id="workflowId" class="js-example-basic-single"></select>
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
            <div class="form-row" id="workflowDiv">
                <div  class="form-row block" style="overflow-y:auto;">
                    <table id="workflowGrid" cellpadding="0" cellspacing="0"
                           width="100%" style="max-height: 50%;min-height: 10%;"
                           class="table table-bordered table-striped sortable_default">
                        <thead>
                        <tr>
                            <th width="10%"><input type="checkbox" id="checkAll" onclick="checkAll()"/>
                            </th>
                            <th>businessId</th>
                            <th>url</th>
                            <th>appUrl</th>
                            <th>tableName</th>
                            <th>可关联的已办结业务</th>
                            <th>申请日期</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="form-row">
                <div id="jump" ></div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default btn-clean" onclick="addRelation()" data-dismiss="modal">保存
            </button>
            <button type="button" class="btn btn-default btn-clean" data-dismiss="modal">关闭
            </button>
        </div>
    </div>
    <input id="id" hidden value="${id}">
    <input id="workflowCode" hidden value="${workflowCode}">
</div>
<script>
    var workflowCode=$("#workflowCode").val();
    var workflow;
    var workflowId= $("#workflowId option:selected").val();
    $(document).ready(function () {
        $.get("<%=request.getContextPath()%>/common/getTableDict",{
                id: " workflow_id ",
                text: " workflow_name ",
                tableName: "t_sys_workflow",
                where: "where workflow_name!=' ' and workflow_code !='"+ workflowCode+"'",
                orderby: " "
            },
            function (data) {
                addOption(data, "workflowId");
            })
        var workflowId= $("#workflowId option:selected").val();
        if (workflowId==undefined || workflowId == ""){
            workflowId = '%%';
        }else{
            workflowId = '%'+$("#workflowId option:selected").val()+'%';
        }

         workflow = $("#workflowGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/association/workflowList',
                "data": {
                    id:  $("#id").val(),
                    workflowId : workflowId,
                    workflowCode:workflowCode,
                }
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='"+row.businessId+","+ row.url + "," + row.appUrl + " '/>";
                    }
                },
                {"width": "10%", "data": "businessId", "visible": false},
                {"width": "10%", "data": "url", "visible": false},
                {"width": "10%", "data": "appUrl", "visible": false},
                {"width": "10%", "data": "tableName", "visible": false},
                {"width": "50%", "data": "text"},
                {"width": "28%", "data": "createTime"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-eye-open" title="查看详情" onclick=seeValues("' + row.businessId + '","'+ row.url + '","'+ row.tableName + '")/>';
                    },
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order' : [[5,'desc']],
            "dom": 'rtlip',
            language: language
        })
    });
    function searchClear() {
        $("#workflowId").val("");
        search();
    }

    function search() {
        var workflowId= $("#workflowId option:selected").val();
        if (workflowId==undefined || workflowId == ""){
            workflowId = '%%';
        }else{
            workflowId = '%'+$("#workflowId option:selected").val()+'%';
        }
        workflow = $("#workflowGrid").DataTable({
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/association/workflowList',
                "data": {
                    id:  $("#id").val(),
                    workflowId : workflowId,
                    workflowCode:workflowCode,
                }
            },
            "destroy": true,
            "columns": [
                {
                    "render": function (data, type, row) {
                        return "<input type='checkbox' name='checkbox' value='"+row.businessId+","+ row.url + "," + row.appUrl + " '/>";
                    }
                },
                {"width": "10%", "data": "businessId", "visible": false},
                {"width": "10%", "data": "url", "visible": false},
                {"width": "10%", "data": "appUrl", "visible": false},
                {"width": "10%", "data": "tableName", "visible": false},
                {"width": "60%", "data": "text"},
                {"width": "28%", "data": "createTime"},
                {
                    "width": "12%",
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-eye-open" title="查看详情" onclick=seeValues("' + row.businessId + '","'+ row.url + '","'+ row.tableName + '")/>';
                    },
                }
            ],
            "columnDefs": [{
                "orderable": false, "targets": [0]
            }],
            'order' : [[5,'desc']],
            "dom": 'rtlip',
            language: language
        })

    }
    function seeValues(businessId,url,tableName) {
        $("#dialogFile").css("display","block");
        $("#dialogFile").load("<%=request.getContextPath()%>/funds/getWotkflowLog?businessId="+businessId+"&url="+url+"&tableName="+tableName+"&type=1");
    }
    function checkAll() {
        if ($("#checkAll").attr("checked")) {
            $("[name='checkbox']").attr("checked", "checked");
        } else {
            $("[name='checkbox']").removeAttr("checked");
        }
    }
    function addRelation() {
        var ids = '';
        var id = "";
        var length=$('input[name="checkbox"]:checked').length;
        if (length >= 1) {
            $('input[name="checkbox"]:checked').each(function () {
                ids+="'" + $(this).val()  + ",${id}',";
                //id += $(this).val() + ",";

            });
            ids = ids.substring(0,ids.length-1);
            $.post("<%=request.getContextPath()%>/funds/saveRelationFunds", {
                ids: ids
            }, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                });
                //alert(msg.msg);
                $("#dialog").modal('hide');
                $("#relationFundsGrid").DataTable().ajax.reload();
            })

        }else{
            swal({
                title: "请至少选择一条要关联的业务",
                type: "info"
            });
            //alert("请至少选择一条要关联的业务!")
        }

    }
</script>