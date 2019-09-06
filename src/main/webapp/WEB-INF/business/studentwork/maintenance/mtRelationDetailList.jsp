<%--
  Created by IntelliJ IDEA.
  User: hanjie
  Date: 2019/9/2
  Time: 17:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="block">
                <div class="block block-drop-shadow">
                    <div class="content block-fill-white">
                        <div class="form-row">
                            <div class="col-md-1 tar">
                                公物类别：
                            </div>
                            <div class="col-md-2">
                                <select id="mtSel"> </select>
                            </div>
                            <div class="col-md-1 tar">
                                物品名称：
                            </div>
                            <div class="col-md-2">
                                <input id="goodNameSel"/>
                            </div>
                            <div class="col-md-2 tar">
                                <button  type="button" class="btn btn-default btn-clean" onclick="search()">查询</button>
                                <button  type="button" class="btn btn-default btn-clean" onclick="searchClear()">清空</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="block block-drop-shadow content">
                    <div class="form-row block" style="overflow-y:auto;">
                        <div class="form-row">
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="back()">返回
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="addMRDetail()">新增
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="importMRDetailTemplate()">下载导入模板
                            </button>
                            <button type="button" class="btn btn-default btn-clean"
                                    onclick="importMRDetail()">导入
                            </button>

                            <br>
                        </div>
                        <table id="mRDetailGrid" cellpadding="0" cellspacing="0" width="100%"
                               style="max-height: 50%;min-height: 10%;"
                               class="table table-bordered table-striped sortable_default">
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {

        $(function () {
            $.get("<%=request.getContextPath()%>/common/getTableDict", {
                    id: " MT_ID ",
                    text: " MT_NAME",
                    tableName: " T_XG_MAINTENANCE_TYPE ",
                    where:" where  valid_flag = '1'"
                },
                function (data) {
                    addOption(data, "mtSel");
                });
        })

        search();
    })
    <!-- 返回上级 -->
    function back() {
        $("#right").load("<%=request.getContextPath()%>/mtRelation/mtRelationList?relType=${relType}");
    }
    function addMRDetail() {
        $("#dialog").load("<%=request.getContextPath()%>/mtRelation/editMRDetail?relId=${relId}");
        $("#dialog").modal("show");
    }

    function search() {
        var table =  $("#mRDetailGrid").DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "type": "post",
                "url": '<%=request.getContextPath()%>/mtRelation/getMRDList',
                "data": {
                    relId: '${relId}',
                    mtId: $("#mtSel").val(),
                    goodName: $("#goodNameSel").val(),
                }

            },
            "destroy": true,
            "columns": [
                {"data":"id","visible": false},
                {"data":"relId","visible": false},
                {"data":"mtId","visible": false},
                {"data":"mtFlag","visible": false},
                {"data": "goodName", "title": "物品名称"},
                {"data": "mtName", "title": "公物类别"},
                {"data": "goodNum", "title": "数量"},
                {"data": "goodUnit", "title": "单位"},
                {"data": "unitPrice", "title": "单价"},
                {"data": "goodPrice", "title": "金额"},
                {"data": "goodCase", "title": "物品使用情况"},
                {"data": "goodRemark", "title": "备注"},
                {
                    "title": "操作",
                    "render": function (data, type, row) {
                        return '<span class="icon-edit" title="修改" onclick=edit("' + row.id + '","'+row.mtFlag+'")/>&ensp;&ensp;' +
                            '<span class="icon-trash" title="删除" onclick=del("' + row.id + '")/>&ensp;&ensp;';
                    },
                    "width":"8%"
                }
            ],
            'order': [1, 'desc'],
            paging: true,
            "dom": 'rtlip',
            language: language
        })
    }

    function del(id){
        swal({
            title: "您确定要删除本条信息?",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            $.post("<%=request.getContextPath()%>/mtRelation/delMRDetail",{
                id:id
            }, function (msg) {
                if (msg.status == 1) {
                    swal({title: msg.msg,type: "success"});
                    $('#mRDetailGrid').DataTable().ajax.reload();
                }
            })
        });
    }

    function edit(id,mtFlag) {

        // if (mtFlag=="1"){
        //      swal( {title: "已维护无法进行修改",type: "warning"})
        // }else {
            $("#dialog").load("<%=request.getContextPath()%>/mtRelation/editMRDetail?id="+id);
            $("#dialog").modal("show");
        // }
    }

    <%--function mt(id, mtFlag) {--%>
        <%--if (mtFlag == "1") {--%>
            <%--swal({title: "已经过维护", type: "warning"})--%>
        <%--} else {--%>
            <%--swal({--%>
                <%--title: "您确定要维护本条信息?",--%>
                <%--type: "warning",--%>
                <%--showCancelButton: true,--%>
                <%--cancelButtonText: "取消",--%>
                <%--confirmButtonColor: "#DD6B55",--%>
                <%--confirmButtonText: "维护",--%>
                <%--closeOnConfirm: false--%>
            <%--}, function () {--%>
                <%--$.post("<%=request.getContextPath()%>/mtRelation/mtMRDetail", {--%>
                    <%--id: id--%>
                <%--}, function (msg) {--%>
                    <%--if (msg.status == 1) {--%>
                        <%--swal({title: msg.msg, type: "success"});--%>
                        <%--$('#mRDetailGrid').DataTable().ajax.reload();--%>
                    <%--}--%>
                <%--})--%>
            <%--})--%>
        <%--}--%>
    <%--}--%>

    function importMRDetailTemplate() {
        window.location.href = "<%=request.getContextPath()%>/mtRelation/export";
    }
    function importMRDetail() {
        $("#dialog").load("<%=request.getContextPath()%>/mtRelation/importMRDetail?relId=${relId}");
        $("#dialog").modal("show");
    }

</script>