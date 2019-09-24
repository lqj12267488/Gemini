<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
            <div class="block block-drop-shadow content block-fill-white">
                 <#list queryMapList as col>
                 <#if col?counter % 4 ==1>
  <div class="form-row">
                 </#if>
                        <div class="col-md-1 tar">
                            ${col.comments}：
                        </div>
                        <div class="col-md-2">
                            <#if col.dic??>
                            <select id="${col.queryCol}Sel"></select>
                           <#else>
                            <input id="${col.queryCol}Sel">
                            </#if>
                        </div>
                 <#if col?counter % 4 ==3>
                  </div>
                  </#if>
                 </#list>
                <div class="col-md-2 tar">
                    <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                    <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                </div>
            </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row">
                        <button type="button" class="btn btn-default btn-clean"
                                onclick="add()">新增
                        </button>
                        <br>
                    </div>
                    <div class="form-row block" style="overflow-y:auto;">
                        <table id="table" cellpadding="0" cellspacing="0"
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
    $(document).ready(function () {

        <#list queryMapList as col>
        <#if col.dic??>
            $.get("<%=request.getContextPath()%>/common/getSysDict?name=${col.dic}", function (data) {
                addOption(data,'${col.queryCol}Sel');
            });
        </#if>
        </#list>

        search();
    })

    function search() {
        $("#table").DataTable({
             "processing": true,
             "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>${url}/get${beanName?cap_first}List',
                <#if queryMapList??>
                "data": {
                    <#list queryMapList as col>
                    ${col.queryCol}: $("#${col.queryCol}Sel").val(),
                    </#list>
                }
                </#if>
            },
            "destroy": true,
            "columns": [
                 {"data": "${primary}", "title": "主键id", "visible": false},
             <#list queryMapList as col>
                 <#if col.dic??>
                 {"data": "${col.queryCol}Show", "title": "${col.comments}"},
                 <#else >
                 {"data": "${col.queryCol}", "title": "${col.comments}"},
                 </#if>
             </#list>
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.${primary} + '")></span>&ensp;&ensp;' +
                                '<span class="icon-trash" title="删除" onclick=del("' + row.${primary} + '")></span>';
                    }
                }
            ],
            "dom": 'rtlip',
            paging: true,
            language: language
        });
    }

    function searchClear() {
        $(".form-row div input,.form-row div select").val("");
        search();
    }

    function add() {
        $("#dialog").load("<%=request.getContextPath()%>${url}/to${beanName?cap_first}Add")
        $("#dialog").modal("show")
    }

    function edit(id) {
        $("#dialog").load("<%=request.getContextPath()%>${url}/to${beanName?cap_first}Edit?id=" + id)
        $("#dialog").modal("show")
    }

    function del(id) {
        swal({
            title: "您确定要删除本条信息?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.get("<%=request.getContextPath()%>${url}/del${beanName?cap_first}?id=" + id, function (msg) {
                swal({
                    title: msg.msg,
                    type: "success"
                }, function () {
                    $('#table').DataTable().ajax.reload();
                });
            })
        });
    }
</script>